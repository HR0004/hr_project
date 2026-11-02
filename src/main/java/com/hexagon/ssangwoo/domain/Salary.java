package com.hexagon.ssangwoo.domain;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Salary {

    private Long salaryId;
    private Long empId;
    private String salaryYearMonth;

    private BigDecimal baseSalary;
    private BigDecimal bonus;
    private BigDecimal deduction;
    private BigDecimal netSalary;

    private LocalDate paymentDate;
}