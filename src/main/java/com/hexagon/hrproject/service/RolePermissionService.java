package com.hexagon.hrproject.service;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.mapper.RolePermissionMapper;

@Service
public class RolePermissionService {

    private final RolePermissionMapper mapper;

    @Autowired
    public RolePermissionService(RolePermissionMapper mapper) {
        this.mapper = mapper;
    }

    @Transactional(readOnly = true)
    @PreAuthorize(
        "hasRole('HR_ADMIN') and hasAuthority('PERMISSION_ROLE_MANAGE')"
    )
    public Map<String, Object> page(Long requestedRoleId) {

        List<Map<String, Object>> roles = mapper.roles();
        Long roleId = null;

        for (Map<String, Object> role : roles) {
            long id = ((Number) role.get("roleId")).longValue();

            if (roleId == null) {
                roleId = id;
            }

            if (requestedRoleId != null
                    && requestedRoleId.longValue() == id) {
                roleId = id;
                break;
            }
        }

        Map<String, Object> result = new HashMap<>();

        result.put("roles", roles);
        result.put("permissions", mapper.permissions());
        result.put("selectedRoleId", roleId);

        result.put(
            "selectedPermissionIds",
            roleId == null
                ? Collections.<Long>emptySet()
                : new HashSet<Long>(
                    mapper.selectedPermissions(roleId)
                )
        );

        return result;
    }

    @Transactional
    @PreAuthorize(
        "hasRole('HR_ADMIN') and hasAuthority('PERMISSION_ROLE_MANAGE')"
    )
    public void savePermissions(
            long roleId,
            List<Long> permissionIds) {

        Map<String, Object> role = mapper.lockRole(roleId);

        if (role == null) {
            throw new IllegalArgumentException(
                "존재하지 않는 역할입니다."
            );
        }

        Set<Long> selected = new LinkedHashSet<>();

        if (permissionIds != null) {
            selected.addAll(permissionIds);
        }

        Set<Long> valid = new HashSet<>();
        Set<String> selectedCodes = new HashSet<>();

        for (Map<String, Object> permission : mapper.permissions()) {
            Long id = ((Number) permission.get(
                "permissionId"
            )).longValue();

            valid.add(id);

            if (selected.contains(id)) {
                selectedCodes.add(
                    String.valueOf(
                        permission.get("permissionCode")
                    )
                );
            }
        }

        if (!valid.containsAll(selected)) {
            throw new IllegalArgumentException(
                "유효하지 않은 권한이 포함되어 있습니다."
            );
        }

        // 관리자가 관리 기능을 전부 잃는 것을 방지
        if ("ROLE_HR_ADMIN".equals(role.get("roleCode"))
                && !selectedCodes.containsAll(Arrays.asList(
                    "PERMISSION_ACCOUNT_MANAGE",
                    "PERMISSION_ROLE_ASSIGN",
                    "PERMISSION_ROLE_MANAGE"
                ))) {

            throw new IllegalArgumentException(
                "인사 관리자 역할의 계정 관리·역할 부여·"
                + "역할별 권한 설정 권한은 유지해야 합니다."
            );
        }

        mapper.deletePermissions(roleId);

        for (Long permissionId : selected) {
            mapper.insertPermission(roleId, permissionId);
        }
    }
}