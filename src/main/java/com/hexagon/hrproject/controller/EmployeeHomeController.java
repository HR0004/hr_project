package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeHomeController {

	//사원 마이 페이지
	@GetMapping("/employee/home")
	public String home() {
		return "employee/employeeHome";
	}
}
 