package com.hexagon.hrproject.exception;

import lombok.Getter;

/* 열거형: 상수를 객체 차원으로 사용할 수 있는 자료형
		public static final int x=5;
		상수  = 복합 데이터(예외의 이름, 예외의 메시지.., Http Status code 200)
		Color.RED, Color.Yellow, HttpStatus.OK
*/

@Getter
public enum ErrorCode {

	// 부서 관련 상수
	DEPARTMENT_NOT_FOUND(404, "DEPARTMENT_NOT_FOUND", "부서명을 입력하세요."),
	DEPARTMENT_NAME_REQUIRED(404, "DEPARTMENT_NAME_REQUIRED", "부서명을 찾을 수 없습니다."),
	DEPARTMENT_REGIST_FAIL(500, "DEPARTMENT_REGIST_FAIL", "부서를 찾을 수 없습니다."),
	DEPARTMENT_UPDATE_FAIL(500, "DEPARTMENT_UPDATE_FAIL", "부서 수정에 실패했습니다."),
	DEPARTMENT_DELETE_FAIL(500, "DEPARTMENT_DELETE_FAIL", "부서 비활성화에 실패했습니다."),
	UNAUTHORIZED_DEPARTMENT_ACCESS(500, "DEPARTMENT_NOT_FOUND", "부서에 대한 권한이 없습니다.");
	
	
	private final int status; // HTTP Status code 200, 500 등등..
	private final String code; // 에러코드
	private final String message; // 에러 메시지 ex) "등록 실패입니다."
	private ErrorCode(int status, String code, String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}
	
	
	
}

