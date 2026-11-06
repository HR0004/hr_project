package com.hexagon.hrproject.rest.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.service.AttendanceService;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/attendance")
@RequiredArgsConstructor
public class AttendanceApiController {

    private final AttendanceService attendanceService;

    @GetMapping("/my")
    public List<?> myAttendance(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        // 로그인 여부 확인
        if (accountDetails == null
                || accountDetails.getAccount() == null) {

            throw new BusinessException(
                ErrorCode.LOGIN_REQUIRED
            );
        }

        // 로그인한 계정에 연결된 사원 확인
        Emp loginEmp = accountDetails.getAccount().getEmp();

        if (loginEmp == null) {
            throw new BusinessException(
                ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED
            );
        }

        // 로그인한 본인의 근태만 조회
        return attendanceService.findByEmpId(
            loginEmp.getEmpId()
        );
    }
}