package com.hexagon.hrproject.dto.response;

import lombok.Getter;
import lombok.Setter;

// 급여 등록 화면에서 사원을 선택할 때 필요한 정보만 전달한다.
@Getter
@Setter
public class SalaryEmployeeOption {
    private Long empId;
    private String employeeName;
}