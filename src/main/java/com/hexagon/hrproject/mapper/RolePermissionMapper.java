package com.hexagon.hrproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface RolePermissionMapper {

    @Select(
        "SELECT hr_role_id AS roleId, role_code AS roleCode, "
        + "role_name AS roleName "
        + "FROM hr_role WHERE is_active=1 ORDER BY hr_role_id"
    )
    List<Map<String, Object>> roles();

    @Select(
        "SELECT permission_id AS permissionId, "
        + "permission_code AS permissionCode, "
        + "permission_name AS permissionName "
        + "FROM permission ORDER BY permission_id"
    )
    List<Map<String, Object>> permissions();

    @Select(
        "SELECT permission_id FROM hr_role_permission "
        + "WHERE hr_role_id=#{roleId}"
    )
    List<Long> selectedPermissions(@Param("roleId") long roleId);

    @Select(
        "SELECT hr_role_id AS roleId, role_code AS roleCode "
        + "FROM hr_role WHERE hr_role_id=#{roleId} "
        + "AND is_active=1 FOR UPDATE"
    )
    Map<String, Object> lockRole(@Param("roleId") long roleId);

    @Delete(
        "DELETE FROM hr_role_permission WHERE hr_role_id=#{roleId}"
    )
    int deletePermissions(@Param("roleId") long roleId);

    @Insert(
        "INSERT INTO hr_role_permission(hr_role_id,permission_id) "
        + "VALUES(#{roleId},#{permissionId})"
    )
    int insertPermission(
        @Param("roleId") long roleId,
        @Param("permissionId") long permissionId
    );
}