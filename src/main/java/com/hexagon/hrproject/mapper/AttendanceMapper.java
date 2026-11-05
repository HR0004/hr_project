package com.hexagon.hrproject.mapper;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Attendance;

public interface AttendanceMapper {
	List<Attendance> findByEmpId(int empId);
	
	int insertClockIn(
	        @Param("empId") int empId,
	        @Param("workDate") Date workDate,
	        @Param("clockIn") Timestamp clockIn,
	        @Param("status") String status
	    );
	
	// 퇴근 등록
    int updateClockOut(
        @Param("empId") int empId,
        @Param("workDate") Date workDate,
        @Param("clockOut") Timestamp clockOut
    );
}
