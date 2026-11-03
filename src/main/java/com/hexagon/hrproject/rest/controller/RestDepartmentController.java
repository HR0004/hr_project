package com.hexagon.hrproject.rest.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.common.response.ApiResponse;
import com.hexagon.hrproject.domain.Department;
import com.hexagon.hrproject.dto.DepartmentDTO;
import com.hexagon.hrproject.service.DepartmentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestDepartmentController {

	private final DepartmentService departmentService;
	
	@PostMapping("/api/departments")
	public ResponseEntity<ApiResponse<Void>> regist(@RequestBody DepartmentDTO departmentDTO) { // @RequestBody 사용해되긴함 (HTTP 요청 본문에 담긴 JSON 등을 Java 객체로 변환할 때 필요한 어노테이션)
		
		departmentService.regist(departmentDTO);
		
		ApiResponse<Void> response = ApiResponse.success("부서 등록 성공", null);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}
	
	@GetMapping("/api/departments")
	public ResponseEntity<ApiResponse<List<Department>>> getList() {
		
		List<Department> departmentList = departmentService.getList();
		
		ApiResponse<List<Department>> response = ApiResponse.success("부서 목록 가져오기 성공", departmentList);
		
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	
}