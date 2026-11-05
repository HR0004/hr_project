
package com.hexagon.hrproject.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.common.web.Pager;
import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.mapper.AccountMapper;
import com.hexagon.hrproject.mapper.EmpMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpService {
	// ~~ 용훈
	private final PasswordEncoder passwordEncoder;
	// ~~ 용훈
	private final AccountMapper accountMapper;
	private final EmpMapper empMapper;

	// --------------------------------------
	// 1. 사원 전체 조회
	// --------------------------------------
	public List<Emp> findAll() {
		return empMapper.findAll();
	}

	// --------------------------------------
	// 2. 사원 상세 조회
	// --------------------------------------
	public Emp findById(int empId) {

		Emp emp = empMapper.findById(empId);

		if (emp == null) {
			throw new BusinessException(ErrorCode.EMPLOYEE_NOT_FOUND);
		}

		return emp;
	}

	// --------------------------------------
	// 3. 사원 등록
	// --------------------------------------
	@Transactional
	public int insert(Emp emp) {

		validateEmployee(emp);

		int result = empMapper.insert(emp);

		if (result == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_REGIST_FAIL);
		}

		return result;
	}

	// --------------------------------------
	// 4. 사원 + 로그인 계정 등록
	// --------------------------------------
	@Transactional
	public void register(Account account) {

		// 계정 입력 검사
		if (account == null || account.getLoginId() == null || account.getLoginId().trim().isEmpty()) {

			throw new BusinessException(ErrorCode.LOGIN_ID_REQUIRED);
		}

		// 사원 정보 검사
		Emp emp = account.getEmp();

		validateEmployee(emp);

		// 로그인 ID 중복 검사
		int count = accountMapper.countByLoginId(account.getLoginId());

		if (count > 0) {
			throw new BusinessException(ErrorCode.LOGIN_ID_DUPLICATED);
		}

		// 사원 등록
		int empResult = empMapper.insert(emp);

		if (empResult == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_REGIST_FAIL);
		}

		// 생성된 사번을 계정에 연결
		account.setEmp(emp);

		// ~~ 용훈 추가
		if (account.getPassword() == null || account.getPassword().length() < 8) {
			throw new IllegalArgumentException("비밀번호는 8자 이상이어야 합니다.");
		}

		account.setPassword(passwordEncoder.encode(account.getPassword()));
		// ~~

		// 로그인 계정 등록
		int accountResult = accountMapper.insert(account);

		if (accountResult == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_REGIST_FAIL);
		}

		// 용훈 추가.
		int roleResult = accountMapper.insertDefaultEmployeeRole(account.getAccountId());

		if (roleResult != 1) {
			throw new IllegalStateException("기본 사원 권한 등록 실패");
		}
		// 용훈 추가
	}

	// --------------------------------------
	// 5. 사원 정보 수정
	// --------------------------------------
	@Transactional
	public int update(Emp emp) {

		validateEmployee(emp);

		// 수정 대상 조회
		findById(emp.getEmpId());

		int result = empMapper.update(emp);

		if (result == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_UPDATE_FAIL);
		}

		return result;
	}

	// --------------------------------------
	// 6. 사원 퇴사 처리
	// --------------------------------------
	@Transactional
	public int retire(int empId) {

		// 퇴사 대상 조회
		findById(empId);

		int result = empMapper.retire(empId);

		if (result == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_RETIRE_FAIL);
		}

		return result;
	}

	// --------------------------------------
	// 7. 사원 본인 정보 수정
	// --------------------------------------
	@Transactional
	public void updateMyInfo(int empId, String email, String phone) {

		// 이메일 필수 입력 검사
		if (email == null || email.trim().isEmpty()) {
			throw new BusinessException(ErrorCode.EMPLOYEE_EMAIL_REQUIRED);
		}

		// 이메일 형식 검사
		if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

			throw new BusinessException(ErrorCode.EMPLOYEE_EMAIL_INVALID);
		}

		// 이메일, 연락처 수정
		int result = empMapper.updateMyInfo(empId, email.trim(), phone);

		if (result == 0) {
			throw new BusinessException(ErrorCode.EMPLOYEE_NOT_FOUND);
		}
	}

	// --------------------------------------
	// 8. 사원 목록 페이지 처리
	// --------------------------------------
	public Pager getEmpPage(HttpServletRequest request) {

		Pager pager = new Pager();

		// 전체 사원 수
		int totalCount = empMapper.countAll();

		pager.setTotalCount(totalCount);

		// 페이지 정보 계산
		pager.init(request);

		// 현재 페이지 사원 조회
		List<Emp> empList = empMapper.findByPage(pager.getOffset(), pager.getPageSize());

		pager.setList(empList);

		return pager;
	}

	// --------------------------------------
	// 9. 사원 공통 입력 검사
	// --------------------------------------
	private void validateEmployee(Emp emp) {

		if (emp == null || emp.getEname() == null || emp.getEname().trim().isEmpty()) {

			throw new BusinessException(ErrorCode.EMPLOYEE_NAME_REQUIRED);
		}

		if (emp.getEmail() == null || emp.getEmail().trim().isEmpty()) {

			throw new BusinessException(ErrorCode.EMPLOYEE_EMAIL_REQUIRED);
		}

		if (!emp.getEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

			throw new BusinessException(ErrorCode.EMPLOYEE_EMAIL_INVALID);
		}
	}
}
