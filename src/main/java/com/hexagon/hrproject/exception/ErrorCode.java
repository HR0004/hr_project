package com.hexagon.hrproject.exception;

import lombok.Getter;

/* 열거형: 상수를 객체 차원으로 사용할 수 있는 자료형
		public static final int x=5;
		상수  = 복합 데이터(예외의 이름, 예외의 메시지.., Http Status code 200)
		Color.RED, Color.Yellow, HttpStatus.OK
*/

@Getter
public enum ErrorCode {

	// 뉴스 게시판 관련 상수
	NEWS_NOT_FOUND(404, "NEWS_NOT_FOUND", "뉴스기사를 찾을 수 없습니다."),
	NEWS_REGIST_FAIL(500, "NEWS_REGIST_FAIL", "뉴스기사를 등록할 수 없습니다."),
	NEWS_UPDATE_FAIL(500, "NEWS_NOT_FOUND", "뉴스기사를 수정할 수 없습니다."),
	NEWS_DELETE_FAIL(500, "NEWS_NOT_FOUND", "뉴스기사를 삭제할 수 없습니다."),
	UNAUTHORIZED_NEWS_ACCESS(500, "NEWS_NOT_FOUND", "뉴스기사에 대한 권한이 없습니다.");
	
	// 회원 관련 상수
	
	
	// 회원 관련 상수
	
	
	// 회원 관련 상수
	
	private final int status; // HTTP Status code 200, 500 등등..
	private final String code; // 에러코드
	private final String message; // 에러 메시지 ex) "등록 실패입니다."
	private ErrorCode(int status, String code, String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}
	
	
	
}

