package com.hexagon.hrproject.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Admin {
	private int adminId;
	private String loginId;
	private String password;
	private String name;
}
