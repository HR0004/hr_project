package com.hexagon.hrproject.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole; // HrRole 임포트 필요

@Mapper
public interface AccountMapper {

	Account selectById(String loginId);

	int insert(Account account);

	int countByLoginId(@Param("loginId") String loginId);

	// ==========================================
	// 관리자 권한/계정 관리를 위해 추가된 메서드들
	// ==========================================

	// 1. 전체 역할(Role) 목록 조회
	List<HrRole> selectAllRoles();

	// 2. 특정 계정 상세 정보 조회
	Account selectByIdNum(Long accountId);

	// 3. 특정 계정의 기존 권한 전체 삭제
	void deleteAccountRolesByAccountId(Long accountId);

	// 4. 특정 계정에 새로운 권한 부여
	void insertAccountRole(@Param("accountId") Long accountId, @Param("hrRoleId") Long hrRoleId);

	// 로그인한 계정의 비밀번호 변경
	int updatePassword(@Param("accountId") int accountId, @Param("password") String password);

	// 이름 또는 로그인 아이디로 계정 목록 검색
	List<Account> selectAccountList(@Param("keyword") String keyword);

	// 용훈 추가
	int insertDefaultEmployeeRole(@Param("accountId") int accountId);
}