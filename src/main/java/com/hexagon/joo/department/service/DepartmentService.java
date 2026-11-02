package com.hexagon.joo.department.service;

import org.springframework.stereotype.Service;

import com.hexagon.joo.domain.Department;
import com.hexagon.joo.dto.DepartmentDTO;
import com.hexagon.joo.mapper.DepartmentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentService {
	private final DepartmentMapper departmentMapper;

	public int regist(DepartmentDTO departmentDTO) {
		Department dept = new Department();
		
		String name = departmentDTO.getDepartmentName();
		if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("부서명을 입력하세요.");
        }
		
		// 2. oracle seq id 발급 
		int id = departmentMapper.nextId();
		
		// 3. 부서코드 자동 생성
        String code = String.format("DEPT%04d", id);
        
        // 4. 도메인 객체 생성해서 news에 받은 데이터를 담는다
        dept.setDepartmentId(id);
        dept.setDepartmentCode(code);
        dept.setDepartmentName(name.trim()); // 해당 trim은 사용자가 부서명을 공백있지 입력하면 그때 공백을 없애고 받아오기 위함

        // 5. mapper 호출해서 insert
        int result = departmentMapper.insert(dept);
        return result;
		
	}
}
