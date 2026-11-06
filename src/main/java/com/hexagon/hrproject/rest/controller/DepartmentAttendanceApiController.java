
package com.hexagon.hrproject.rest.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.hexagon.hrproject.dto.response.DepartmentAttendanceRow;
import com.hexagon.hrproject.service.DepartmentAttendanceService;

@Controller
@RequestMapping("/api/attendance")
public class DepartmentAttendanceApiController {

    private final DepartmentAttendanceService service;

    public DepartmentAttendanceApiController(
            DepartmentAttendanceService service) {
        this.service = service;
    }

    @GetMapping("/department")
    @ResponseBody
    public List<DepartmentAttendanceRow> getDepartmentAttendance(

            @RequestParam(required = false)
            Integer departmentId,

            @RequestParam
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate workDate,

            Authentication authentication) {

        if (authentication == null
                || !authentication.isAuthenticated()) {
            throw new ResponseStatusException(
                HttpStatus.UNAUTHORIZED
            );
        }

        // 실제 관리자 역할 코드와 일치하는지 확인 필요
        boolean isAdmin = hasAuthority(
            authentication, "ROLE_ADMIN"
        );

        boolean canReadTeam = hasAuthority(
            authentication, "PERMISSION_TEAM_MEMBER_READ"
        );

        if (!isAdmin && !canReadTeam) {
            throw new ResponseStatusException(
                HttpStatus.FORBIDDEN,
                "근태 조회 권한이 없습니다."
            );
        }

        Integer allowedDepartmentId = departmentId;

        // 팀 조회 권한만 있으면 본인 부서만 허용
        if (!isAdmin) {

            Integer myDepartmentId =
                service.findMyDepartmentId(
                    authentication.getName()
                );

            if (myDepartmentId == null) {
                throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN
                );
            }

            if (departmentId != null
                    && !departmentId.equals(myDepartmentId)) {
                throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN,
                    "다른 부서를 조회할 수 없습니다."
                );
            }

            allowedDepartmentId = myDepartmentId;
        }

        return service.findByDepartment(
            allowedDepartmentId,
            workDate
        );
    }

    private boolean hasAuthority(
            Authentication authentication,
            String authority) {

        return authentication.getAuthorities()
            .stream()
            .anyMatch(a ->
                authority.equals(a.getAuthority())
            );
    }
}
