
package com.hexagon.hrproject.rest.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.service.EmpService;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestEmployeeHomeController {

    private final EmpService empService;

    /*----------------------------------------
      1. 로그인한 사원의 정보 조회
    ----------------------------------------*/
    @GetMapping("/api/employees/me")
    public ResponseEntity<Emp> getMyInfo(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        // 로그인 여부 확인
        if (accountDetails == null) {
            throw new BusinessException(
                ErrorCode.LOGIN_REQUIRED
            );
        }

        // 로그인한 계정에 연결된 사원
        Emp loginEmp = accountDetails.getAccount().getEmp();

        if (loginEmp == null) {
            throw new BusinessException(
                ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED
            );
        }

        // DB에서 사원 정보 조회
        Emp emp = empService.findById(loginEmp.getEmpId());

        return ResponseEntity.ok(emp);
    }

    /*----------------------------------------
      2. 로그인한 사원의 이메일, 연락처 수정
    ----------------------------------------*/
    @PutMapping("/api/employees/me")
    public ResponseEntity<String> updateMyInfo(
            @AuthenticationPrincipal AccountDetails accountDetails,
            @RequestBody Emp emp) {

        // 로그인 여부 확인
        if (accountDetails == null) {
            throw new BusinessException(
                ErrorCode.LOGIN_REQUIRED
            );
        }

        // 로그인한 계정에 연결된 사원
        Emp loginEmp = accountDetails.getAccount().getEmp();

        if (loginEmp == null) {
            throw new BusinessException(
                ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED
            );
        }

        // 로그인한 사원의 정보만 수정
        empService.updateMyInfo(
            loginEmp.getEmpId(),
            emp.getEmail(),
            emp.getPhone()
        );

        return ResponseEntity.ok("내 정보가 수정되었습니다.");
    }
}
