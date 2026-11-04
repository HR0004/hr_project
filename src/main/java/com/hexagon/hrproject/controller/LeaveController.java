package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LeaveController {
	@GetMapping("/leave")
	public String leavePage() {
		return "leave/leaveview";
	}
}
