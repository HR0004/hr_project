package com.hexagon.hrproject.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DepartmentAttendanceRow {
	private Integer empId;
    private String name;
    private Integer departmentId;
    private String date;
    private String clockIn;
    private String clockOut;
    private String status;
    private String note;
}
