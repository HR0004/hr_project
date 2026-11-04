package com.hexagon.hrproject.rest.controller;

import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.hexagon.hrproject.service.AttendanceService;

import lombok.RequiredArgsConstructor;

/** 근태 목록 JSON 조회 API. empId=1은 로컬 기능 테스트용으로만 사용. */
@RestController
@RequestMapping("/api/attendance")
@RequiredArgsConstructor
public class AttendanceApiController {

    private final AttendanceService attendanceService;

    @GetMapping("/my")
    public List<?> myAttendance() {
        // 실제 서비스에서는 로그인한 사원 ID를 인증 정보로부터 조회해야 합니다.
        int empId = 1;
        return attendanceService.findByEmpId(empId);
    }
}
