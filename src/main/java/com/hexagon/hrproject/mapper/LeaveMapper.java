package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.LeaveBalance;
import com.hexagon.hrproject.domain.LeaveRequestHistory;
import com.hexagon.hrproject.domain.LeaveUsage;

public interface LeaveMapper {
	// 나의 휴가 잔액
	LeaveBalance findBalanceByEmpId(@Param("empId") int empId, @Param("fiscalYear") String fiscalYear);

	// 나의 휴가 사용 내역
	List<LeaveUsage> findUsedLeaveByEmpId(@Param("empId") int empId);
	
	List<LeaveRequestHistory> findRequestHistoryByEmpId(
		    @Param("empId") int empId
		);
	
	int insertLeaveRequest(
		    @Param("empId") int empId,
		    @Param("startDate") java.sql.Date startDate,
		    @Param("endDate") java.sql.Date endDate,
		    @Param("days") java.math.BigDecimal days,
		    @Param("reason") String reason
		);
}
