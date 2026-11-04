package com.hexagon.hrproject.rest.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.domain.LeaveBalance;
import com.hexagon.hrproject.service.LeaveService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/leave")
@RequiredArgsConstructor
public class LeaveApiController {
	private final LeaveService leaveService;
	
	@GetMapping("/my/balance")
	public LeaveBalance getLeaveBalance() {
		int empId = 1;
		String fiscalYear = "2026";
		
		return leaveService.findBalanceByEmpId(empId, fiscalYear);
	}
}
