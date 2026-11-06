package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LeaveController {
	@GetMapping("/leave")
	public String leavePage() {
		return "leave/leaveview";
	}
	
	@GetMapping("/leave/history")
	public String leaveHistoryPage() {
		return "leave/leaveHistory";
	}
	
	@GetMapping("/leave/apply")
	public String leaveApplyPage() {
		return "leave/leaveApply";
	}
	
	@GetMapping("/leave/admin")
	public String leaveAdminPage() {
		return "leave/adminleave";
	}
}
