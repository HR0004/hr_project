package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hexagon.hrproject.domain.HrRole;

@Mapper
public interface PermissionMapper {

	HrRole selectByHrRoleId(int hrRoleId);
}
