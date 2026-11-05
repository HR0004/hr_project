package com.hexagon.hrproject.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.hexagon.hrproject.common.response.ApiResponse;

// 비동기 요청에 대한 모든 예외를 처리할 수 있는 컨트롤러 어드바이스
@RestControllerAdvice(basePackages = "com.hexagon.hrproject.rest.controller") // @RestController 에서 발생한 모든 예외를 여기서
																				// 잡아준다!!
public class RestGlobalExceptionHandler {
	/*-----------------------------------------
	예외 처리 전략 
	1) 시스템적인 에외 (SQL문법, DB 문제..) - 스프링은 개발자가 어떠한 DB 기술(Persistence 영역) 을 사용하던
	                                                       JDBC, Mybatis, JPA, Hibernate 등 어떤 기술을 사용하던 시스템으로ㅓ 발생하는 예외를 
	2) 비즈니스 에외 ( 업무 목적상 우리가 업무상 정해놓은 규칙에 대한 예외 ex) 포인트 초과 사용, 닉네임 중복 불가...
	                                                       DataAccessException 으로 포장해버린다.
	    
	RuntimeException 을 상속받아 우리만의 커스텀 예외르 만들어 사용하자
	-----------------------------------------*/
	@ExceptionHandler(BusinessException.class)
	public ResponseEntity<ApiResponse<Void>> handlerException(BusinessException e) {

		System.out.println("REST 예외 처리 실행: " + e.getMessage());
		
		ErrorCode errorCode = e.getErrorCode();

		ApiResponse<Void> response = ApiResponse.error(errorCode.getMessage());

		return ResponseEntity.status(errorCode.getStatus()).body(response);
	}

	@ExceptionHandler(Exception.class)
	public ResponseEntity<ApiResponse<Void>> handleException(Exception e) {

		ApiResponse<Void> response = ApiResponse.error("서버 오류가 발생했습니다.");

		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	}

	
}
