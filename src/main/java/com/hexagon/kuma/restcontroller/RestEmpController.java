package com.hexagon.kuma.restcontroller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.kuma.domain.Account;
import com.hexagon.kuma.domain.Emp;
import com.hexagon.kuma.service.EmpService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestEmpController {

	private final PlatformTransactionManager platformTransactionManager;
	private final EmpService empService;


	
	//사원 전체 조회
	@GetMapping("/api/employees")
	public List<Emp> findAll(){

		return empService.findAll();
	}

	//사원 상세 조회
	@GetMapping("/api/employees/{empId}")
	public ResponseEntity<Emp> findById(@PathVariable int empId){
		
		Emp emp = empService.findById(empId);
		
		if(emp == null) {
			return ResponseEntity.notFound().build();
		}
		return ResponseEntity.ok(emp);
	}
	
	
	//신규 사원 + 로그인 계정 등록
	@PostMapping("/api/employees/register")
	public ResponseEntity<String> regist(@RequestBody Account account){
		//필수 데이터 확인
		if(account.getEmp() == null ||
			account.getLoginId() == null ||
			account.getLoginId().trim().isEmpty()) {
			
			return ResponseEntity.badRequest().body("사원 정보와 로그인ID를 입력해 주세요.");
		}
		
		try {	
			//사원 + 계정 등록
			empService.register(account);
		
			return ResponseEntity.status(HttpStatus.CREATED).body("사원 및 계정 등록 성공");
		
		}catch (IllegalArgumentException e) {
			
			return ResponseEntity.status(HttpStatus.CONFLICT).contentType(MediaType.parseMediaType("text/plain;charset=UTF-8")).body(e.getMessage());
		}
	}
	
	//사원 정보 수정
	@PutMapping("/api/employees/{empId}")
	public ResponseEntity<String> update(@PathVariable int empId, @RequestBody Emp emp){
		
		//URL 에서 받은 사번 설정
		emp.setEmpId(empId);
		
		//사원 정보 수정
		int result = empService.update(emp);
		
		if(result==0) {
			return ResponseEntity.notFound().build();
		}
		return ResponseEntity.ok("사원 정보 수정 성공");
	}
	
}
