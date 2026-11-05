package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Department;
import com.hexagon.hrproject.dto.DepartmentDTO;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.mapper.DepartmentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentService {
	private final DepartmentMapper departmentMapper;


@Transactional
public int regist(DepartmentDTO departmentDTO) {

    // 1. 부서명 가져오기
    String name = departmentDTO.getDepartmentName();

    // 2. 입력값 검사
    if (name == null || name.trim().isEmpty()) {
        throw new BusinessException(ErrorCode.INVALID_INPUT);
    }

    name = name.trim();

    // 3. 중복 검사 (INSERT 전에 실행!)
    if (departmentMapper.countByName(name) > 0) {
        throw new BusinessException(
            ErrorCode.DEPARTMENT_ALREADY_EXISTS
        );
    }

    // 4. 부서 객체 생성
    Department dept = new Department();
    dept.setDepartmentName(name);

    // 5. 부서 등록
    int result = departmentMapper.insert(dept);

    // 6. 부서 코드 자동 생성
    String code = String.format("DEPT%04d", dept.getDepartmentId());
    dept.setDepartmentCode(code);

    // 7. 부서 코드 저장
    if (departmentMapper.updateCode(dept) != 1) {
        throw new IllegalStateException("부서코드 생성 실패");
    }

    return result;
}

	
	public List<Department> getList(){
		return departmentMapper.selectAll();
	}
	
	// 부서 상세조회
	public Department getDetail(int departmentId) {
		Department dept = departmentMapper.select(departmentId);
		
		if(dept == null) {
			throw new BusinessException(ErrorCode.UNAUTHORIZED_DEPARTMENT_ACCESS);
		}
		return dept;
	}
	
	// 검색 기능으로 부서 조회
	public List<Department> search(String departmentName){
		if (departmentName == null || departmentName.trim().isEmpty()) {
			return departmentMapper.selectAll();
		}
		return departmentMapper.search(departmentName);
	}
	
	
	// 부서 수정
	public int update(int departmentId, DepartmentDTO dto) {
		
		Department dept  = getDetail(departmentId);
		
	    if (dept.getIsActive() != 1) {
	        throw new BusinessException(ErrorCode.DEPARTMENT_UPDATE_FAIL);
	    }

	    String name = dto == null ? null : dto.getDepartmentName();

	    if (name == null || name.trim().isEmpty()) {
	        throw new BusinessException(ErrorCode.DEPARTMENT_NOT_FOUND);
	    }

	    int result = departmentMapper.updateName(
	            departmentId, name.trim());

	    if (result != 1) {
	        throw new BusinessException(ErrorCode.DEPARTMENT_UPDATE_FAIL);
	    }
		
		return result;
	}
	
	
	
	public int deactivity(int departmentId) {
		Department dept = getDetail(departmentId);
		
	    if (dept.getIsActive() != 1) {
	        throw new BusinessException(ErrorCode.DEPARTMENT_DELETE_FAIL);
	    }

	    int result = departmentMapper.deactivate(departmentId);

	    if (result != 1) {
	        throw new BusinessException(ErrorCode.DEPARTMENT_DELETE_FAIL);
	    }

	    return result;
	}
	
	// 예외 처리
}



