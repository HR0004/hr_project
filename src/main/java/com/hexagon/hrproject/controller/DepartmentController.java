package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DepartmentController {
	
	// 부서 등록 화면
	@GetMapping("/departments/new")
	public String departmentRegister() {
		return "department/register";
	}

    // 부서 목록 화면
    @GetMapping("/departments")
    public String departmentList() {
        return "department/list";
    }

    // 부서 수정 화면
    @GetMapping("/departments/edit")
    public String departmentEdit() {
        return "department/edit";
    }
}


