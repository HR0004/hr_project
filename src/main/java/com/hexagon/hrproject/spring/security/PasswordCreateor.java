package com.hexagon.hrproject.spring.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordCreateor {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPassword=encoder.encode("1234");
		System.out.println("결과" + encodedPassword);
	}

}
