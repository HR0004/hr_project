package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    @GetMapping("/login") // /loginform 대신 /login으로 깔끔하게 변경
    public String getLogin() {
        return "secure/login";
    }
    
    @GetMapping("/mypage")
    public String getMypage() {
        return "Mypage"; 
    }
}