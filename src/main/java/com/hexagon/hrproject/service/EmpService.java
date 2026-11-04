package com.hexagon.hrproject.service;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.mapper.AccountMapper;
import com.hexagon.hrproject.mapper.EmpMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpService {
	
	private final AccountMapper accountMapper;
	private final EmpMapper empMapper;
	
	//사원 전체 조회
	public List<Emp> findAll(){
		return empMapper.findAll();
	}
	
	//사원 상세 조회
	public Emp findById(int empId) {
		return empMapper.findById(empId);
	}
	
	//사원 +로그인 계정 등록
	public int insert(Emp emp) {
		return empMapper.insert(emp);
	}

		@Transactional
		public void register(Account account) {

			//로그인 ID 중복 검사
			int count = accountMapper.countByLoginId(account.getLoginId());
			
			if (count > 0) {
				throw new IllegalArgumentException("이미 사용중인 로그인 ID입니다.");
			}
			
			
		    // 1. Account에서 사원 객체 꺼내기
		    Emp emp = account.getEmp();

		    // 2. 사원 등록 (selectKey로 사번 생성)
		    empMapper.insert(emp);

		    // 3. 생성된 사번을 Account에 연결
		    account.setEmp(emp);

		    // 4. 로그인 계정 등록
		    accountMapper.insert(account);	  
	}
		
		//사원 정보 수정
		public int update(Emp emp) {
			return empMapper.update(emp);
		}
		
		//사원 퇴사 처리
		@Transactional
		public int retire(int empId) {
			return empMapper.retire(empId);
		}
}