package com.hexagon.hrproject.service;

import java.math.BigDecimal;
import org.springframework.dao.DuplicateKeyException;
import lombok.RequiredArgsConstructor;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.dto.response.SalaryEmployeeOption;
import com.hexagon.hrproject.mapper.SalaryMapper;

@Service
@RequiredArgsConstructor
public class SalaryService {

	private final SalaryMapper salaryMapper;

	// 급여 등록 화면의 사원 선택 목록
	@PreAuthorize("hasRole('HR_ADMIN')")
	public List<SalaryEmployeeOption> getEmployeeOptions() {
		return salaryMapper.selectEmployeeOptions();
	}

	// 인사 관리자용 급여 목록 조회
	@PreAuthorize("hasRole('HR_ADMIN')")
	public List<Salary> getSalaryList() {
		return salaryMapper.selectAll();
	}

	// 지급 연월과 사원 이름 일부 또는 번호로 검색한다.
	@PreAuthorize("hasRole('HR_ADMIN')")
	public List<Salary> getSalaryList(String salaryYearMonth, String employeeKeyword) {
		String month = salaryYearMonth == null ? "" : salaryYearMonth.trim();
		String keyword = employeeKeyword == null ? "" : employeeKeyword.trim();
		if (!month.isEmpty() && !month.matches("[0-9]{4}-(0[1-9]|1[0-2])")) {
			throw new SalaryBusinessException("지급 연월은 yyyy-MM 형식으로 입력하세요.");
		}
		if (keyword.length() > 50) {
			throw new SalaryBusinessException("사원 검색어는 50자 이내로 입력하세요.");
		}
		if (month.isEmpty() && keyword.isEmpty()) {
			return salaryMapper.selectAll();
		}
		Long employeeId = null;
		if (keyword.matches("[0-9]+")) {
			try {
				long number = Long.parseLong(keyword);
				if (number > 0) employeeId = number;
			} catch (NumberFormatException ignored) {
				// 번호 범위를 넘는 숫자도 이름 검색어로 처리한다.
			}
		}
		return salaryMapper.selectByFilters(month, keyword, employeeId);
	}

	// 인사 관리자용 급여 상세 조회
	@PreAuthorize("hasRole('HR_ADMIN')")
	public Salary getSalaryDetail(Long salaryId) {
		if (salaryId == null || salaryId <= 0) {
			throw new SalaryNotFoundException();
		}
		Salary salary = salaryMapper.selectById(salaryId);
		if (salary == null) {
			throw new SalaryNotFoundException();
		}
		return salary;
	}

	// 등록할 급여 정보 검사 및 실수령액 계산
	public Salary prepareSalary(SalaryCreateRequest request) {

		if (request == null) {
			throw new SalaryBusinessException("급여 정보를 입력하세요.");
		}

		if (request.getEmpId() == null || request.getEmpId() <= 0) {
			throw new SalaryBusinessException("사원을 선택하세요.");
		}

		String yearMonth = request.getSalaryYearMonth();

		if (yearMonth == null || !yearMonth.matches("[0-9]{4}-(0[1-9]|1[0-2])")) {
			throw new SalaryBusinessException("지급 연월을 yyyy-MM 형식으로 입력하세요.");
		}

		Salary salary = new Salary();

		salary.setEmpId(request.getEmpId());
		salary.setSalaryYearMonth(yearMonth);
		salary.setBaseSalary(request.getBaseSalary());
		salary.setBonus(request.getBonus());
		salary.setDeduction(request.getDeduction());
		salary.setPaymentDate(request.getPaymentDate());

		BigDecimal netSalary = SalaryCalculator.calculate(
		        request.getBaseSalary(),
		        request.getBonus(),
		        request.getDeduction());

		// DB의 DECIMAL(15, 0)에 저장 가능한 금액인지 확인
		if (netSalary.abs().compareTo(new BigDecimal("999999999999999")) > 0) {
		    throw new SalaryBusinessException(
		            "실수령액은 15자리 이내의 금액이어야 합니다.");
		}

		salary.setNetSalary(netSalary);

		return salary;
	}

	// 급여 등록 처리
	@PreAuthorize("hasRole('HR_ADMIN')")
	@Transactional
	public Long createSalary(SalaryCreateRequest request) {

		Salary salary = prepareSalary(request);

		if (salaryMapper.countEmployeeById(salary.getEmpId()) == 0) {
			throw new SalaryBusinessException("존재하지 않는 사원 번호입니다. 사원 번호를 확인하세요.");
		}

		int count = salaryMapper.countByEmpAndYearMonth(salary.getEmpId(), salary.getSalaryYearMonth());

		if (count > 0) {
			throw new SalaryBusinessException("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.");
		}

		int result;
		try {
			result = salaryMapper.insert(salary);
		} catch (DuplicateKeyException ex) {
			// UNIQUE(emp_id, salary_year_month) 적용 시 동시 등록 충돌도 안내한다.
			throw new SalaryBusinessException(
					"해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.", ex);
		}

		if (result != 1) {
			throw new SalaryBusinessException("급여 등록에 실패했습니다.");
		}

		return salary.getSalaryId();
	}

}
