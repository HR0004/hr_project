package com.hexagon.hrproject.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class EmpController {

    // 사원 목록
    @GetMapping("/employees")
    public String employeeList() {
        return "employee/employeeList";
    }

    // 사원 상세 조회
    @GetMapping("/employees/{empId}")
    public String employeeDetail(
            @PathVariable String empId, Model model) {

        model.addAttribute("empId", empId);
        return "employee/employeeDetail";
    }

    // 사원 정보 수정
    @GetMapping("/employees/{empId}/edit")
    public String employeeEdit(
            @PathVariable String empId, Model model) {

        model.addAttribute("empId", empId);
        return "employee/employeeEdit";
    }

    // 사원 등록
    @GetMapping("/employees/new")
    public String employeeRegister() {
        return "employee/employeeRegister";
    }
    
    //사원 검색 화면
    @GetMapping("/employees/search")
    public String employeeSearch() {
    	return "employee/employeeSearch";
    }
}
