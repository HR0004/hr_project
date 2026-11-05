<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HRMS Admin - 대시보드</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Noto Sans KR', sans-serif; }
        body { background-color: #f8fafc; color: #1e293b; display: flex; min-height: 100vh; }
        
        .main-area {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 32px 40px;
            position: relative;
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
        
        .dropdown-header { 
            padding: 10px 16px; 
            font-size: 0.85rem; 
            color: #475569; 
            border-bottom: 1px solid #f1f5f9; 
            margin-bottom: 4px; 
        }
        
        .dropdown-item { 
            display: block; 
            padding: 10px 16px; 
            color: #334155; 
            text-decoration: none; 
            font-size: 0.9rem; 
        }
        .dropdown-item:hover { background-color: #f8fafc; }
        .dropdown-item.highlight {
            background-color: #f1f5f9;
            font-weight: 500;
        }
        .dropdown-item.danger { color: #dc2626; }

        /* 상단 지표 카드 그리드 */
        .card-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 32px; }
        .card-link { text-decoration: none; color: inherit; display: block; transition: transform 0.15s, box-shadow 0.15s; }
        .card-link:hover { transform: translateY(-2px); }
        .card-link:hover .card { box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-color: #cbd5e1; }

        .card { 
            background: #fff; 
            border: 1px solid #e2e8f0; 
            border-radius: 12px; 
            padding: 24px; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.02); 
        }
        .card-title { font-size: 0.9rem; color: #64748b; margin-bottom: 12px; font-weight: 500; }
        .card-value { font-size: 1.8rem; font-weight: 700; color: #0f172a; }

        /* 시스템 요약 테이블 영역 */
        .table-container { 
            background: #fff; 
            border: 1px solid #e2e8f0; 
            border-radius: 12px; 
            padding: 24px; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.02); 
        }
        .table-title { font-size: 1.1rem; font-weight: 600; color: #0f172a; margin-bottom: 16px; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; font-size: 0.9rem; }
        th { background-color: #f8fafc; color: #475569; font-weight: 600; }
        td { color: #334155; }
    </style>
</head>
<body>

    <!-- 사이드바 인클루드 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <!-- 메인 본문 영역 -->
    <div class="main-area">
        <!-- 상단 헤더 및 우측 프로필 영역 -->
        <div class="top-nav-bar">
            <div class="page-title-area">
                <div class="breadcrumb">HRMS / 대시보드</div>
                <h1>관리자 대시보드</h1>
            </div>

            <!-- 우측 상단 관리자 프로필 드롭다운 (사진 시안과 동일) -->
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

        <div class="content-body" style="padding: 0;">
            <!-- 상단 사원 상태 카드 (클릭 시 사원 관리 페이지로 이동) -->
            <div class="card-grid">
                <a href="${pageContext.request.contextPath}/employees" class="card-link">
                    <div class="card">
                        <div class="card-title">전체 사원</div>
                        <div class="card-value">${stats.totalEmp}</div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/employees?status=ACTIVE" class="card-link">
                    <div class="card">
                        <div class="card-title">재직</div>
                        <div class="card-value" style="color: #2563eb;">${stats.activeEmp}</div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/employees?status=LEAVE" class="card-link">
                    <div class="card">
                        <div class="card-title">휴직</div>
                        <div class="card-value" style="color: #d97706;">${stats.leaveEmp}</div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/employees?status=RESIGN" class="card-link">
                    <div class="card">
                        <div class="card-title">퇴직</div>
                        <div class="card-value" style="color: #dc2626;">${stats.resignEmp}</div>
                    </div>
                </a>
            </div>

            <!-- 시스템 현황 요약 테이블 -->
            <div class="table-container">
                <div class="table-title">시스템 현황 요약</div>
                <table>
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>상태 값</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>데이터베이스 연결</td>
                            <td>정상 (MySQL)</td>
                            <td>MyBatis 연동 완료</td>
                        </tr>
                        <tr>
                            <td>보안 및 라우팅</td>
                            <td>컨트롤러 매핑 완료</td>
                            <td>사원·부서·근태·휴가·권한 모듈 연동</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>