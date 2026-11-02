package com.hexagon.joo.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Job {
	private int jobId; 
	private String jobCode;
	private String jobName;
	private int isActive;
}
