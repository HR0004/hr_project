package com.hexagon.hrproject.mapper;

import java.util.List;

import com.hexagon.hrproject.domain.Attendance;

public interface AttendanceMapper {
	List<Attendance> findByEmpId(int empId);
}
