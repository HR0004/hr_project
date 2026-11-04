package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.LeaveBalance;

public interface LeaveMapper {
	LeaveBalance findBalanceByEmpId(@Param("empId") int empId, @Param("fiscalYear") String fiscalYear);
}
