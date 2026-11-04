package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Salary;

@Mapper
public interface SalaryMapper {

    // 급여 목록 조회
    List<Salary> selectAll();

    // 급여 번호로 상세 조회
    Salary selectById(@Param("salaryId") Long salaryId);

    // 동일 사원·지급 연월의 급여 건수 조회
    int countByEmpAndYearMonth(
            @Param("empId") Long empId,
            @Param("salaryYearMonth") String salaryYearMonth);

    // 급여 등록
    int insert(Salary salary);
}
