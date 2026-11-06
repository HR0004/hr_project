
package com.hexagon.hrproject.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.hexagon.hrproject.dto.response.DepartmentAttendanceRow;
import com.hexagon.hrproject.mapper.DepartmentAttendanceMapper;

@Service
public class DepartmentAttendanceService {

    private final DepartmentAttendanceMapper mapper;

    public DepartmentAttendanceService(
            DepartmentAttendanceMapper mapper) {
        this.mapper = mapper;
    }

    public Integer findMyDepartmentId(String loginId) {
        return mapper.findDepartmentIdByLoginId(loginId);
    }

    public List<DepartmentAttendanceRow> findByDepartment(
            Integer departmentId,
            LocalDate workDate) {

        return mapper.findDepartmentAttendance(
            departmentId,
            workDate
        );
    }
}
