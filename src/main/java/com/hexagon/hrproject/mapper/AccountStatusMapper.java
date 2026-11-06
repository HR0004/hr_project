package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface AccountStatusMapper {

    @Select("SELECT enabled FROM account WHERE account_id = #{accountId} FOR UPDATE")
    Integer selectEnabledForUpdate(@Param("accountId") long accountId);

    @Update("UPDATE account SET enabled = #{enabled} WHERE account_id = #{accountId}")
    int updateEnabled(
            @Param("accountId") long accountId,
            @Param("enabled") int enabled);
}