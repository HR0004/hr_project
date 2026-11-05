package com.hexagon.hrproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Emp;

public interface EmpMapper {

	List<Emp> findAll();

	Emp findById(@Param("empId") int empId);

	// 사원 신규 등록
	int insert(Emp emp);

	// 사원 정보 수정
	int update(Emp emp);

	// 사원 퇴사 처리
	int retire(@Param("empId") int empId);

	// 로그인한 사원의 이메일, 연락처 수정
	int updateMyInfo(
	    @Param("empId") int empId,
	    @Param("email") String email,
	    @Param("phone") String phone);
	    
	// 전체 사원 수 조회
	int countAll();

	// 페이지별 사원 목록 조회
	List<Emp> findByPage(@Param("offset") int offset, @Param("pageSize") int pageSize);

}