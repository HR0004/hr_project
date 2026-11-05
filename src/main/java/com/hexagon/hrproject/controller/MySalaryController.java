
package com.hexagon.hrproject.controller;

import java.time.Year;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.domain.Salary;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import com.hexagon.hrproject.service.SalaryService;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/salary/my")
public class MySalaryController {

	private final SalaryService salaryService;

	// 1. 로그인한 사원의 사번 가져오기
	private Long getLoginEmpId() {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof AccountDetails)) {

			throw new SalaryBusinessException("로그인한 사원 정보를 확인할 수 없습니다.");
		}

		AccountDetails details = (AccountDetails) auth.getPrincipal();

		if (details.getAccount() == null || details.getAccount().getEmp() == null) {

			throw new SalaryBusinessException("로그인 계정에 연결된 사원 정보가 없습니다.");
		}

		Emp emp = details.getAccount().getEmp();

		if (emp.getEmpId() <= 0) {
			throw new SalaryBusinessException("유효한 사원 번호가 없습니다.");
		}

		return Long.valueOf(emp.getEmpId());
	}

	// 2. 내 급여 목록
	@GetMapping
	public String myList(@RequestParam(value = "year", required = false) String year, Model model) {

		Long empId = getLoginEmpId();

		int currentYear = Year.now().getValue();

		String searchYear = (year == null || year.trim().isEmpty()) ? String.valueOf(currentYear) : year.trim();

		List<Salary> salaries = salaryService.getMySalaryList(empId, searchYear);

		model.addAttribute("salaries", salaries);
		model.addAttribute("searchYear", searchYear);
		model.addAttribute("empId", empId);

		model.addAttribute("years", IntStream.rangeClosed(currentYear - 4, currentYear).boxed()
				.sorted((a, b) -> b.compareTo(a)).collect(Collectors.toList()));

		if (!salaries.isEmpty()) {
			model.addAttribute("latestSalary", salaries.get(0));
		}

		return "salary/myList";
	}

	// 3. 내 급여 상세
	@GetMapping("/detail/{salaryId}")
	public String myDetail(@PathVariable("salaryId") Long salaryId, Model model) {

		Long empId = getLoginEmpId();

		Salary salary = salaryService.getMySalaryDetail(empId, salaryId);

		model.addAttribute("salary", salary);

		return "salary/myDetail";
	}

	@ExceptionHandler(SalaryNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handleSalaryNotFound(SalaryNotFoundException e, Model model) {

		model.addAttribute("errorMessage", e.getMessage());

		return "salary/error";
	}

}
