package com.hexagon.hrproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.service.AccountService;

@Controller
@RequestMapping("/admin/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    // 1. 권한/계정 관리 페이지 요청 (피그마 화면 렌더링)
    @GetMapping("/manage")
    public String manageForm(@RequestParam(value="accountId", required=false) Long accountId, Model model) {
        // 전체 역할(ROLE_EMPLOYEE, ROLE_HR_ADMIN 등) 목록 조회
        List<HrRole> roleList = accountService.getAllRoles();
        model.addAttribute("roleList", roleList);

        // 특정 계정이 선택된 경우 계정 상세 및 현재 보유 역할 조회
        if (accountId != null) {
            Account account = accountService.getAccountById(accountId);
            model.addAttribute("account", account);
        }
        
        return "admin/account_manage"; // WEB-INF/views/admin/account_manage.jsp
    }

    // 2. 권한(역할) 변경 저장 처리
    @PostMapping("/update-roles")
    public String updateRoles(@RequestParam("accountId") Long accountId,
                              @RequestParam(value="roleIds", required=false) List<Long> roleIds) {
        
        accountService.updateAccountRoles(accountId, roleIds);
        return "redirect:/admin/account/manage?accountId=" + accountId;
    }
}