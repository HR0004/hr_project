
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>HRMS - 내 급여 상세</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/salary.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <%@ include file="/WEB-INF/views/common/header.jspf" %>
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="content-wrapper salary-page">

        <section class="content-header">
            <div class="container-fluid salary-heading">

                <h1>내 급여 상세</h1>

                <p>
                    <c:out value="${salary.salaryYearMonth}"/>
                    급여의 지급 내역입니다.
                </p>

            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 안내 메시지 -->
                <div class="salary-notice">
                    본인의 급여 내역입니다.
                    금액 관련 문의는 급여 담당자에게 연락해 주세요.
                </div>

                <!-- 상세 정보 -->
                <div class="salary-detail-card">

                    <div class="salary-detail-header">

                        <h2>
                            <c:out value="${salary.salaryYearMonth}"/>
                            급여
                        </h2>

                        <p>
                            급여 ID S<c:out value="${salary.salaryId}"/>
                            ·
                            <c:out value="${salary.empId}"/>
                            <c:out value="${salary.employeeName}"/>
                        </p>

                    </div>

                    <div class="salary-detail-rows">

                        <div class="salary-detail-row">
                            <span>기본급</span>
                            <strong>
                                <fmt:formatNumber
                                    value="${salary.baseSalary}"
                                    pattern="#,##0"/> 원
                            </strong>
                        </div>

                        <div class="salary-detail-row">
                            <span>수당</span>
                            <strong>
                                <fmt:formatNumber
                                    value="${salary.bonus}"
                                    pattern="#,##0"/> 원
                            </strong>
                        </div>

                        <div class="salary-detail-row">
                            <span>공제액</span>
                            <strong>
                                <fmt:formatNumber
                                    value="${salary.deduction}"
                                    pattern="#,##0"/> 원
                            </strong>
                        </div>

                    </div>

                    <!-- 실수령액 -->
                    <div class="salary-detail-total">

                        <span>실수령액</span>

                        <strong>
                            <fmt:formatNumber
                                value="${salary.netSalary}"
                                pattern="#,##0"/> 원
                        </strong>

                    </div>

                    <!-- 지급일 -->
                    <div class="salary-detail-payment">

                        <span>지급일</span>

                        <strong>
                            <c:choose>
                                <c:when test="${not empty salary.paymentDate}">
                                    <c:out value="${salary.paymentDate}"/>
                                </c:when>
                                <c:otherwise>미정</c:otherwise>
                            </c:choose>
                        </strong>

                    </div>

                </div>

                <!-- 목록으로 이동 -->
                <div class="salary-detail-actions">

                    <a href="${pageContext.request.contextPath}/salary/my"
                       class="salary-confirm-btn">
                        목록으로
                    </a>

                </div>

            </div>
        </section>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

</body>
</html>
