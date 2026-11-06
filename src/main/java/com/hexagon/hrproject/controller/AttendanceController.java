package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hexagon.hrproject.service.AttendanceService;

import lombok.RequiredArgsConstructor;

@Controller
//@RequiredArgsConstructor
public class AttendanceController {
	//private final AttendanceService attendanceService;
	
	@GetMapping("/attendance")
	//public String attendancePage(Model model) {
	public String attendancePage() {
		
		//int empId = 1;
		
		//model.addAttribute("records", attendanceService.findByEmpId(empId));
		
		return "attendance/attendview";
	}
	
	@GetMapping("/attendance/monthly")
	public String attendanceMonthlyPage() {
		return "attendance/attendMonthly";
	}
	
	@GetMapping("/attendance/admin")
	public String attendanceAdminPage() {
		return "attendance/admindepartmentattendance";
	}
}
