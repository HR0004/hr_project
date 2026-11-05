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
	DEPARTMENT_ALREADY_EXISTS(409, "DEPARTMENT_ALREADY_EXISTS", "부서가 이미 존재합니다. 등록할 수 없습니다."),

	// 직급 관련 상수
	JOB_NOT_FOUND(404, "JOB_NOT_FOUND", "직급을 찾을 수 없습니다."), JOB_NAME_REQUIRED(400, "JOB_NAME_REQUIRED", "직급명을 입력하세요."),
	JOB_REGIST_FAIL(500, "JOB_REGIST_FAIL", "직급 등록에 실패했습니다."),
	JOB_UPDATE_FAIL(500, "JOB_UPDATE_FAIL", "직급 수정에 실패했습니다."),
	JOB_DELETE_FAIL(500, "JOB_DELETE_FAIL", "직급 비활성화에 실패했습니다."),
	JOB_ALREADY_INACTIVE(409, "JOB_ALREADY_INACTIVE", "이미 비활성화된 직급입니다."),
	JOB_INACTIVE_UPDATE(409, "JOB_INACTIVE_UPDATE", "비활성 직급은 수정할 수 없습니다."),
	JOB_CODE_GENERATION_FAIL(500, "JOB_CODE_GENERATION_FAIL", "직급 코드 생성에 실패했습니다."),
	JOB_ALREADY_EXISTS(409, "JOB_ALREADY_EXISTS", "직급이 이미 존재합니다. 등록할 수 없습니다."),

	UNAUTHORIZED_DEPARTMENT_ACCESS(500, "DEPARTMENT_NOT_FOUND", "부서에 대한 권한이 없습니다."),

	// 사원 관련
	EMPLOYEE_NOT_FOUND(404, "EMPLOYEE_NOT_FOUND", "사원 정보를 찾을 수 없습니다."),
	EMPLOYEE_NAME_REQUIRED(400, "EMPLOYEE_NAME_REQUIRED", "사원 이름을 입력해 주세요."),
	EMPLOYEE_EMAIL_REQUIRED(400, "EMPLOYEE_EMAIL_REQUIRED", "이메일을 입력해 주세요."),
	EMPLOYEE_EMAIL_INVALID(400, "EMPLOYEE_EMAIL_INVALID", "올바른 이메일 형식이 아닙니다."),
	EMPLOYEE_REGIST_FAIL(500, "EMPLOYEE_REGIST_FAIL", "사원 등록에 실패했습니다."),
	EMPLOYEE_UPDATE_FAIL(500, "EMPLOYEE_UPDATE_FAIL", "사원 정보 수정에 실패했습니다."),
	EMPLOYEE_RETIRE_FAIL(409, "EMPLOYEE_RETIRE_FAIL", "사원을 퇴사 처리할 수 없습니다."),

	// 계정 관련
	ACCOUNT_NOT_FOUND(404, "ACCOUNT_NOT_FOUND", "계정을 찾을 수 없습니다."),
	PASSWORD_REQUIRED(400, "PASSWORD_REQUIRED", "비밀번호를 입력해 주세요."),
	CURRENT_PASSWORD_MISMATCH(400, "CURRENT_PASSWORD_MISMATCH", "현재 비밀번호가 일치하지 않습니다."),
	PASSWORD_TOO_SHORT(400, "PASSWORD_TOO_SHORT", "새 비밀번호는 8자 이상이어야 합니다."),
	PASSWORD_SAME_AS_CURRENT(400, "PASSWORD_SAME_AS_CURRENT", "기존 비밀번호와 다른 비밀번호를 입력해 주세요."),
	PASSWORD_UPDATE_FAIL(500, "PASSWORD_UPDATE_FAIL", "비밀번호 변경에 실패했습니다."),
	LOGIN_ID_REQUIRED(400, "LOGIN_ID_REQUIRED", "로그인 ID를 입력해 주세요."),
	LOGIN_ID_DUPLICATED(409, "LOGIN_ID_DUPLICATED", "이미 사용 중인 로그인 ID입니다."),

	// 로그인 상태 관련
	LOGIN_REQUIRED(401, "LOGIN_REQUIRED", "로그인이 필요합니다."),
	EMPLOYEE_ACCOUNT_NOT_LINKED(404, "EMPLOYEE_ACCOUNT_NOT_LINKED", "계정에 연결된 사원 정보가 없습니다."),

	INVALID_INPUT(500, "INVALID_INPUT", "접근할 수 없습니다.");

	private final int status; // HTTP Status code 200, 500 등등..
	private final String code; // 에러코드
	private final String message; // 에러 메시지 ex) "등록 실패입니다."

	private ErrorCode(int status, String code, String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}

}
