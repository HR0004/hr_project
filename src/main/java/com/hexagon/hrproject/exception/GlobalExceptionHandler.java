package com.hexagon.hrproject.exception;

import java.rmi.server.ExportException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// RestController가 아닌 그냥 controller에서 발생되는 예외를 처리하는 전역적 예외 처리
@ControllerAdvice(
	    basePackages = "com.hexagon.hrproject.controller"
	)
	public class GlobalExceptionHandler {
	
	// 문법적, 시스템적 예외//
	@ExceptionHandler(ExportException.class)
	public String handler(Exception e) {
		return "views/error/common-error";
	}
	
	// 업무상 커스텀 예외
	@ExceptionHandler(BusinessException.class)
	public String handler(BusinessException e) {
		return "views/error/common-error";
	}
}