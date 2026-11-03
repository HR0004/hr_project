package com.hexagon.hrproject.service;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

/*--------------------------------------------------------------------------------------------
 우리가 취득한 권한이 제대로 스프링에서 인식되는지 테스트 해보기
 PERMISSION_MY_INFO_READ 나의 정보 조회 - 무사히 통과가 예상됨(스프링이 가로 막지 않음)
 PERMISSION_ROLE_ASSIGN 권한 부여 권한 - 가로막힘이 예상됨
 ----------------------------------------------------------------------------------------------*/

@Service
public class AccountService {

	//나의 정보 조회(현재 유저가 보유한 여러 권한 중 아래의 권한이 포함되어 있다면 통과)
	@PreAuthorize("hasAuthority('PERMISSION_MY_INFO_READ')")
	public String getEmp(int empId) {
		return "My name is HyunSuk, and empId is"+empId;
	}
	
	//권한 부여
	@PreAuthorize("hasAuthority('PERMISSION_ROLE_ASSIGN')")
	public String addPermission() {
		return "Permission role assigned is successful";
	}
}
