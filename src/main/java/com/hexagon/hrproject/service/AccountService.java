package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.mapper.AccountMapper;

/*--------------------------------------------------------------------------------------------
 우리가 취득한 권한이 제대로 스프링에서 인식되는지 테스트 해보기
 PERMISSION_MY_INFO_READ 나의 정보 조회 - 무사히 통과가 예상됨(스프링이 가로 막지 않음)
 PERMISSION_ROLE_ASSIGN 권한 부여 권한 - 가로막힘이 예상됨
 ----------------------------------------------------------------------------------------------*/

@Service
public class AccountService {

    @Autowired
    private AccountMapper accountMapper;

    // 1. 기존 보안 테스트 메서드
    @PreAuthorize("hasAuthority('PERMISSION_MY_INFO_READ')")
    public String getEmp(int empId) {
        return "My name is HyunSuk, and empId is " + empId;
    }
    
    // 2. 기존 보안 테스트 메서드
    @PreAuthorize("hasAuthority('PERMISSION_ROLE_ASSIGN')")
    public String addPermission() {
        return "Permission role assigned is successful";
    }

    // =========================================================================
    // AccountController 연동용 메서드 (추가된 부분)
    // =========================================================================

    // 전체 역할 목록 조회
    public List<HrRole> getAllRoles() {
        return accountMapper.selectAllRoles();
    }

    // 특정 계정 상세 정보 조회
    public Account getAccountById(Long accountId) {
        return accountMapper.selectByIdNum(accountId);
    }

    // 계정 권한(역할) 변경 저장 처리
    @Transactional
    public void updateAccountRoles(Long accountId, List<Long> roleIds) {
        // 기존 권한 삭제 후 새 권한 등록
        accountMapper.deleteAccountRolesByAccountId(accountId);
        
        if (roleIds != null && !roleIds.isEmpty()) {
            for (Long hrRoleId : roleIds) {
                accountMapper.insertAccountRole(accountId, hrRoleId);
            }
        }
    }
}