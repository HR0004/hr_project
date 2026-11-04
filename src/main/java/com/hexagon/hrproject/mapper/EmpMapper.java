package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Emp;

public interface EmpMapper {

	List<Emp> findAll();

	Emp findById(@Param("empId") int empId);
	
	//사원 신규 등록
	int insert(Emp emp);
	
	//사원 정보 수정
	int update(Emp emp);
	
}