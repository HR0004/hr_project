
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HRMS - 급여 관리</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<!-- css -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/static/css/salary.css">
    
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 헤더 -->
    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <!-- 공통 사이드바 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="content-wrapper salary-page">

        <!-- 페이지 제목 -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="salary-heading">
                    <h1>급여 관리</h1>
                    <p>사원별 월 급여를 조회하고 관리합니다.</p>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 통계 카드 -->
                <div class="salary-stats">

                    <div class="salary-stat-card">
                        <span>급여 대상</span>
                        <strong id="salaryEmployeeCount">0명</strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>지급 예정</span>
                        <strong id="salaryRecordCount">0건</strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>급여 총액</span>
                        <strong id="salaryTotalAmount">0원</strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>조회 연월</span>
                        <strong id="salaryMonthInfo">전체</strong>
                    </div>

                </div>

                <!-- 급여 목록 툴바 -->
                <div class="salary-toolbar">

                    <div class="salary-toolbar-title">
                        <h2>급여 목록</h2>
                        <p>조회 범위 · 권한이 허용된 사원</p>
                    </div>

                    <!-- 기존 SalaryController.list()와 연결 -->
                    <form id="salarySearchForm"
                          method="get"
                          action="${pageContext.request.contextPath}/salary/list"
                          class="salary-search-form">

                        <!-- 지급 연월 -->
                        <input type="month"
                               id="salaryYearMonth"
                               name="salaryYearMonth"
                               value="<c:out value='${salaryYearMonth}'/>"
                               aria-label="지급 연월"
                               class="salary-input salary-month-input">

                        <!-- 사번 / 사원명 -->
                        <input type="text"
                               id="employeeKeyword"
                               name="employeeKeyword"
                               value="<c:out value='${employeeKeyword}'/>"
                               placeholder="사번 / 사원명 검색"
                               aria-label="사번 또는 사원명"
                               maxlength="50"
                               class="salary-input salary-keyword-input">

                        <button type="submit"
                                class="salary-search-btn">
                            <i class="fas fa-search"></i>
                            검색
                        </button>
                    </form>

                    <!-- 급여 등록 -->
                    <a href="${pageContext.request.contextPath}/salary/create"
                       class="salary-register-btn">
                        + 급여 등록
                    </a>

                </div>

                <!-- 검색 오류 -->
                <c:if test="${not empty salarySearchError}">
                    <div class="salary-alert salary-alert-error">
                        <c:out value="${salarySearchError}"/>
                    </div>
                </c:if>

                <!-- 급여 테이블 -->
                <div class="salary-table-wrap">

                    <table class="salary-table" id="salaryTable">

                        <thead>
                            <tr>
                                <th>급여 ID</th>
                                <th>사원</th>
                                <th>지급 연월</th>
                                <th>기본급</th>
                                <th>수당</th>
                                <th>공제액</th>
                                <th>실수령액</th>
                            </tr>
                        </thead>

                        <tbody id="salaryTableBody">

                            <c:forEach var="salary" items="${salaries}">
                                <tr class="salary-data-row"
                                    data-emp-id="${salary.empId}"
                                    data-net-salary="${salary.netSalary}">

                                    <!-- 급여 ID -->
                                    <td>
                                        <a class="salary-detail-link"
                                           href="${pageContext.request.contextPath}/salary/detail/${salary.salaryId}">
                                            S<c:out value="${salary.salaryId}"/>
                                        </a>
                                    </td>

                                    <!-- 사원 -->
                                    <td>
                                        <c:out value="${salary.empId}"/>
                                        <c:out value="${salary.employeeName}"/>
                                    </td>

                                    <!-- 지급 연월 -->
                                    <td>
                                        <c:out value="${salary.salaryYearMonth}"/>
                                    </td>

                                    <!-- 기본급 -->
                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.baseSalary}"
                                            pattern="#,##0"/>
                                    </td>

                                    <!-- 수당 -->
                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.bonus}"
                                            pattern="#,##0"/>
                                    </td>

                                    <!-- 공제액 -->
                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.deduction}"
                                            pattern="#,##0"/>
                                    </td>

                                    <!-- 실수령액 -->
                                    <td class="salary-net">
                                        <fmt:formatNumber
                                            value="${salary.netSalary}"
                                            pattern="#,##0"/>
                                    </td>

                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>

                    <!-- 조회 결과 없음 -->
                    <div id="salaryEmpty"
                         class="salary-empty"
                         style="display:none;">
                        조회된 급여 내역이 없습니다.
                    </div>

                </div>

                <p class="salary-table-notice">
                    급여 ID를 선택하면 상세 화면으로 이동합니다.
                </p>

                <!-- 페이지 처리 -->
                <div class="salary-pagination-area">

                    <span id="salaryCountInfo">총 0건</span>

                    <div id="salaryPagination"
                         class="salary-pagination">
                    </div>

                </div>

            </div>
        </section>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- AdminLTE -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>

// ==========================================
// 1. 급여 목록 페이지 처리
// ==========================================

const salaryRows = Array.from(
    document.querySelectorAll(".salary-data-row")
);

const salaryPageSize = 10;
let salaryCurrentPage = 1;

function showSalaryPage(page) {

    const totalCount = salaryRows.length;
    const totalPages = Math.ceil(totalCount / salaryPageSize);

    if (totalPages === 0) {
        salaryCurrentPage = 1;
    } else {
        salaryCurrentPage = Math.max(
            1, Math.min(page, totalPages)
        );
    }

    const startIndex =
        (salaryCurrentPage - 1) * salaryPageSize;

    const endIndex = startIndex + salaryPageSize;

    salaryRows.forEach((row, index) => {
        row.style.display =
            index >= startIndex && index < endIndex
                ? ""
                : "none";
    });

    document.getElementById("salaryEmpty").style.display =
        totalCount === 0 ? "block" : "none";

    document.getElementById("salaryCountInfo").textContent =
        "총 " + totalCount + "건";

    printSalaryPagination(totalPages);
}


// ==========================================
// 2. 페이지 번호 출력
// ==========================================

function printSalaryPagination(totalPages) {

    const pagination =
        document.getElementById("salaryPagination");

    pagination.innerHTML = "";

    if (totalPages === 0) {
        return;
    }

    function addButton(label, page, disabled, active) {

        const button = document.createElement("button");

        button.type = "button";
        button.textContent = label;
        button.disabled = disabled;

        button.className = active
            ? "salary-page-btn active"
            : "salary-page-btn";

        button.addEventListener("click", () => {
            showSalaryPage(page);
        });

        pagination.appendChild(button);
    }

    // 이전 페이지
    addButton(
        "‹",
        salaryCurrentPage - 1,
        salaryCurrentPage === 1,
        false
    );

    // 페이지 번호
    for (let i = 1; i <= totalPages; i++) {
        addButton(
            i,
            i,
            false,
            i === salaryCurrentPage
        );
    }

    // 다음 페이지
    addButton(
        "›",
        salaryCurrentPage + 1,
        salaryCurrentPage === totalPages,
        false
    );
}


// ==========================================
// 3. 급여 통계 출력
// ==========================================

function printSalaryStats() {

    // 현재 조회된 급여 데이터 기준
    const uniqueEmployees = new Set();
    let totalAmount = 0;

    salaryRows.forEach(row => {

        uniqueEmployees.add(row.dataset.empId);

        totalAmount += Number(
            row.dataset.netSalary || 0
        );
    });

    document.getElementById("salaryEmployeeCount").textContent =
        uniqueEmployees.size + "명";

    document.getElementById("salaryRecordCount").textContent =
        salaryRows.length + "건";

    document.getElementById("salaryTotalAmount").textContent =
        totalAmount.toLocaleString("ko-KR") + "원";

    const month =
        document.getElementById("salaryYearMonth").value;

    document.getElementById("salaryMonthInfo").textContent =
        month || "전체";
}


// ==========================================
// 4. 화면 초기화
// ==========================================

document.addEventListener("DOMContentLoaded", () => {

    printSalaryStats();
    showSalaryPage(1);

});

</script>

</body>
</html>
