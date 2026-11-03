
package com.hexagon.kuma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.hexagon.kuma.domain.Emp;
import com.hexagon.kuma.service.EmpService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmpController {

	private final EmpService empService;
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
            @PathVariable int empId, Model model) {
    	
    	//1.사원 정보 조회
    	Emp emp = empService.findById(empId);
    	
    	//2.JSP에 사원 정보 전달
        model.addAttribute("emp", emp);
        
        //3.수정 화면 반환
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
