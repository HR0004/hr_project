package com.hexagon.hrproject.controller;

import javax.validation.Valid;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hexagon.hrproject.dto.request.SalaryCreateRequest;
import com.hexagon.hrproject.exception.SalaryBusinessException;
import com.hexagon.hrproject.exception.SalaryNotFoundException;
import com.hexagon.hrproject.service.SalaryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/salary")
public class SalaryController {

    private final SalaryService salaryService;

    // 급여 목록
    @PreAuthorize("hasRole('HR_ADMIN')")
    @GetMapping("/list")
    public String list(Model model) {

        model.addAttribute(
                "salaries",
                salaryService.getSalaryList()
        );

        return "salary/list";
    }

    // 인사 관리자용 급여 상세 조회
    @PreAuthorize("hasRole('HR_ADMIN')")
    @GetMapping("/detail/{salaryId}")
    public String detail(@PathVariable("salaryId") Long salaryId, Model model) {
        model.addAttribute("salary", salaryService.getSalaryDetail(salaryId));
        return "salary/detail";
    }

    // 급여 등록 화면
    @PreAuthorize("hasRole('HR_ADMIN')")
    @GetMapping("/create")
    public String createForm() {
        return "salary/create";
    }

    // 급여 등록 처리
    @PreAuthorize("hasRole('HR_ADMIN')")
    @PostMapping("/create")
    public String create(
            @Valid @ModelAttribute SalaryCreateRequest request) {

        Long salaryId = salaryService.createSalary(request);

        return "redirect:/salary/detail/" + salaryId;
    }

    // 존재하지 않는 급여 내역
    @ExceptionHandler(SalaryNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handle(SalaryNotFoundException e, Model model) {
        model.addAttribute("errorMessage", e.getMessage());
        return "salary/error";
    }

    // 입력값 검증 및 형식 변환 오류
    @ExceptionHandler(BindException.class)
    public String handle(BindException e, Model model) {

        model.addAttribute(
                "errorMessage",
                "입력값을 확인하세요. 필수 항목과 날짜·금액 형식이 올바르지 않습니다."
        );

        return "salary/error";
    }

    // 급여 중복 등 업무 오류
    @ExceptionHandler(SalaryBusinessException.class)
    public String handle(SalaryBusinessException e, Model model) {

        model.addAttribute("errorMessage", e.getMessage());

        return "salary/error";
    }
}
