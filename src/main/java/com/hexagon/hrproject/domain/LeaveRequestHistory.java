package com.hexagon.hrproject.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LeaveRequestHistory {
	private int leaveRequestId;
	private String submittedDate;
	private String startDate;
	private String endDate;
	private String leaveType;
	private BigDecimal days;
	private String status;
	private String remark;
}
