package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeHomeController {

    // 사원 마이페이지
    @GetMapping("/employee/home")
    public String home() {
        return "employee/employeeHome";
    }

    // 사원 본인 정보 수정 화면
    @GetMapping("/employee/myedit")
    public String myEdit() {
        return "employee/employeeMyEdit";
    }
}