package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hexagon.hrproject.domain.Account;

@Mapper
public interface HrRoleMapper {

	Account selectByAccountId(int accountId);
}
