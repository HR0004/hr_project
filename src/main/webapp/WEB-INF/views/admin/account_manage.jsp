<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hexagon.hrproject.domain.Account"%>
<%@ page import="com.hexagon.hrproject.domain.HrRole"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HRMS Admin - 권한 및 역할 설정</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Noto Sans KR', sans-serif; }
        body { background-color: #fffff; color: #1e293b; display: flex; min-height: 100vh; }
        
        .main-area {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 32px 40px;
        }

        /* 상단 네비게이션 및 프로필 영역 */
        .top-nav-bar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 32px;
        }
        .breadcrumb { font-size: 0.85rem; color: #64748b; margin-bottom: 6px; }
        .page-title-area h1 { font-size: 1.5rem; color: #0f172a; font-weight: 700; }

        /* 우측 상단 관리자 프로필 박스 및 드롭다운 */
        .admin-profile-container { position: relative; display: inline-block; }
        .profile-btn {
            background: #fff;
            border: 1px solid #e2e8f0;
            padding: 8px 20px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            box-shadow: 0 1px 2px rgba(0,0,0,0.02);
            color: #334155;
        }
        .profile-dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 44px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            width: 220px;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.08);
            z-index: 100;
            padding: 8px 0;
        }
        .admin-profile-container:hover .profile-dropdown { display: block; }
        .dropdown-header { padding: 10px 16px; font-size: 0.85rem; color: #475569; border-bottom: 1px solid #f1f5f9; margin-bottom: 4px; }
        .dropdown-item { display: block; padding: 10px 16px; color: #334155; text-decoration: none; font-size: 0.9rem; }
        .dropdown-item:hover { background-color: #f8fafc; }
        .dropdown-item.highlight { background-color: #f1f5f9; font-weight: 500; }
        .dropdown-item.danger { color: #dc2626; }

        /* 컨텐츠 박스 스타일 */
        .content-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        .account-info-title {
            font-size: 1.15rem;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        .section-subtitle {
            font-size: 0.95rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 16px;
        }
        
        /* 역할 체크박스 리스트 스타일 */
        .role-list-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 28px;
        }
        .role-label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
            color: #334155;
            cursor: pointer;
            padding: 10px 14px;
            border: 1px solid #f1f5f9;
            border-radius: 8px;
            background-color: #f8fafc;
            transition: background-color 0.15s;
        }
        .role-label:hover { background-color: #f1f5f9; }
        .role-label input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #2563eb;
            cursor: pointer;
        }

        /* 저장 버튼 스타일 */
        .btn-save {
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.15s;
        }
        .btn-save:hover { background-color: #1d4ed8; }
    </style>
</head>
<body>

    <!-- 사이드바 인클루드 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <!-- 메인 본문 영역 -->
    <div class="main-area">
        <!-- 상단 네비게이션 및 프로필 영역 -->
        <div class="top-nav-bar">
            <div class="page-title-area">
                <div class="breadcrumb">HRMS / 권한 관리</div>
                <h1>사원 계정 및 역할(Role) 설정</h1>
            </div>

            <!-- 우측 상단 관리자 프로필 드롭다운 -->
            <div class="admin-profile-container">
                <button class="profile-btn">관리자</button>
                <div class="profile-dropdown">
                    <div class="dropdown-header">
                        정하늘 팀장 · 백엔드팀
                    </div>
                    <a href="${pageContext.request.contextPath}/mypage" class="dropdown-item">내 정보</a>
                    <a href="${pageContext.request.contextPath}/admin/accounts/1" class="dropdown-item highlight">권한 위임 관리</a>
                    <a href="${pageContext.request.contextPath}/logout" class="dropdown-item danger">로그아웃</a>
                </div>
            </div>
        </div>

        <!-- 본문 카드 영역 -->
        <div class="content-card">
            <%
            Account account = (Account) request.getAttribute("account");
            if (account != null) {
            %>
            <form action="<%=request.getContextPath()%>/admin/accounts/<%=account.getAccountId()%>/roles" method="post">
                <input type="hidden" name="accountId" value="<%=account.getAccountId()%>" />

                <div class="account-info-title">
                    계정 정보: <strong><%=account.getLoginId()%></strong> 
                    (<%=account.getEmp() != null ? account.getEmp().getEname() : ""%>)
                </div>

                <div class="section-subtitle">부여할 역할 선택</div>

                <div class="role-list-container">
                    <%
                    List<HrRole> roleList = (List<HrRole>) request.getAttribute("roleList");
                    List<HrRole> userRoles = account.getRoles();

                    if (roleList != null) {
                        for (HrRole role : roleList) {
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
                    <label class="role-label">
                        <input type="checkbox" name="roleIds" value="<%=role.getHrRoleId()%>" <%=isChecked ? "checked" : ""%> />
                        <span><strong><%=role.getRoleName()%></strong> (<%=role.getRoleCode()%>)</span>
                    </label>
                    <%
                        }
                    }
                    %>
                </div>

                <button type="submit" class="btn-save">권한 저장하기</button>
            </form>
            <%
            } else {
            %>
                <p style="color: #64748b;">조회된 계정 정보가 없습니다.</p>
            <%
            }
            %>
        </div>
    </div>

</body>
</html>