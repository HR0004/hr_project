package com.hexagon.hrproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.service.AccountService;

//관리자
@Controller
@RequestMapping("/admin/accounts") // 자원 복수형태인 accounts로 명시
public class AccountController {

    @Autowired
    private AccountService accountService;

    // 1. 특정 사원 계정 상세 및 권한 관리 화면 조회
    // GET /admin/accounts/1 (URL 자체에 사원 ID(자원)가 포함됨)
    @GetMapping("/{accountId}")
    public String getAccountDetail(@PathVariable("accountId") Long accountId, Model model) {
        List<HrRole> roleList = accountService.getAllRoles();
        model.addAttribute("roleList", roleList);

        if (accountId != null) {
            Account account = accountService.getAccountById(accountId);
            model.addAttribute("account", account);
        }
        
        return "admin/account_manage"; 
    }

    // 2. 권한 변경 저장 처리
    // POST /admin/accounts/1/roles (1번 사원의 roles 자원을 수정/반영)
    @PostMapping("/{accountId}/roles")
    public String updateAccountRoles(@PathVariable("accountId") Long accountId,
                                  @RequestParam(value = "roleIds", required = false) List<Long> roleIds) {
        
        accountService.updateAccountRoles(accountId, roleIds);
        
        // 처리가 끝난 후 해당 계정의 상세 페이지로 리다이렉트
        return "redirect:/admin/accounts/" + accountId;
    }
}