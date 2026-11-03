package com.hexagon.kuma.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HrRole {
	private int hrRoleId;
	private String roleCode;
	private String roleName;
	private int isActive;
	   
	   private List<Permission> permissions;
	}
