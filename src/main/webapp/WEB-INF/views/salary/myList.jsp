
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

    <title>HRMS - 내 급여 조회</title>

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
                <h1>내 급여 조회</h1>
                <p>본인의 월별 급여와 지급 내역을 확인할 수 있습니다.</p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 최근 급여 요약 -->
                <div class="salary-stats">

                    <div class="salary-stat-card">
                        <span>선택 연월</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty latestSalary}">
                                    <c:out value="${latestSalary.salaryYearMonth}"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>기본급</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty latestSalary}">
                                    <fmt:formatNumber
                                        value="${latestSalary.baseSalary}"
                                        pattern="#,##0"/>원
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>실수령액</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty latestSalary}">
                                    <fmt:formatNumber
                                        value="${latestSalary.netSalary}"
                                        pattern="#,##0"/>원
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                    <div class="salary-stat-card">
                        <span>지급일</span>
                        <strong>
                            <c:choose>
                                <c:when test="${not empty latestSalary}">
                                    <c:out value="${latestSalary.paymentDate}"
                                           default="미정"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </strong>
                    </div>

                </div>

                <!-- 목록 제목 및 연도 검색 -->
                <div class="salary-toolbar">

                    <div class="salary-toolbar-title">
                        <h2>내 급여 목록</h2>
                        <p>
                            사번 <c:out value="${empId}"/> · 본인 급여
                        </p>
                    </div>

                    <form method="get"
                          action="${pageContext.request.contextPath}/salary/my"
                          class="salary-search-form">

                        <select name="year"
                                class="salary-input salary-month-input">

                            <option value="">연도 선택</option>

                            <c:forEach var="yearOption" items="${years}">
                                <option value="${yearOption}"
                                    <c:if test="${searchYear eq yearOption.toString()}">
                                        selected
                                    </c:if>>
                                    <c:out value="${yearOption}"/>년 전체 월
                                </option>
                            </c:forEach>

                        </select>

                        <button type="submit"
                                class="salary-register-btn">
                            조회
                        </button>
                    </form>

                </div>

                <!-- 본인 급여 목록 -->
                <div class="salary-table-wrap">

                    <table class="salary-table salary-my-table">

                        <thead>
                            <tr>
                                <th>지급 연월</th>
                                <th>기본급</th>
                                <th>수당</th>
                                <th>공제액</th>
                                <th>실수령액</th>
                                <th>지급일</th>
                            </tr>
                        </thead>

                        <tbody id="mySalaryTableBody">

                            <c:forEach var="salary" items="${salaries}">
                                <tr class="my-salary-row">

                                    <td>
                                        <a class="salary-detail-link"
                                           href="${pageContext.request.contextPath}/salary/my/detail/${salary.salaryId}">
                                            <c:out value="${salary.salaryYearMonth}"/>
                                        </a>
                                    </td>

                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.baseSalary}"
                                            pattern="#,##0"/>
                                    </td>

                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.bonus}"
                                            pattern="#,##0"/>
                                    </td>

                                    <td>
                                        <fmt:formatNumber
                                            value="${salary.deduction}"
                                            pattern="#,##0"/>
                                    </td>

                                    <td class="salary-net">
                                        <fmt:formatNumber
                                            value="${salary.netSalary}"
                                            pattern="#,##0"/>
                                    </td>

                                    <td>
                                        <c:out value="${salary.paymentDate}"
                                               default="미정"/>
                                    </td>

                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>

                    <c:if test="${empty salaries}">
                        <div class="salary-empty">
                            조회된 급여 내역이 없습니다.
                        </div>
                    </c:if>

                </div>

                <p class="salary-table-notice">
                    지급 연월을 선택하면 상세 화면으로 이동합니다.
                </p>

                <!-- 페이지 처리 -->
                <div class="salary-pagination-area">

                    <span id="mySalaryCount">
                        총 <c:out value="${salaries.size()}"/>건
                    </span>

                    <div id="mySalaryPagination"
                         class="salary-pagination">
                    </div>

                </div>

            </div>
        </section>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>
const mySalaryRows = Array.from(
    document.querySelectorAll(".my-salary-row")
);

const mySalaryPageSize = 10;
let mySalaryCurrentPage = 1;

function showMySalaryPage(page) {
    const totalPages =
        Math.ceil(mySalaryRows.length / mySalaryPageSize);

    mySalaryCurrentPage = page;

    const start = (page - 1) * mySalaryPageSize;

    mySalaryRows.forEach((row, index) => {
        row.style.display =
            index >= start && index < start + mySalaryPageSize
                ? ""
                : "none";
    });

    const pagination =
        document.getElementById("mySalaryPagination");

    pagination.innerHTML = "";

    if (totalPages <= 1) return;

    function addButton(text, target, disabled, active) {
        const btn = document.createElement("button");
        btn.type = "button";
        btn.textContent = text;
        btn.className =
            "salary-page-btn" + (active ? " active" : "");
        btn.disabled = disabled;

        btn.addEventListener("click", () => {
            showMySalaryPage(target);
        });

        pagination.appendChild(btn);
    }

    addButton("‹", page - 1, page === 1, false);

    for (let i = 1; i <= totalPages; i++) {
        addButton(i, i, false, i === page);
    }

    addButton("›", page + 1,
              page === totalPages, false);
}

showMySalaryPage(1);
</script>

</body>
</html>
