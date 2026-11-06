package com.hexagon.hrproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hexagon.hrproject.domain.Account;
import com.hexagon.hrproject.domain.HrRole;
import com.hexagon.hrproject.service.AccountRolePreviewService;
import com.hexagon.hrproject.service.AccountService;

@Controller
@RequestMapping("/admin/accounts")
@PreAuthorize("hasRole('HR_ADMIN')")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountRolePreviewService accountRolePreviewService;

    // 계정 목록
    @GetMapping({ "", "/" })
    public String getAccountList(
            @RequestParam(value = "keyword", required = false)
                String keyword,
            Model model) {

        List<Account> accountList =
            accountService.getAccountList(keyword);

        model.addAttribute("accountList", accountList);
        model.addAttribute(
            "keyword",
            keyword == null ? "" : keyword.trim()
        );

        return "admin/account_list";
    }

    // 역할 선택 및 권한 미리보기 화면
    @GetMapping("/{accountId}")
    public String getAccountDetail(
            @PathVariable("accountId") Long accountId,
            Model model) {

        Account account =
            accountService.getAccountById(accountId);

        List<HrRole> roleList =
            accountService.getAllRoles();

        model.addAttribute("account", account);
        model.addAttribute("roleList", roleList);

        model.addAttribute(
            "rolePermissions",
            accountRolePreviewService.getRolePermissions()
        );

        return "admin/account_manage";
    }

    // 권한 저장
    @PostMapping("/{accountId}/roles")
    public String updateAccountRoles(
            @PathVariable("accountId") Long accountId,
            @RequestParam(value = "roleIds", required = false)
                List<Long> roleIds,
            RedirectAttributes redirectAttributes) {

        accountService.updateAccountRoles(accountId, roleIds);

        // 실제 저장이 성공한 뒤에만 완료 메시지 표시
        redirectAttributes.addFlashAttribute(
            "roleSaveSuccess",
            true
        );

        return "redirect:/admin/accounts/" + accountId;
    }
}