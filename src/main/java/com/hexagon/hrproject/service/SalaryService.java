package com.hexagon.hrproject.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.dto.response.SalaryEmployeeOption;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import com.hexagon.hrproject.mapper.SalaryMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SalaryService {

    private final SalaryMapper salaryMapper;

    // 1. 급여 등록용 사원 목록 조회
    public List<SalaryEmployeeOption> getEmployeeOptions() {
        return salaryMapper.selectEmployeeOptions();
    }

    // 2. 전체 급여 목록 조회
    public List<Salary> getSalaryList() {
        return salaryMapper.selectAll();
    }

    // 3. 급여 검색
    public List<Salary> getSalaryList(
            String salaryYearMonth,
            String employeeKeyword) {

        String month = salaryYearMonth == null
                ? "" : salaryYearMonth.trim();

        String keyword = employeeKeyword == null
                ? "" : employeeKeyword.trim();

        // 지급 연월 형식 검사
        if (!month.isEmpty()
                && !month.matches("[0-9]{4}-(0[1-9]|1[0-2])")) {

            throw new SalaryBusinessException(
                    "지급 연월은 yyyy-MM 형식으로 입력하세요.");
        }

        // 검색어 길이 검사
        if (keyword.length() > 50) {
            throw new SalaryBusinessException(
                    "사원 검색어는 50자 이내로 입력하세요.");
        }

        // 검색 조건이 없으면 전체 조회
        if (month.isEmpty() && keyword.isEmpty()) {
            return salaryMapper.selectAll();
        }

        Long employeeId = null;

        // 숫자로 검색하면 사번 검색도 가능
        if (keyword.matches("[0-9]+")) {
            try {
                long number = Long.parseLong(keyword);

                if (number > 0) {
                    employeeId = number;
                }

            } catch (NumberFormatException e) {
                // 숫자 범위를 초과하면 일반 검색어로 처리
            }
        }

        return salaryMapper.selectByFilters(
                month, keyword, employeeId);
    }

    // 4. 급여 상세 조회
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

    // 5. 급여 등록 전 데이터 준비 및 실수령액 계산
    public Salary prepareSalary(SalaryCreateRequest request) {

        if (request == null) {
            throw new SalaryBusinessException(
                    "급여 정보를 입력하세요.");
        }

        // 사원 번호 검사
        if (request.getEmpId() == null
                || request.getEmpId() <= 0) {

            throw new SalaryBusinessException(
                    "사원을 선택하세요.");
        }

        // 지급 연월 검사
        String yearMonth = request.getSalaryYearMonth();

        if (yearMonth == null
                || !yearMonth.matches(
                        "[0-9]{4}-(0[1-9]|1[0-2])")) {

            throw new SalaryBusinessException(
                    "지급 연월은 yyyy-MM 형식으로 입력하세요.");
        }

        // 금액 필수 입력 검사
        if (request.getBaseSalary() == null
                || request.getBonus() == null
                || request.getDeduction() == null) {

            throw new SalaryBusinessException(
                    "기본급, 수당, 공제액을 모두 입력하세요.");
        }

        // 음수 검사
        if (request.getBaseSalary().signum() < 0
                || request.getBonus().signum() < 0
                || request.getDeduction().signum() < 0) {

            throw new SalaryBusinessException(
                    "금액은 음수일 수 없습니다.");
        }

        // DB DECIMAL(15,0) 범위 검사
        BigDecimal maxAmount =
                new BigDecimal("999999999999999");

        if (request.getBaseSalary().scale() > 0
                || request.getBonus().scale() > 0
                || request.getDeduction().scale() > 0) {

            throw new SalaryBusinessException(
                    "금액은 정수로 입력하세요.");
        }

        if (request.getBaseSalary().compareTo(maxAmount) > 0
                || request.getBonus().compareTo(maxAmount) > 0
                || request.getDeduction().compareTo(maxAmount) > 0) {

            throw new SalaryBusinessException(
                    "금액은 15자리 이내로 입력하세요.");
        }

        // 실수령액 계산
        BigDecimal netSalary = SalaryCalculator.calculate(
                request.getBaseSalary(),
                request.getBonus(),
                request.getDeduction()
        );

        if (netSalary.abs().compareTo(maxAmount) > 0) {
            throw new SalaryBusinessException(
                    "실수령액은 15자리 이내의 금액이어야 합니다.");
        }

        // Salary 도메인 객체 생성
        Salary salary = new Salary();

        salary.setEmpId(request.getEmpId());
        salary.setSalaryYearMonth(yearMonth);
        salary.setBaseSalary(request.getBaseSalary());
        salary.setBonus(request.getBonus());
        salary.setDeduction(request.getDeduction());
        salary.setNetSalary(netSalary);
        salary.setPaymentDate(request.getPaymentDate());

        return salary;
    }

    // 6. 급여 등록
    @Transactional
    public Long createSalary(SalaryCreateRequest request) {

        // 입력값 검사 및 실수령액 계산
        Salary salary = prepareSalary(request);

        // 사원 존재 여부 확인
        if (salaryMapper.countEmployeeById(
                salary.getEmpId()) == 0) {

            throw new SalaryBusinessException(
                    "존재하지 않는 사원 번호입니다.");
        }

        // 같은 사원의 동일 지급 연월 중복 검사
        int count = salaryMapper.countByEmpAndYearMonth(
                salary.getEmpId(),
                salary.getSalaryYearMonth()
        );

        if (count > 0) {
            throw new SalaryBusinessException(
                    "해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.");
        }

        int result;

        try {
            result = salaryMapper.insert(salary);

        } catch (DuplicateKeyException e) {
            throw new SalaryBusinessException(
                    "해당 사원의 같은 지급 연월 급여가 이미 등록되어 있습니다.",
                    e
            );
        }

        // 등록 성공 여부 확인
        if (result != 1) {
            throw new SalaryBusinessException(
                    "급여 등록에 실패했습니다.");
        }

        // 새로 생성된 급여 ID 반환
        return salary.getSalaryId();
    }

 // =========================================
 // 7. 본인 급여 목록 조회
 // =========================================
 public List<Salary> getMySalaryList(Long empId, String year) {

     if (empId == null || empId <= 0) {
         throw new SalaryBusinessException(
                 "사원 정보를 확인할 수 없습니다.");
     }

     String searchYear = year == null ? "" : year.trim();

     // 연도 형식 검사
     if (!searchYear.isEmpty()
             && !searchYear.matches("[0-9]{4}")) {

         throw new SalaryBusinessException(
                 "조회 연도는 yyyy 형식으로 입력하세요.");
     }

     return salaryMapper.selectMySalaries(empId, searchYear);
 }


 // =========================================
 // 8. 본인 급여 상세 조회
 // =========================================
 public Salary getMySalaryDetail(Long empId, Long salaryId) {

     if (empId == null || empId <= 0
             || salaryId == null || salaryId <= 0) {

         throw new SalaryNotFoundException();
     }

     Salary salary = salaryMapper.selectMySalaryDetail(
             empId, salaryId);

     if (salary == null) {
         throw new SalaryNotFoundException();
     }

     return salary;
 }

    
}