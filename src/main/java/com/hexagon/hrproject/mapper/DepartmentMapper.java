package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hexagon.hrproject.domain.Department;

@Mapper
public interface DepartmentMapper {
	int nextId(); // 이거 부서 Id 발급할 때 사용하는 id임
	int insert(Department department);

	Department select(int departmentId);
	
	List<Department> selectAll();

}
