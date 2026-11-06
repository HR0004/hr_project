
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HRMS - 사원 관리</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employee.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 사이드바 / 헤더 : 수정하지 않음 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>
    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <!-- 사원관리 본문 -->
    <div class="content-wrapper employee-page">

        <!-- 제목 -->
        <section class="content-header">
            <div class="container-fluid">
                <h1 class="employee-page-title">사원 관리</h1>
                <p class="employee-page-desc">
                    사원 조회 · 등록 · 수정 · 퇴직 처리
                </p>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 통계 카드 -->
                <div class="employee-stats">

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">전체 사원</div>
                        <div class="employee-stat-number" id="totalCount">0</div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">재직</div>
                        <div class="employee-stat-number" id="activeCount">0</div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">휴직</div>
                        <div class="employee-stat-number" id="leaveCount">0</div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">퇴직</div>
                        <div class="employee-stat-number" id="retiredCount">0</div>
                    </div>

                </div>

                <!-- 사원 목록 상단 -->
                <div class="employee-toolbar">

                    <h2 class="employee-list-title">사원 목록 조회</h2>

                    <div class="employee-toolbar-actions">

                        <!-- 검색 / 필터 -->
                        <a href="${pageContext.request.contextPath}/employees/search"
                           class="employee-search-btn"
                           style="display:inline-flex;align-items:center;
                                  justify-content:center;width:171px;
                                  min-width:171px;height:52px;
                                  padding:0 15px;border:1px solid #dce5f1;
                                  border-radius:11px;background:#fff;
                                  color:#172033;font-size:13px;
                                  font-weight:600;text-decoration:none;
                                  white-space:nowrap;box-sizing:border-box;">
                            &#9906; 검색 / 필터
                        </a>

                        <!-- 사원 등록 -->
                        <button type="button"
                                class="employee-register-btn"
                                onclick="registerEmployee()">
                            + 사원 등록
                        </button>

                    </div>
                </div>

                <!-- 사원 목록 -->
                <div class="employee-table-wrap">

                    <table id="employeeTable" class="employee-table">
                        <thead>
                            <tr>
                                <th>사번</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>직급</th>
                                <th>이메일</th>
                                <th>입사일</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody id="employeeTableBody"></tbody>
                    </table>

                    <div id="employeeEmpty" class="employee-empty">
                        등록된 사원이 없습니다.
                    </div>

                </div>

                <!-- 페이지네이션 -->
                <div class="employee-pagination-wrap">
                    <div id="employeePagination"
                         class="employee-pagination"></div>
                </div>

                <p class="employee-notice">
                    ※ 사원 선택 후 상세 조회, 정보 수정 또는 퇴직 처리를 진행합니다.
                </p>

            </div>
        </section>

    </div>
</div>

<!-- 기존 jQuery 유지 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
const contextPath = "${pageContext.request.contextPath}";

/* 사원 등록 */
function registerEmployee() {
    location.href = contextPath + "/employees/new";
}

/* 사원 상세 */
function viewEmployee(empId) {
    location.href = contextPath + "/employees/" +
        encodeURIComponent(empId);
}

/* 사원 목록 조회 */
async function loadEmployees(page = 1) {
    try {
        const response = await fetch(
            contextPath + "/api/employees/page?currentPage=" + page
        );

        if (!response.ok) {
            throw new Error("사원 목록 조회 실패");
        }

        const pager = await response.json();

        printEmployees(pager.list || []);
        printPagination(pager);

    } catch (error) {
        console.error("사원 목록 조회 오류:", error);

        document.getElementById("employeeTableBody").innerHTML = "";
        document.getElementById("employeePagination").innerHTML = "";

        const empty = document.getElementById("employeeEmpty");
        empty.textContent = "사원 목록을 불러오지 못했습니다.";
        empty.style.display = "block";
    }
}

/* 사원 목록 출력 */
function printEmployees(employees) {
    const tbody = $("#employeeTableBody").empty();
    const empty = document.getElementById("employeeEmpty");

    empty.textContent = "등록된 사원이 없습니다.";
    empty.style.display = employees.length === 0 ? "block" : "none";

    employees.forEach(emp => {
        const url = contextPath + "/employees/" + emp.empId;

        const status = {
            ACTIVE: ["재직", "status-active"],
            LEAVE: ["휴직", "status-leave"],
            RETIRED: ["퇴직", "status-retired"]
        }[emp.status] || ["미확인", ""];

        const tr = $("<tr>");

        $("<td>").text(emp.empId).appendTo(tr);

        $("<td>").append(
            $("<a>")
                .addClass("employee-name")
                .attr("href", url)
                .text(emp.ename)
        ).appendTo(tr);

        [
            emp.department?.departmentName ?? "-",
            emp.job?.jobName ?? "-",
            emp.email ?? "-",
            emp.hiredate
                ? new Date(emp.hiredate).toLocaleDateString("ko-KR")
                : "-"
        ].forEach(value => {
            $("<td>").text(value).appendTo(tr);
        });

        $("<td>").append(
            $("<span>")
                .addClass("employee-status " + status[1])
                .text(status[0])
        ).appendTo(tr);

        $("<td>").append(
            $("<a>")
                .addClass("employee-action-link")
                .attr("href", url)
                .text("상세"),
            " / ",
            $("<a>")
                .addClass("employee-action-link")
                .attr("href", url + "/edit")
                .text("수정")
        ).appendTo(tr);

        tbody.append(tr);
    });
}

/* 페이지네이션 */
function printPagination(pager) {
    const pagination =
        document.getElementById("employeePagination");

    pagination.innerHTML = "";

    if (!pager.totalPage) return;

    const addButton = (text, page, disabled = false, active = false) => {
        const btn = document.createElement("button");

        btn.type = "button";
        btn.textContent = text;
        btn.disabled = disabled;

        btn.className = active
            ? "employee-page-btn active"
            : "employee-page-btn";

        btn.addEventListener("click", () => loadEmployees(page));

        pagination.appendChild(btn);
    };

    addButton("‹", pager.firstPage - 1, pager.firstPage <= 1);

    for (let i = pager.firstPage; i <= pager.lastPage; i++) {
        addButton(i, i, false, i === pager.currentPage);
    }

    addButton("›", pager.lastPage + 1,
              pager.lastPage >= pager.totalPage);
}

/* 전체 사원 통계 */
async function loadEmployeeStats() {
    try {
        const response = await fetch(contextPath + "/api/employees");

        if (!response.ok) {
            throw new Error("통계 조회 실패");
        }

        const employees = await response.json();

        $("#totalCount").text(employees.length);
        $("#activeCount").text(
            employees.filter(emp => emp.status === "ACTIVE").length
        );
        $("#leaveCount").text(
            employees.filter(emp => emp.status === "LEAVE").length
        );
        $("#retiredCount").text(
            employees.filter(emp => emp.status === "RETIRED").length
        );

    } catch (error) {
        console.error("사원 통계 오류:", error);
    }
}

/* 페이지 초기화 */
document.addEventListener("DOMContentLoaded", () => {
    loadEmployees(1);
    loadEmployeeStats();
});
</script>

</body>
</html>
