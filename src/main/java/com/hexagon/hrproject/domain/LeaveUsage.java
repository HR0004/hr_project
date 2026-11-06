package com.hexagon.hrproject.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LeaveUsage {
	private String startDate;
	private String endDate;
	private String leaveType;
	private BigDecimal days;
	private String status;
}
