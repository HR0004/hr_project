
package com.hexagon.hrproject.controller;

import java.math.BigDecimal;
import java.util.Collections;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    // 1. 급여 목록 조회 및 검색
    @GetMapping("/list")
    public String list(
            @RequestParam(value = "salaryYearMonth", required = false)
            String salaryYearMonth,

            @RequestParam(value = "employeeKeyword", required = false)
            String employeeKeyword,

            Model model) {

        String month = salaryYearMonth == null
                ? "" : salaryYearMonth.trim();

        String keyword = employeeKeyword == null
                ? "" : employeeKeyword.trim();

        model.addAttribute("salaryYearMonth", month);
        model.addAttribute("employeeKeyword", keyword);
        model.addAttribute(
            "searchApplied",
            !month.isEmpty() || !keyword.isEmpty()
        );

        try {
            model.addAttribute(
                "salaries",
                salaryService.getSalaryList(month, keyword)
            );

        } catch (SalaryBusinessException e) {

            model.addAttribute(
                "salaries",
                Collections.emptyList()
            );

            model.addAttribute(
                "salarySearchError",
                e.getMessage()
            );
        }

        return "salary/list";
    }

    // 2. 급여 상세 조회
    @GetMapping("/detail/{salaryId}")
    public String detail(
            @PathVariable("salaryId") Long salaryId,
            Model model) {

        model.addAttribute(
            "salary",
            salaryService.getSalaryDetail(salaryId)
        );

        return "salary/detail";
    }

    // 3. 급여 등록 화면
    @GetMapping("/create")
    public String createForm(Model model) {

        SalaryCreateRequest request =
                new SalaryCreateRequest();

        request.setBonus(BigDecimal.ZERO);
        request.setDeduction(BigDecimal.ZERO);

        model.addAttribute(
            "salaryCreateRequest",
            request
        );

        return createView(model);
    }

    // 4. 급여 등록 처리
    @PostMapping("/create")
    public String create(
            @Valid @ModelAttribute("salaryCreateRequest")
            SalaryCreateRequest request,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {

            model.addAttribute(
                "errorMessage",
                "입력값을 확인하세요. 필수 항목과 날짜·금액 형식이 올바르지 않습니다."
            );

            return createView(model);
        }

        try {
            Long salaryId =
                    salaryService.createSalary(request);

            return "redirect:/salary/detail/" + salaryId + "?created=true";

        } catch (SalaryBusinessException e) {

            model.addAttribute(
                "errorMessage",
                e.getMessage()
            );

            return createView(model);
        }
    }

    // 5. 급여 등록 화면 공통 처리
    private String createView(Model model) {

        model.addAttribute(
            "salaryEmployees",
            salaryService.getEmployeeOptions()
        );

        return "salary/create";
    }

    // 6. 존재하지 않는 급여
    @ExceptionHandler(SalaryNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleSalaryNotFound(
            SalaryNotFoundException e,
            Model model) {

        model.addAttribute("errorMessage", e.getMessage());

        return "salary/error";
    }

    // 7. 입력 형식 오류
    @ExceptionHandler(BindException.class)
    public String handleBindException(
            BindException e,
            Model model) {

        model.addAttribute(
            "errorMessage",
            "입력값을 확인하세요. 필수 항목과 날짜·금액 형식이 올바르지 않습니다."
        );

        return "salary/error";
    }

    // 8. 급여 업무 예외
    @ExceptionHandler(SalaryBusinessException.class)
    public String handleSalaryBusinessException(
            SalaryBusinessException e,
            Model model) {

        model.addAttribute("errorMessage", e.getMessage());

        return "salary/error";
    }
}
