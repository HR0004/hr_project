package com.hexagon.hrproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.mapper.AccountRolePreviewMapper;

@Service
public class AccountRolePreviewService {

    private final AccountRolePreviewMapper previewMapper;

    @Autowired
    public AccountRolePreviewService(
            AccountRolePreviewMapper previewMapper) {

        this.previewMapper = previewMapper;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getRolePermissions() {
        return previewMapper.selectRolePermissions();
    }
}