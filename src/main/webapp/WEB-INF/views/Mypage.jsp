<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>HRMS - 마이페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
	/* 전체 배경 */
	body {
		background-color: #f8f9fa;
	}
	
	/* 만드신 사이드바(<aside class="main-sidebar">) 전용 디자인 스타일 */
	.main-sidebar {
		height: 100vh;
		background-color: #1a2332;
		color: #fff;
		position: fixed;
		width: 240px;
		top: 0;
		left: 0;
		padding-top: 20px;
	}
	.sidebar-logo {
		font-size: 18px;
		font-weight: bold;
		padding: 10px 20px;
		color: #fff;
		margin-bottom: 5px;
	}
	.sidebar-title {
		font-size: 13px;
		padding: 0 20px 20px 20px;
		color: #adb5bd;
		border-bottom: 1px solid rgba(255,255,255,0.1);
		margin-bottom: 15px;
	}
	.sidebar-menu .menu-item {
		color: #adb5bd;
		padding: 12px 20px;
		display: block;
		text-decoration: none;
	}
	.sidebar-menu .menu-item.active, .sidebar-menu .menu-item:hover {
		color: #fff;
		background-color: #0d6efd;
		text-decoration: none;
	}

	/* 우측 메인 컨텐츠 영역 (사이드바 너비 240px 만큼 왼쪽 여백 확보) */
	.main-content {
		margin-left: 240px;
		padding: 30px;
	}
	.profile-card {
		background: #fff;
		border-radius: 8px;
		padding: 30px;
		box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
		background-color: #e9ecef;
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
</style>
</head>
<body>

	<!-- 따로 분리해 둔 공통 사이드바 조각 파일 불러오기 -->
	<%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

	<!-- 우측 메인 컨텐츠 영역 -->
	<div class="main-content">
		<h2>마이페이지</h2>
		<p style="color: #6c757d; margin-bottom: 25px;">홈 > 마이페이지</p>

		<div class="profile-card">
			<div class="profile-header">
				<div class="profile-avatar">👤</div>
				<div>
					<h3 style="margin: 0 0 5px 0; font-weight: bold;">${sessionScope.loginUser.emp.ename != null ? sessionScope.loginUser.emp.ename : '관리자'}님</h3>
					<span class="label label-primary">시스템 관리자</span>
				</div>
			</div>

			<h4 style="font-weight: bold; margin-bottom: 20px;">내 정보</h4>

			<div class="row">
				<div class="col-md-6 info-group">
					<div class="info-label">아이디</div>
					<div class="info-value">${sessionScope.loginUser.loginId}</div>
				</div>
				<div class="col-md-6 info-group">
					<div class="info-label">이름</div>
					<div class="info-value">${sessionScope.loginUser.emp.ename}</div>
				</div>
				<div class="col-md-6 info-group">
					<div class="info-label">이메일</div>
					<div class="info-value">${sessionScope.loginUser.emp.email != null ? sessionScope.loginUser.emp.email : 'admin@hrms.com'}</div>
				</div>
				<div class="col-md-6 info-group">
					<div class="info-label">연락처</div>
					<div class="info-value">${sessionScope.loginUser.emp.phone != null ? sessionScope.loginUser.emp.phone : '010-1234-5678'}</div>
				</div>
				<div class="col-md-6 info-group">
					<div class="info-label">입사일</div>
					<div class="info-value">${sessionScope.loginUser.emp.hiredate != null ? sessionScope.loginUser.emp.hiredate : '2024-01-01'}</div>
				</div>
				<div class="col-md-6 info-group">
					<div class="info-label">최종 로그인</div>
					<div class="info-value">${sessionScope.loginUser.lastLoginAt != null ? sessionScope.loginUser.lastLoginAt : '방금 전'}</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>