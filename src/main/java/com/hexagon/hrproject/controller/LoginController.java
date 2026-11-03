package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

	@GetMapping("/loginform")
	public String getLogin() {
		return "secure/login";
	}
	
	@GetMapping("/mypage")
	public String getMypage() {
		return "mypage"; 
	}
}
