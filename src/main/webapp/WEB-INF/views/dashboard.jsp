<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HRMS Admin - 대시보드</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
          rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        body {
            background: #f8fafc;
            color: #1e293b;
            display: flex;
            min-height: 100vh;
        }

        .main-area {
            margin-left: 240px;
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 32px 40px;
            position: relative;
        }

        .breadcrumb {
            font-size: 0.85rem;
            color: #64748b;
            margin-bottom: 6px;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }

        .card-link {
            text-decoration: none;
            color: inherit;
            display: block;
            transition: transform 0.15s, box-shadow 0.15s;
        }

        .card-link:hover {
            transform: translateY(-2px);
        }

        .card-link:hover .card {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border-color: #cbd5e1;
        }

        .card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        }

        .card-title {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 12px;
            font-weight: 500;
        }

        .card-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0f172a;
        }

        .table-container {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        }

        .table-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.9rem;
        }

        th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
        }

        td {
            color: #334155;
        }
    </style>
</head>

<body>

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="main-area">

        <div class="top-nav-bar">
            <div class="page-title-area">
                <div class="breadcrumb">HRMS / 대시보드</div>
                <h1>관리자 대시보드</h1>
            </div>

            <%@ include file="/WEB-INF/views/common/header.jspf" %>
        </div>

        <div class="content-body" style="padding: 0;">

            <div class="card-grid">

                <a href="${pageContext.request.contextPath}/employees"
                   class="card-link">
                    <div class="card">
                        <div class="card-title">전체 사원</div>
                        <div class="card-value">${stats.totalEmp}</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/employees?status=ACTIVE"
                   class="card-link">
                    <div class="card">
                        <div class="card-title">재직</div>
                        <div class="card-value" style="color: #2563eb;">
                            ${stats.activeEmp}
                        </div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/employees?status=LEAVE"
                   class="card-link">
                    <div class="card">
                        <div class="card-title">휴직</div>
                        <div class="card-value" style="color: #d97706;">
                            ${stats.leaveEmp}
                        </div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/employees?status=RESIGN"
                   class="card-link">
                    <div class="card">
                        <div class="card-title">퇴직</div>
                        <div class="card-value" style="color: #dc2626;">
                            ${stats.resignEmp}
                        </div>
                    </div>
                </a>

            </div>

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