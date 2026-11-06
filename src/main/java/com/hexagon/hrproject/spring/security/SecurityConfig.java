package com.hexagon.hrproject.spring.security;

import static org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    private final LoginSuccessHandler loginSuccessHandler;
    private final LoginFailureHandler loginFailureHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {

        // Spring Framework 5.3.x + Spring Security 5.8.x 기준
        http
            // 요청에 따라 CSRF 보호 비활성화
            .csrf(csrf -> csrf.disable())

            .authorizeHttpRequests(auth -> auth

                // 로그인 및 정적 리소스
                .requestMatchers(
                    antMatcher("/login"),
                    antMatcher("/css/**"),
                    antMatcher("/js/**"),
                    antMatcher("/images/**"),
                    antMatcher("/static/**"),
                    antMatcher("/resources/**"),
                    antMatcher("/webjars/**"),
                    antMatcher("/favicon.ico")
                ).permitAll()

                // 본인 정보 조회
                // 아래 관리자 API 제한보다 먼저 작성해야 한다.
                .requestMatchers(
                    antMatcher(HttpMethod.GET, "/api/employees/me"),
                    antMatcher(HttpMethod.GET, "/api/employees/me/")
                ).authenticated()

                // 본인 정보 및 본인 비밀번호 변경
                .requestMatchers(
                    antMatcher(HttpMethod.PUT, "/api/employees/me"),
                    antMatcher(HttpMethod.PUT, "/api/employees/me/"),
                    antMatcher(HttpMethod.PUT, "/api/accounts/me/password"),
                    antMatcher(HttpMethod.PUT, "/api/accounts/me/password/")
                ).authenticated()

                // 관리자 화면 및 관리자 API
                .requestMatchers(
                    antMatcher("/"),
                    antMatcher("/dashboard"),
                    antMatcher("/dashboard/**"),
                    antMatcher("/admin/**"),
                    antMatcher("/departments"),
                    antMatcher("/departments/**"),
                    antMatcher("/jobs"),
                    antMatcher("/jobs/**"),
                    antMatcher("/employees"),
                    antMatcher("/employees/**"),
                    antMatcher("/api/departments"),
                    antMatcher("/api/departments/**"),
                    antMatcher("/api/jobs"),
                    antMatcher("/api/jobs/**"),
                    antMatcher("/api/employees"),
                    antMatcher("/api/employees/**"),
                    antMatcher("/api/accounts"),
                    antMatcher("/api/accounts/**")
                ).hasRole("HR_ADMIN")

                // 사원 홈, 마이페이지, 본인 근태·휴가 등
                .anyRequest().authenticated()
            )

            .exceptionHandling(exception -> exception
                // 미로그인 API 요청은 401 반환
                .defaultAuthenticationEntryPointFor(
                    new HttpStatusEntryPoint(
                        HttpStatus.UNAUTHORIZED
                    ),
                    antMatcher("/api/**")
                )
            )

            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("accountId")
                .passwordParameter("pwd")
                .successHandler(loginSuccessHandler)
                .failureHandler(loginFailureHandler)
                .permitAll()
            )

            .logout(logout -> logout
                // CSRF 비활성화 후에도 로그아웃은 POST 요청으로 제한
                .logoutRequestMatcher(antMatcher(HttpMethod.POST, "/logout"))
                .logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .deleteCookies("JSESSIONID")
            );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}