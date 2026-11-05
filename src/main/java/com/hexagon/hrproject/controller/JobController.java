package com.hexagon.hrproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JobController {

    // 직급 목록 화면
    @GetMapping("/jobs")
    public String jobList() {
        return "job/list";
    }

    // 직급 등록 화면
    @GetMapping("/jobs/new")
    public String jobRegister() {
        return "job/register";
    }

    // 직급 수정 화면
    @GetMapping("/jobs/edit")
    public String jobEdit() {
        return "job/edit";
    }
}