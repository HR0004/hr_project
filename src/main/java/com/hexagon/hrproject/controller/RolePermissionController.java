package com.hexagon.hrproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hexagon.hrproject.service.RolePermissionService;

@Controller
@RequestMapping("/admin/roles/permissions")
@PreAuthorize(
    "hasRole('HR_ADMIN') and hasAuthority('PERMISSION_ROLE_MANAGE')"
)
public class RolePermissionController {

    private final RolePermissionService service;

    @Autowired
    public RolePermissionController(RolePermissionService service) {
        this.service = service;
    }

    @GetMapping
    public String page(
            @RequestParam(value = "roleId", required = false)
                Long roleId,
            Model model) {

        model.addAllAttributes(service.page(roleId));

        return "admin/role_permission";
    }

    @PostMapping
    public String save(
            @RequestParam("roleId") long roleId,
            @RequestParam(value = "permissionIds", required = false)
                List<Long> permissionIds,
            RedirectAttributes redirect) {

        try {
            service.savePermissions(roleId, permissionIds);

            redirect.addFlashAttribute(
                "rolePermissionMessage",
                "권한 변경이 완료되었습니다."
            );

        } catch (IllegalArgumentException ex) {
            redirect.addFlashAttribute(
                "rolePermissionMessage",
                ex.getMessage()
            );
        }

        redirect.addAttribute("roleId", roleId);

        return "redirect:/admin/roles/permissions";
    }
}