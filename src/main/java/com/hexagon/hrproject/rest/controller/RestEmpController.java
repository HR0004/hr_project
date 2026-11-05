
package com.hexagon.hrproject.rest.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.common.web.Pager;
import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.service.EmpService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestEmpController {

    private final EmpService empService;

    /*----------------------------------------
      1. 사원 전체 조회
    ----------------------------------------*/
    @GetMapping("/api/employees")
    public List<Emp> findAll() {

        return empService.findAll();
    }

    /*----------------------------------------
      2. 사원 상세 조회
    ----------------------------------------*/
    @GetMapping("/api/employees/{empId}")
    public ResponseEntity<Emp> findById(
            @PathVariable int empId) {

        Emp emp = empService.findById(empId);

        return ResponseEntity.ok(emp);
    }

    /*----------------------------------------
      3. 신규 사원 + 로그인 계정 등록
    ----------------------------------------*/
    @PostMapping("/api/employees/register")
    public ResponseEntity<String> regist(
            @RequestBody Account account) {

        empService.register(account);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body("사원 및 계정 등록 성공");
    }

    /*----------------------------------------
      4. 사원 정보 수정
    ----------------------------------------*/
    @PutMapping("/api/employees/{empId}")
    public ResponseEntity<String> update(
            @PathVariable int empId,
            @RequestBody Emp emp) {

        // URL에서 전달받은 사번 설정
        emp.setEmpId(empId);

        // Service 호출
        empService.update(emp);

        return ResponseEntity.ok("사원 정보 수정 성공");
    }

    /*----------------------------------------
      5. 사원 퇴사 처리
    ----------------------------------------*/
    @PatchMapping("/api/employees/{empId}/retire")
    public ResponseEntity<String> retire(
            @PathVariable int empId) {

        // Service 호출
        empService.retire(empId);

        return ResponseEntity.ok("퇴사 처리 성공");
    }

    /*----------------------------------------
      6. 사원 목록 페이지 처리
    ----------------------------------------*/
    @GetMapping("/api/employees/page")
    public ResponseEntity<Pager> getEmployeePage(
            HttpServletRequest request) {

        Pager pager = empService.getEmpPage(request);

        return ResponseEntity.ok(pager);
    }
}
