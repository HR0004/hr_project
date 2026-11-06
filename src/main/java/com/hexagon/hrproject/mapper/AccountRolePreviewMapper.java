package com.hexagon.hrproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface AccountRolePreviewMapper {

    @Select(
        "SELECT DISTINCT rp.hr_role_id AS roleId, "
        + "p.permission_code AS permissionCode, "
        + "p.permission_name AS permissionName "
        + "FROM hr_role_permission rp "
        + "JOIN permission p ON p.permission_id = rp.permission_id "
        + "ORDER BY rp.hr_role_id, p.permission_code"
    )
    List<Map<String, Object>> selectRolePermissions();
}