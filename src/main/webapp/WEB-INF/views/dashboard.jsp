
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>HRMS Admin - 대시보드</title>

    <!-- 기존 공통 디자인 유지 -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <!-- 대시보드 내부 전용 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 사이드바 : 수정하지 않음 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <!-- 공통 헤더 : 수정하지 않음 -->
    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <!-- 대시보드 메인 영역 -->
    <div class="content-wrapper">

        <section class="content-header">
            <div class="container-fluid">

                <!-- 페이지 제목 -->
                <div class="dashboard-heading">

                    <h1 class="dashboard-heading-title">
                        관리자 대시보드
                    </h1>

                    <p class="dashboard-heading-desc">
                        인사관리 시스템의 전체 현황을 확인할 수 있습니다.
                    </p>

                </div>

            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- =========================
                     1. 사원 현황 카드
                ========================== -->
                <div class="dashboard-stats">

                    <!-- 전체 사원 -->
                    <a href="${pageContext.request.contextPath}/employees"
                       class="dashboard-stat-link">

                        <div class="dashboard-stat-card">

                            <div class="dashboard-stat-label">
                                전체 사원
                            </div>

                            <div class="dashboard-stat-value">
                                ${stats.totalEmp}
                            </div>

                        </div>

                    </a>

                    <!-- 재직 -->
                    <a href="${pageContext.request.contextPath}/employees?status=ACTIVE"
                       class="dashboard-stat-link">

                        <div class="dashboard-stat-card">

                            <div class="dashboard-stat-label">
                                재직
                            </div>

                            <div class="dashboard-stat-value">
                                ${stats.activeEmp}
                            </div>

                        </div>

                    </a>

                    <!-- 휴직 -->
                    <a href="${pageContext.request.contextPath}/employees?status=LEAVE"
                       class="dashboard-stat-link">

                        <div class="dashboard-stat-card">

                            <div class="dashboard-stat-label">
                                휴직
                            </div>

                            <div class="dashboard-stat-value">
                                ${stats.leaveEmp}
                            </div>

                        </div>

                    </a>

                    <!-- 퇴직 -->
                    <a href="${pageContext.request.contextPath}/employees?status=RESIGN"
                       class="dashboard-stat-link">

                        <div class="dashboard-stat-card">

                            <div class="dashboard-stat-label">
                                퇴직
                            </div>

                            <div class="dashboard-stat-value">
                                ${stats.resignEmp}
                            </div>

                        </div>

                    </a>

                </div>

                <!-- =========================
                     2. 시스템 현황 요약
                ========================== -->
                <div class="dashboard-system">

                    <h2 class="dashboard-system-title">
                        시스템 현황 요약
                    </h2>

                    <div class="dashboard-table-scroll">

                        <table class="dashboard-system-table">

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
                                    <td>
                                        사원·부서·근태·휴가·권한 모듈 연동
                                    </td>
                                </tr>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>
        </section>

    </div>

</div>

<!-- AdminLTE 스크립트 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

</body>
</html>
