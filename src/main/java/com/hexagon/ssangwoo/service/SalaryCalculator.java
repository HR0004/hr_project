package com.hexagon.ssangwoo.service;

import java.math.BigDecimal;

public class SalaryCalculator {

    public static BigDecimal calculate(
            BigDecimal baseSalary,
            BigDecimal bonus,
            BigDecimal deduction) {

        if (baseSalary == null || bonus == null || deduction == null) {
            throw new IllegalArgumentException("금액을 모두 입력하세요.");
        }

        if (baseSalary.signum() < 0
                || bonus.signum() < 0
                || deduction.signum() < 0) {
            throw new IllegalArgumentException("금액은 음수일 수 없습니다.");
        }

        return baseSalary.add(bonus).subtract(deduction);
    }

    public static void main(String[] args) {
        BigDecimal result = calculate(
                new BigDecimal("3000000"),
                new BigDecimal("200000"),
                new BigDecimal("150000")
        );

        System.out.println("실수령액: " + result.toPlainString() + "원");
    }
}