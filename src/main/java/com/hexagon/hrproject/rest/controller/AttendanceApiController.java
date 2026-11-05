
package com.hexagon.hrproject.rest.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.domain.Attendance;
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

    // 로그인한 사원 번호 가져오기
    private int getLoginEmpId(AccountDetails accountDetails) {

        if (accountDetails == null ||
                accountDetails.getAccount() == null) {

            throw new BusinessException(ErrorCode.LOGIN_REQUIRED);
        }

        if (accountDetails.getAccount().getEmp() == null) {

            throw new BusinessException(
                ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED
            );
        }

        return accountDetails.getAccount().getEmp().getEmpId();
    }

    // 나의 근태 현황 조회
    @GetMapping("/my")
    public List<Attendance> myAttendance(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        int empId = getLoginEmpId(accountDetails);

        return attendanceService.findByEmpId(empId);
    }

    // 출근하기
    @PostMapping(value = "/clock-in",
                 produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> clockIn(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        int empId = getLoginEmpId(accountDetails);

        int result = attendanceService.clockIn(empId);

        if (result == 0) {
            return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body("오늘은 이미 출근했습니다.");
        }

        return ResponseEntity.ok("출근 등록 완료");
    }

    // 퇴근하기
    @PostMapping(value = "/clock-out",
                 produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> clockOut(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        int empId = getLoginEmpId(accountDetails);

        int result = attendanceService.clockOut(empId);

        if (result == 0) {
            return ResponseEntity
                .status(HttpStatus.CONFLICT)
                .body("출근 기록이 없거나 이미 퇴근했습니다.");
        }

        return ResponseEntity.ok("퇴근 등록 완료");
    }
}
