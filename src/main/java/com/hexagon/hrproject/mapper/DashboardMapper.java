package com.hexagon.hrproject.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface DashboardMapper {
    
    @Select("SELECT COUNT(*) FROM emp")
    int countAllEmp();

    @Select("SELECT COUNT(*) FROM emp WHERE status = #{status}")
    int countEmpByStatus(String status);
}