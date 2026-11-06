
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>HRMS - 급여 오류</title>

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

        <section class="content">
            <div class="container-fluid">

                <div class="salary-error-container">

                    <div class="salary-error-icon">!</div>

                    <h1>급여 정보를 확인할 수 없습니다.</h1>

                    <p>
                        <c:choose>
                            <c:when test="${not empty errorMessage}">
                                <c:out value="${errorMessage}"/>
                            </c:when>
                            <c:otherwise>
                                요청하신 급여 정보를 처리할 수 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <a href="${pageContext.request.contextPath}/salary/list"
                       class="salary-confirm-btn">
                        급여 목록으로 돌아가기
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
