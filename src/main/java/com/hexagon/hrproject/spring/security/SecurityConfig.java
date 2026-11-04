package com.hexagon.hrproject.spring.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
	private final LoginSuccessHandler loginSuccessHandler;
	private final LoginFailureHandler loginFailureHandler;
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		
		http
			.csrf(csrf->csrf.disable())
			
			.authorizeHttpRequests(auth->
				auth
					// 1. 로그인 페이지 및 누구나 접근해야 하는 경로는 인증 예외 처리
					.antMatchers("/login", "/css/**", "/js/**", "/images/**").permitAll()
					// 2. 관리자 페이지만큼은 ADMIN 권한이 있어야 접근 가능하도록 설정
					.antMatchers("/admin/**").hasRole("ADMIN")
					// 3. 그 외의 모든 요청은 로그인이 필요함
					.anyRequest().authenticated()
			)
			.formLogin(form->form
				.loginPage("/login") // 설정했던 /login 주소와 일치시킴
				.loginProcessingUrl("/login") // 로그인 POST 처리 주소
				.usernameParameter("accountId")
				.passwordParameter("pwd")
				.successHandler(loginSuccessHandler)
				.failureHandler(loginFailureHandler)
				.permitAll()
			);
		return http.build();
		
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}