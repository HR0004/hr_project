
package com.hexagon.hrproject.rest.controller;

import java.time.Year;
import java.time.ZoneId;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hexagon.hrproject.domain.Emp;
import com.hexagon.hrproject.domain.LeaveBalance;
import com.hexagon.hrproject.domain.LeaveRequestHistory;
import com.hexagon.hrproject.domain.LeaveUsage;
import com.hexagon.hrproject.exception.BusinessException;
import com.hexagon.hrproject.exception.ErrorCode;
import com.hexagon.hrproject.service.LeaveService;
import com.hexagon.hrproject.spring.security.AccountDetails;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/leave")
@RequiredArgsConstructor
public class LeaveApiController {

    private final LeaveService leaveService;

    @GetMapping("/my/balance")
    public LeaveBalance getLeaveBalance(
            @AuthenticationPrincipal AccountDetails accountDetails) {

        // 로그인 여부 확인
        if (accountDetails == null
                || accountDetails.getAccount() == null) {

            throw new BusinessException(
                ErrorCode.LOGIN_REQUIRED
            );
        }

        // 로그인한 계정에 연결된 사원 확인
        Emp loginEmp = accountDetails.getAccount().getEmp();

        if (loginEmp == null) {
            throw new BusinessException(
                ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED
            );
        }

        String fiscalYear = "2026";

        // 로그인한 본인의 휴가 잔여 일수만 조회
        return leaveService.findBalanceByEmpId(
            loginEmp.getEmpId(),
            fiscalYear
        );
    }
}
	private final LeaveService leaveService;

	// 로그인한 사원 번호 가져오기
	private int getLoginEmpId(AccountDetails accountDetails) {

		if (accountDetails == null || accountDetails.getAccount() == null) {
			throw new BusinessException(ErrorCode.LOGIN_REQUIRED);
		}

		if (accountDetails.getAccount().getEmp() == null) {
			throw new BusinessException(ErrorCode.EMPLOYEE_ACCOUNT_NOT_LINKED);
		}

		return accountDetails.getAccount().getEmp().getEmpId();
	}

	// 나의 휴가 잔액 조회
	@GetMapping("/my/balance")
	public LeaveBalance getLeaveBalance(@AuthenticationPrincipal AccountDetails accountDetails) {

		int empId = getLoginEmpId(accountDetails);

		String fiscalYear = String.valueOf(Year.now(ZoneId.of("Asia/Seoul")).getValue());

		return leaveService.findBalanceByEmpId(empId, fiscalYear);
	}

	// 나의 휴가 사용 내역 조회
	@GetMapping("/my/used")
	public List<LeaveUsage> getMyUsedLeave(@AuthenticationPrincipal AccountDetails accountDetails) {

		int empId = getLoginEmpId(accountDetails);

		return leaveService.findUsedLeaveByEmpId(empId);
	}

	// 로그인한 사원의 휴가 신청 내역
	@GetMapping("/my/requests")
	public List<LeaveRequestHistory> getMyRequests(@AuthenticationPrincipal AccountDetails accountDetails) {

		int empId = getLoginEmpId(accountDetails);

		return leaveService.findRequestHistoryByEmpId(empId);

	}

	// 로그인한 사원의 휴가 신청
	@PostMapping("/my/requests")
	public Map<String, String> applyLeave(@AuthenticationPrincipal AccountDetails accountDetails,
			@RequestBody Map<String, String> request) {

		int empId = getLoginEmpId(accountDetails);

		leaveService.applyLeave(empId, request.get("startDate"), request.get("endDate"), request.get("halfDayType"),
				request.get("reason"));

		return Collections.singletonMap("message", "휴가 신청이 접수되었습니다.");
	}

}
