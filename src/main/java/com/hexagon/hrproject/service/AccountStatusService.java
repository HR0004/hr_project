package com.hexagon.hrproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.mapper.AccountStatusMapper;

@Service
public class AccountStatusService {

    private final AccountStatusMapper accountStatusMapper;

    @Autowired
    public AccountStatusService(AccountStatusMapper accountStatusMapper) {
        this.accountStatusMapper = accountStatusMapper;
    }

    @Transactional
    @PreAuthorize("hasRole('HR_ADMIN')")
    public boolean changeStatus(
            long accountId,
            int enabled,
            int operatorAccountId) {

        if (accountId <= 0) {
            throw new IllegalArgumentException(
                "올바른 계정을 선택해 주세요.");
        }

        if (enabled != 0 && enabled != 1) {
            throw new IllegalArgumentException(
                "계정 상태는 활성 또는 비활성만 가능합니다.");
        }

        if (accountId == operatorAccountId && enabled == 0) {
            throw new IllegalArgumentException(
                "본인 계정은 비활성화할 수 없습니다.");
        }

        Integer currentEnabled =
            accountStatusMapper.selectEnabledForUpdate(accountId);

        if (currentEnabled == null) {
            throw new IllegalArgumentException(
                "조회된 계정 정보가 없습니다.");
        }

        if (currentEnabled.intValue() == enabled) {
            return false;
        }

        int updated =
            accountStatusMapper.updateEnabled(accountId, enabled);

        if (updated != 1) {
            throw new IllegalStateException(
                "계정 상태 변경 결과를 확인할 수 없습니다.");
        }

        return true;
    }
}