package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.dto.response.SalaryEmployeeOption;

@Mapper
public interface SalaryMapper {

    // 급여 목록 조회
    List<Salary> selectAll();

    // 급여 번호로 상세 조회
    Salary selectById(@Param("salaryId") Long salaryId);

    // 급여 등록용 사원 이름과 번호 조회
    List<SalaryEmployeeOption> selectEmployeeOptions();

    // 급여를 등록할 사원이 실제로 존재하는지 확인
    int countEmployeeById(@Param("empId") Long empId);

    // 동일 사원·지급 연월의 급여 건수 조회
    int countByEmpAndYearMonth(
            @Param("empId") Long empId,
            @Param("salaryYearMonth") String salaryYearMonth);

    // 급여 등록
    int insert(Salary salary);
}
