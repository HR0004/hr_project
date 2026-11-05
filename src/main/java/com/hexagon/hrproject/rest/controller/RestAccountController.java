
package com.hexagon.hrproject.rest.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.service.AccountService;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;

// 비밀번호 변경 요청용 REST Controller
@RestController
@RequiredArgsConstructor
public class RestAccountController {

    private final AccountService accountService;

    // 로그인한 계정의 비밀번호 변경
    @PutMapping("/api/accounts/me/password")
    public ResponseEntity<String> changePassword(
            @AuthenticationPrincipal AccountDetails accountDetails,
            @RequestBody Map<String, String> request) {

        // 1. 로그인 여부 확인
        if (accountDetails == null ||
                accountDetails.getAccount() == null) {

            throw new BusinessException(
                ErrorCode.LOGIN_REQUIRED
            );
        }

        // 2. 로그인한 계정 ID 가져오기
        int accountId =
                accountDetails.getAccount().getAccountId();

        // 3. 입력한 비밀번호 가져오기
        String currentPassword = request.get("currentPassword");
        String newPassword = request.get("newPassword");

        // 4. Service 호출
        accountService.changePassword(
                accountId,
                currentPassword,
                newPassword
        );

        // 5. 정상 처리
        return ResponseEntity.ok("비밀번호가 변경되었습니다.");
    }
}
