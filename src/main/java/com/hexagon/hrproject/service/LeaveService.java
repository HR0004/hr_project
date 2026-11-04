package com.hexagon.hrproject.service;

import org.springframework.stereotype.Service;

import com.hexagon.hrproject.domain.LeaveBalance;
import com.hexagon.hrproject.mapper.LeaveMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LeaveService {
	private final LeaveMapper leaveMapper;
	
	public LeaveBalance findBalanceByEmpId(int empId, String fiscalYear) {
		return leaveMapper.findBalanceByEmpId(empId, fiscalYear);
	}
}
