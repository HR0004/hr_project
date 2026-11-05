package com.hexagon.hrproject.exception;

public class SalaryNotFoundException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public SalaryNotFoundException() {
        super("해당 급여 내역을 찾을 수 없습니다. 급여 목록에서 다시 선택하세요.");
    }
}