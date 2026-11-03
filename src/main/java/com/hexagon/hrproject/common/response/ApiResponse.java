package com.hexagon.hrproject.common.response;

import java.util.List;

import lombok.Getter;

/*
 * 비동기 요청시 응답 정보를 구성할때 체계적이고 구조화된 응답정보를 만들기 위해 기준이 되는 객체 사용하자
 * 
 * 응답 정보 - header 애는 http status(200,500)
 * 			body에는 데이터만 달랑 넣지 말고 (개발자의 메시지, 성공여부를 판단할 수 있는 데이터, 본래의 데이터)
 * 아래의 객체는 모든 프로젝트의 비동기 요청에 사용될 수 있는 기준 객체
 * 글쓰기 응답
 * 목록 
 * 수정
 * 삭제
 * 
 */
// <T,K,V는 다 object 이고 E는 element
@Getter
public class ApiResponse<T> {
	private boolean success;
	private String message;
	private T data; // 이 자료형은 지금 결정되지 않음, 개발자가 이 클래스로부터 인스턴스 만들때 즉 new할때 결정하면 됨
					// 따라서 이 세상 모든 자료형을 받을 수 잇음. 유연함
	
	// 성공시 생성할 응답 정보
	public static <T> ApiResponse<T> success(String message, T data) {
		ApiResponse<T> response = new ApiResponse<>();
		response.success = true;
		response.message = message;
		response.data = data;
		
		return response;
	}
	
	// 실패시 생성할 응답 정보
	public static <T> ApiResponse<T> error(String message){
		ApiResponse<T> response = new ApiResponse<>();
		response.success = false;
		response.message = message;
		response.data = null;
		
		return response;
	}
}
