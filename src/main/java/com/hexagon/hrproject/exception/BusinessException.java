package com.hexagon.hrproject.exception;

import lombok.Getter;

//개발자만의 업무용 예외를 정의할 수 있으며, 이때는 강요하지 않는 예외의 최상위 자료형인 RuntimeException
//상속받아 구현한다 
@Getter
public class BusinessException extends RuntimeException {

 // 우리가 정의한 예외 객체가 ErrorCode 를 보유함으로써, 개발자는 굳이
 // 모든 비즈니스 예외에 대한 클래스를 1:1로 만들 필요가 없다!
 private final ErrorCode errorCode;

 // 예외객체에 넣을 메시지 처리, 원래 예외객체에 원하는 메시지를 심으려면 생성자를 통해서 가능한데, 
 // java 에서는 부모의 생성자는 자식에게 물려지지 않으므로, 
 // RuntimeException 에 메시지가 전달되려면 부모 생성자를 직접 호출해야 한다

 public BusinessException(ErrorCode errorCode) {
     super(errorCode.getMessage());
     this.errorCode = errorCode;
 }

 public BusinessException(String message, ErrorCode errorCode) {
     super(message); // 나의 메시지를 부모에게까지 전달 
     this.errorCode=errorCode;
 }

}