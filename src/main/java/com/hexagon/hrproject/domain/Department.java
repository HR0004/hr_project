package com.hexagon.hrproject.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Department {
	private int departmentId; 
	private String departmentCode;
	private String departmentName;
	private int isActive;
	private int employeeCount;
}
