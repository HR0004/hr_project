package com.hexagon.ssangwoo.service;

import lombok.RequiredArgsConstructor;
import com.hexagon.ssangwoo.exception.BusinessException;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.hexagon.ssangwoo.domain.Salary;
import com.hexagon.ssangwoo.dto.request.SalaryCreateRequest;
import com.hexagon.ssangwoo.mapper.SalaryMapper;

@Service
@RequiredArgsConstructor
public class SalaryService {

	private final SalaryMapper salaryMapper;

	// 인사 관리자용 급여 목록 조회
	@PreAuthorize("hasRole('HR_ADMIN')")
	public List<Salary> getSalaryList() {
		return salaryMapper.selectAll();
	}

	// 등록할 급여 정보 검사 및 실수령액 계산
	public Salary prepareSalary(SalaryCreateRequest request) {

		if (request == null) {
			throw new BusinessException("급여 정보를 입력하세요.");
		}

		if (request.getEmpId() == null || request.getEmpId() <= 0) {
			throw new BusinessException("사원을 선택하세요.");
		}

		String yearMonth = request.getSalaryYearMonth();

		if (yearMonth == null || !yearMonth.matches("[0-9]{4}-(0[1-9]|1[0-2])")) {
			throw new BusinessException("지급 연월을 yyyy-MM 형식으로 입력하세요.");
		}

		Salary salary = new Salary();

		salary.setEmpId(request.getEmpId());
		salary.setSalaryYearMonth(yearMonth);
		salary.setBaseSalary(request.getBaseSalary());
		salary.setBonus(request.getBonus());
		salary.setDeduction(request.getDeduction());
		salary.setPaymentDate(request.getPaymentDate());

		salary.setNetSalary(
				SalaryCalculator.calculate(request.getBaseSalary(), request.getBonus(), request.getDeduction()));

		return salary;
	}

	// 급여 등록 처리
	@PreAuthorize("hasRole('HR_ADMIN')")
	@Transactional
	public Long createSalary(SalaryCreateRequest request) {

		Salary salary = prepareSalary(request);

		int count = salaryMapper.countByEmpAndYearMonth(salary.getEmpId(), salary.getSalaryYearMonth());

		if (count > 0) {
			throw new BusinessException("해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.");
		}

		int result = salaryMapper.insert(salary);

		if (result != 1) {
			throw new BusinessException("급여 등록에 실패했습니다.");
		}

		return salary.getSalaryId();
	}

}