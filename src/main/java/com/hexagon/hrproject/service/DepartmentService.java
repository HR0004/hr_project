package com.hexagon.hrproject.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hexagon.hrproject.domain.Department;
import com.hexagon.hrproject.dto.DepartmentDTO;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.mappers.DepartmentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentService {
	private final DepartmentMapper departmentMapper;

	@Transactional
	public int regist(DepartmentDTO departmentDTO) {
		
		String name = departmentDTO.getDepartmentName();
		
		if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("부서명을 입력하세요.");
        }
		
		Department dept = new Department();
		
		// 1. 부서명 설정
		dept.setDepartmentName(name.trim()); // 해당 trim은 사용자가 부서명을 공백있지 입력하면 그때 공백을 없애고 받아오기 위함

		// 2. mysql seq id 발급 
		int result = departmentMapper.insert(dept);
		
	    
		// 3. 부서코드 자동 생성
        String code = String.format("DEPT%04d", dept.getDepartmentId());
        
        // 4. 도메인 객체 생성해서 news에 받은 데이터를 담는다
        dept.setDepartmentCode(code);

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
}



