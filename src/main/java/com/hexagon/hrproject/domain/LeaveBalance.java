package com.hexagon.hrproject.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LeaveBalance {
	private int balanceId;
	private int empId;
	private String fiscalYear;
	private BigDecimal totalDays;
	private BigDecimal usedDays;
	private BigDecimal remainingDays;
}
