package com.hexagon.hrproject.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Emp {
	private int empId;
	private String ename;
	private String email;
	private String phone;
	private Date hiredate;
	
	private int departmentId;
	private int jobId;
	private int hrPositionId;
	
	private String status;
	private int annualLeaveDays;
	
	//부서정보 
	private Department department;
	
	//직급 정보 
	private Job job;
}
