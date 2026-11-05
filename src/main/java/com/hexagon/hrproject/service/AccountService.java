
package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.mapper.AccountMapper;

@Service
public class AccountService {

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ----------------------------------------
    // 1. 로그인한 계정의 비밀번호 변경
    // ----------------------------------------
    @Transactional
    public void changePassword(
            int accountId,
            String currentPassword,
            String newPassword) {

        // 계정 조회
        Account account =
                accountMapper.selectByIdNum((long) accountId);

        if (account == null) {
            throw new BusinessException(
                ErrorCode.ACCOUNT_NOT_FOUND
            );
        }

        // 비밀번호 입력 검사
        if (currentPassword == null || currentPassword.isEmpty()
                || newPassword == null || newPassword.isEmpty()) {

            throw new BusinessException(
                ErrorCode.PASSWORD_REQUIRED
            );
        }

        // 현재 비밀번호 확인
        if (!passwordEncoder.matches(
                currentPassword, account.getPassword())) {

            throw new BusinessException(
                ErrorCode.CURRENT_PASSWORD_MISMATCH
            );
        }

        // 최소 길이 검사
        if (newPassword.length() < 8) {
            throw new BusinessException(
                ErrorCode.PASSWORD_TOO_SHORT
            );
        }

        // 기존 비밀번호와 동일한지 검사
        if (currentPassword.equals(newPassword)) {
            throw new BusinessException(
                ErrorCode.PASSWORD_SAME_AS_CURRENT
            );
        }

        // 비밀번호 암호화
        String encodedPassword =
                passwordEncoder.encode(newPassword);

        // DB 수정
        int result =
                accountMapper.updatePassword(accountId, encodedPassword);

        if (result == 0) {
            throw new BusinessException(
                ErrorCode.PASSWORD_UPDATE_FAIL
            );
        }
    }

    // ----------------------------------------
    // 2. 기존 보안 테스트 메서드
    // ----------------------------------------
    @PreAuthorize("hasAuthority('PERMISSION_MY_INFO_READ')")
    public String getEmp(int empId) {
        return "My name is HyunSuk, and empId is " + empId;
    }

    // ----------------------------------------
    // 3. 기존 보안 테스트 메서드
    // ----------------------------------------
    @PreAuthorize("hasAuthority('PERMISSION_ROLE_ASSIGN')")
    public String addPermission() {
        return "Permission role assigned is successful";
    }

    // ----------------------------------------
    // 4. 전체 역할 목록 조회
    // ----------------------------------------
    public List<HrRole> getAllRoles() {
        return accountMapper.selectAllRoles();
    }

    // ----------------------------------------
    // 5. 특정 계정 상세 조회
    // ----------------------------------------
    public Account getAccountById(Long accountId) {

        Account account =
                accountMapper.selectByIdNum(accountId);

        if (account == null) {
            throw new BusinessException(
                ErrorCode.ACCOUNT_NOT_FOUND
            );
        }

        return account;
    }

    // ----------------------------------------
    // 6. 계정 권한 변경
    // ----------------------------------------
    @Transactional
    public void updateAccountRoles(
            Long accountId,
            List<Long> roleIds) {

        // 계정 존재 여부 확인
        getAccountById(accountId);

        // 기존 권한 삭제
        accountMapper.deleteAccountRolesByAccountId(accountId);

        // 새로운 권한 등록
        if (roleIds != null && !roleIds.isEmpty()) {
            for (Long hrRoleId : roleIds) {
                accountMapper.insertAccountRole(
                    accountId,
                    hrRoleId
                );
            }
        }
    }

    // ----------------------------------------
    // 7. 계정 목록 조회 및 검색 ← 새로 추가하는 부분
    // ----------------------------------------
    public List<Account> getAccountList(String keyword) {

        if (keyword != null) {
            keyword = keyword.trim();
        }

        return accountMapper.selectAccountList(keyword);
    }
}