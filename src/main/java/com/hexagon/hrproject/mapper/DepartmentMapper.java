package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Department;

@Mapper
public interface DepartmentMapper {
	
	// 이거 부서 Id 발급할 때 사용하는 id임
    int insert(Department department);

    int updateCode(Department department);

    // 조회
    Department select(@Param("departmentId") int departmentId);

    List<Department> selectAll();
    
    // 부서 검색기능으로 부서조회
    List<Department> search(@Param("departmentName") String departmentName);
    
    // 수정
    int updateName(@Param("departmentId") int departmentId,
                   @Param("departmentName") String departmentName);
    
    // 삭제
    int deactivate(@Param("departmentId") int departmentId);
    
    
    // 예외 처리
    int countByName(@Param("departmentName") String departmentName);

}
