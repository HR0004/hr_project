package com.hexagon.hrproject.controller;

import com.hexagon.hrproject.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(Model model) {
        Map<String, Object> stats = dashboardService.getDashboardStats();
        model.addAttribute("stats", stats);
        return "dashboard"; // /WEB-INF/views/dashboard.jsp 또는 설정된 뷰 리졸버 경로
    }
}