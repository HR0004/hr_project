package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hexagon.hrproject.domain.Attendance;
import com.hexagon.hrproject.mapper.AttendanceMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {
	private final AttendanceMapper attendanceMapper;
	
	public List<Attendance> findByEmpId(int empId){
		return attendanceMapper.findByEmpId(empId);
	}
}
