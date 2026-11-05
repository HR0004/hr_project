package com.hexagon.hrproject.domain;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Salary {

    private Long salaryId;
    private Long empId;
    // 조회 시 사원 테이블에서 가져오는 이름
    private String employeeName;
    private String salaryYearMonth;

    private BigDecimal baseSalary;
    private BigDecimal bonus;
    private BigDecimal deduction;
    private BigDecimal netSalary;

    private LocalDate paymentDate;
}