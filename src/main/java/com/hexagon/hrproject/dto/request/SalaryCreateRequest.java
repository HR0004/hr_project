package com.hexagon.hrproject.dto.request;

import java.math.BigDecimal;
import java.time.LocalDate;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SalaryCreateRequest {

    @NotNull(message = "사원을 선택하세요.")
    @Min(value = 1, message = "사원 번호는 1 이상이어야 합니다.")
    private Long empId;

    @NotBlank(message = "지급 연월을 입력하세요.")
    @Pattern(
        regexp = "[0-9]{4}-(0[1-9]|1[0-2])",
        message = "지급 연월은 yyyy-MM 형식이어야 합니다."
    )
    private String salaryYearMonth;

    @NotNull(message = "기본급을 입력하세요.")
    @DecimalMin(value = "0", message = "기본급은 음수일 수 없습니다.")
    @Digits(integer = 15, fraction = 0,
            message = "기본급은 15자리 이내의 정수로 입력하세요.")
    private BigDecimal baseSalary;

    @NotNull(message = "수당을 입력하세요.")
    @DecimalMin(value = "0", message = "수당은 음수일 수 없습니다.")
    @Digits(integer = 15, fraction = 0,
            message = "수당은 15자리 이내의 정수로 입력하세요.")
    private BigDecimal bonus;

    @NotNull(message = "공제액을 입력하세요.")
    @DecimalMin(value = "0", message = "공제액은 음수일 수 없습니다.")
    @Digits(integer = 15, fraction = 0,
            message = "공제액은 15자리 이내의 정수로 입력하세요.")
    private BigDecimal deduction;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate paymentDate;
}