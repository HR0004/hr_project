package com.hexagon.hrproject.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;

import org.springframework.stereotype.Service;

import com.hexagon.hrproject.domain.Attendance;
import com.hexagon.hrproject.mapper.AttendanceMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {
	private final AttendanceMapper attendanceMapper;

	private static final ZoneId KOREA = ZoneId.of("Asia/Seoul");

	public List<Attendance> findByEmpId(int empId) {
		return attendanceMapper.findByEmpId(empId);
	}

	public int clockIn(int empId) {

		LocalDateTime now = LocalDateTime.now(KOREA);

		String status = now.toLocalTime().isAfter(LocalTime.of(9, 0)) ? "LATE" : "NORMAL";

		return attendanceMapper.insertClockIn(empId, Date.valueOf(now.toLocalDate()), Timestamp.valueOf(now), status);
	}
	
	public int clockOut(int empId) {

        LocalDateTime now = LocalDateTime.now(KOREA);

        return attendanceMapper.updateClockOut(
            empId,
            Date.valueOf(now.toLocalDate()),
            Timestamp.valueOf(now)
        );
    }
}
