<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>HRMS - 마이페이지</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        body {
            margin: 0;
            background: #f8fafc;
        }

        .main-content.hrms-page {
            display: block;
            width: auto;
            min-height: 100vh;
            min-width: 0;
            overflow: visible;
            padding: 32px 40px;
            background: #f8fafc;
        }

        .profile-card {
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .profile-header {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        .profile-avatar {
            width: 60px;
            height: 60px;
            background: #e9ecef;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 20px;
        }

        .info-group {
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: bold;
            color: #6c757d;
            font-size: 13px;
        }

        .info-value {
            font-size: 16px;
            color: #212529;
        }

        @media (max-width: 600px) {
            .main-content.hrms-page {
                padding: 20px 14px;
            }
        }
    </style>
</head>

<body>

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="main-content main-area hrms-page">

        <div class="top-nav-bar">
            <div class="page-title-area">
                <h2>마이페이지</h2>
                <p style="color: #6c757d; margin-top: 6px;">
                    홈 &gt; 마이페이지
                </p>
            </div>

            <%@ include file="/WEB-INF/views/common/header.jspf" %>
        </div>

        <div class="profile-card">

            <div class="profile-header">
                <div class="profile-avatar">👤</div>

                <div>
                    <h3 style="margin: 0 0 5px; font-weight: bold;">
                        ${sessionScope.loginUser.emp.ename != null ? sessionScope.loginUser.emp.ename : '관리자'}님
                    </h3>
                    <span class="label label-primary">시스템 관리자</span>
                </div>
            </div>

            <h4 style="font-weight: bold; margin-bottom: 20px;">
                내 정보
            </h4>

            <div class="row">

                <div class="col-md-6 info-group">
                    <div class="info-label">아이디</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.loginId}
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">이름</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.emp.ename}
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">이메일</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.emp.email != null ? sessionScope.loginUser.emp.email : 'admin@hrms.com'}
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">연락처</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.emp.phone != null ? sessionScope.loginUser.emp.phone : '010-1234-5678'}
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">입사일</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.emp.hiredate != null ? sessionScope.loginUser.emp.hiredate : '2024-01-01'}
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">최종 로그인</div>
                    <div class="info-value">
                        ${sessionScope.loginUser.lastLoginAt != null ? sessionScope.loginUser.lastLoginAt : '방금 전'}
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>