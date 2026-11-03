package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Account;

@Mapper
public interface AccountMapper {
	int insert(Account account);
	
	int countByLoginId(@Param("loginId") String loginId);
}

