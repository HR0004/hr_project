package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    // 추후 인증 오류 페이지나 권한 없음(Access Denied) 페이지 용도로 활용
    @GetMapping("/auth/denied")
    public String accessDenied() {
        return "secure/denied"; 
    }
}