package com.hexagon.hrproject.spring.security;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class LoginSuccessHandler
        implements AuthenticationSuccessHandler {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        // 인사 관리자 역할 보유 여부 확인
        boolean isHrAdmin = authentication.getAuthorities().stream()
            .anyMatch(authority ->
                "ROLE_HR_ADMIN".equals(authority.getAuthority())
            );

        // 역할별 이동 경로
        String targetPath = isHrAdmin
            ? "/dashboard"
            : "/employee/home";

        // 마이페이지에서 사용하는 로그인 계정 정보 저장
        if (authentication.getPrincipal() instanceof AccountDetails) {
            AccountDetails details =
                (AccountDetails) authentication.getPrincipal();

            request.getSession().setAttribute(
                "loginUser",
                details.getAccount()
            );
        }

        // 브라우저에 전달할 데이터
        Map<String, Object> body = new LinkedHashMap<>();

        body.put("success", true);
        body.put(
            "redirectUrl",
            request.getContextPath() + targetPath
        );

        response.setContentType("application/json;charset=UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);

        objectMapper.writeValue(response.getWriter(), body);
    }
}