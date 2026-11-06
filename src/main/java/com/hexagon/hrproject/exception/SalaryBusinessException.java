package com.hexagon.hrproject.exception;

public class SalaryBusinessException extends RuntimeException {

    public SalaryBusinessException(String message) {
        super(message);
    }
    public SalaryBusinessException(String message, Throwable cause) {
        super(message, cause);
    }
}