<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hexagon.hrproject.domain.Account"%>
<%@ page import="com.hexagon.hrproject.domain.HrRole"%>
<!DOCTYPE html>
<html>
<head>
<title>계정 및 권한 관리</title>
</head>
<body>
	<h2>사원 계정 및 역할(Role) 설정</h2>

	<%
	// 모델에서 account 객체 가져오기
	Account account = (Account) request.getAttribute("account");
	if (account != null) {
	%>
	<form
		action="<%=request.getContextPath()%>/admin/account/update-roles"
		method="post">
		<input type="hidden" name="accountId"
			value="<%=account.getAccountId()%>" />

		<h3>
			계정 정보:
			<%=account.getLoginId()%>
			(<%=account.getEmp() != null ? account.getEmp().getEname() : ""%>)
		</h3>

		<h4>부여할 역할 선택:</h4>
		<%
		// 전체 역할 목록과 사용자가 가진 역할 목록 가져오기
		List<HrRole> roleList = (List<HrRole>) request.getAttribute("roleList");
		List<HrRole> userRoles = account.getRoles();

		if (roleList != null) {
			for (HrRole role : roleList) {
				// 현재 사용자가 이 역할을 가지고 있는지 체크
				boolean isChecked = false;
				if (userRoles != null) {
			for (HrRole userRole : userRoles) {
				if (userRole != null && role != null && userRole.getHrRoleId() == role.getHrRoleId()) {
			        isChecked = true;
			        break;
			    }
			}
				}
		%>
		<label> <input type="checkbox" name="roleIds"
			value="<%=role.getHrRoleId()%>" <%=isChecked ? "checked" : ""%> />
			<%=role.getRoleName()%> (<%=role.getRoleCode()%>)
		</label><br />
		<%
		}
		}
		%>

		<br />
		<button type="submit">권한 저장하기</button>
	</form>
	<%
	}
	%>
</body>
</html>