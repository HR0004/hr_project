
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HRMS - 사원 조회 · 검색</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/employee.css">

<style>
/* 검색 화면 본문 전용 CSS - 공통 헤더/사이드바 제외 */

.employee-search-page {
    background: #fff;
    color: #172033;
    font-family: "Malgun Gothic", Arial, sans-serif;
    font-size: 13px;
    min-height: 100vh;
    padding: 0 30px 50px;
    box-sizing: border-box;
}

.employee-search-page *,
.employee-search-page *::before,
.employee-search-page *::after {
    box-sizing: border-box;
}

.employee-search-page .content-header {
    padding: 25px 0 22px;
}

.employee-search-page .container-fluid {
    width: 100%;
    padding: 0;
    margin: 0;
}

.employee-search-page .employee-page-title {
    margin: 0 0 10px;
    color: #172033;
    font-size: 19px;
    font-weight: 700;
    line-height: 1.5;
}

.employee-search-page .employee-page-desc {
    margin: 0;
    color: #728199;
    font-size: 13px;
    line-height: 1.6;
}

.employee-search-page .content {
    padding: 0;
}

/* 검색 카드 */
.employee-search-page .search-panel {
    background: #fff;
    border: 1px solid #dce5f1;
    border-radius: 11px;
    padding: 26px 30px;
    margin-bottom: 26px;
}

.employee-search-page .search-section-title {
    margin: 0 0 24px;
    font-size: 16px;
    font-weight: 700;
    color: #172033;
}

/* 검색 조건 4열 */
.employee-search-page .search-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 22px 20px;
}

.employee-search-page .search-field {
    min-width: 0;
}

.employee-search-page .search-field label {
    display: block;
    margin: 0 0 9px;
    color: #172033;
    font-size: 13px;
    font-weight: 600;
}

.employee-search-page .search-input {
    display: block;
    width: 100%;
    height: 46px;
    padding: 0 13px;
    border: 1px solid #dce5f1;
    border-radius: 9px;
    background: #fff;
    color: #172033;
    font-family: inherit;
    font-size: 13px;
    outline: none;
}

.employee-search-page .search-input:focus {
    border-color: #7691b9;
    box-shadow: 0 0 0 3px rgba(118, 145, 185, .1);
}

.employee-search-page .search-input::placeholder {
    color: #9aa8bc;
}

/* 입사일과 버튼 */
.employee-search-page .search-bottom {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 20px;
    margin-top: 22px;
}

.employee-search-page .search-date-field {
    width: 50%;
    min-width: 0;
}

.employee-search-page .date-range {
    display: flex;
    align-items: center;
    gap: 12px;
}

.employee-search-page .date-range .search-input {
    flex: 1;
    min-width: 0;
}

.employee-search-page .date-separator {
    color: #728199;
    font-size: 14px;
}

.employee-search-page .search-actions {
    display: flex;
    align-items: center;
    gap: 12px;
}

.employee-search-page .search-btn {
    min-width: 110px;
    height: 46px;
    padding: 0 20px;
    border: 1px solid #dce5f1;
    border-radius: 9px;
    background: #fff;
    color: #172033;
    font-family: inherit;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

.employee-search-page .search-btn:hover {
    background: #f5f7fb;
}

.employee-search-page .search-btn-primary {
    background: #111a30;
    border-color: #111a30;
    color: #fff;
}

.employee-search-page .search-btn-primary:hover {
    background: #27334c;
}

/* 검색 결과 */
.employee-search-page .search-results {
    width: 100%;
}

.employee-search-page .search-result-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    margin-bottom: 20px;
}

.employee-search-page .search-result-title {
    margin: 0;
    font-size: 16px;
    font-weight: 700;
    color: #172033;
}

.employee-search-page #resultCount {
    margin-left: 8px;
    color: #2563eb;
    font-size: 14px;
}

.employee-search-page .back-list-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 42px;
    padding: 0 18px;
    border: 1px solid #dce5f1;
    border-radius: 9px;
    background: #fff;
    color: #172033;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;
    white-space: nowrap;
}

.employee-search-page .back-list-btn:hover {
    background: #f5f7fb;
    color: #172033;
    text-decoration: none;
}

/* 검색 결과 테이블 */
.employee-search-page .search-table-wrap {
    width: 100%;
    overflow-x: auto;
}

.employee-search-page .employee-table {
    width: 100%;
    min-width: 980px;
    border-collapse: separate;
    border-spacing: 0 4px;
    table-layout: fixed;
}

.employee-search-page .employee-table th,
.employee-search-page .employee-table td {
    padding: 0 12px;
    text-align: center;
    vertical-align: middle;
    font-size: 12px;
}

.employee-search-page .employee-table thead th {
    height: 59px;
    background: #f0f4f9;
    color: #728199;
    font-weight: 600;
    border: none;
}

.employee-search-page .employee-table thead th:first-child {
    border-radius: 10px 0 0 10px;
}

.employee-search-page .employee-table thead th:last-child {
    border-radius: 0 10px 10px 0;
}

.employee-search-page .employee-table tbody td {
    height: 70px;
    background: #fff;
    color: #172033;
    border-top: 1px solid #dce5f1;
    border-bottom: 1px solid #dce5f1;
}

.employee-search-page .employee-table tbody td:first-child {
    border-left: 1px solid #dce5f1;
    border-radius: 10px 0 0 10px;
}

.employee-search-page .employee-table tbody td:last-child {
    border-right: 1px solid #dce5f1;
    border-radius: 0 10px 10px 0;
}

.employee-search-page .employee-table tbody tr:hover td {
    background: #fafcff;
}

.employee-search-page .employee-table th:nth-child(1) { width: 8%; }
.employee-search-page .employee-table th:nth-child(2) { width: 12%; }
.employee-search-page .employee-table th:nth-child(3) { width: 13%; }
.employee-search-page .employee-table th:nth-child(4) { width: 11%; }
.employee-search-page .employee-table th:nth-child(5) { width: 23%; }
.employee-search-page .employee-table th:nth-child(6) { width: 14%; }
.employee-search-page .employee-table th:nth-child(7) { width: 10%; }
.employee-search-page .employee-table th:nth-child(8) { width: 9%; }

.employee-search-page .employee-table a {
    color: #2563eb;
    text-decoration: none;
}

.employee-search-page .employee-table a:hover {
    text-decoration: underline;
}

.employee-search-page .empty-message {
    text-align: center;
    color: #728199;
    padding: 25px 12px;
}

/* 반응형 */
@media (max-width: 1100px) {
    .employee-search-page .search-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media (max-width: 767px) {
    .employee-search-page {
        padding: 0 16px 30px;
    }

    .employee-search-page .search-panel {
        padding: 20px 16px;
    }

    .employee-search-page .search-grid {
        grid-template-columns: 1fr;
        gap: 16px;
    }

    .employee-search-page .search-bottom {
        flex-direction: column;
        align-items: stretch;
    }

    .employee-search-page .search-date-field {
        width: 100%;
    }

    .employee-search-page .search-actions {
        justify-content: flex-end;
    }
}
</style>
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 헤더 / 사이드바 : 기존 코드 유지 -->
    <%@ include file="/WEB-INF/views/common/header.jspf" %>
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <!-- 검색 화면 본문 -->
    <div class="content-wrapper employee-search-page">

        <section class="content-header">
            <div class="container-fluid">

                <h1 class="employee-page-title">사원 조회 · 검색</h1>

                <p class="employee-page-desc">
                    사번, 성명, 부서, 직급 및 재직 상태로 사원을 검색합니다.
                </p>

            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 검색 조건 -->
                <div class="search-panel">

                    <h2 class="search-section-title">검색 조건</h2>

                    <div class="search-grid">

                        <div class="search-field">
                            <label for="searchKeyword">사번 / 성명</label>
                            <input type="text"
                                   id="searchKeyword"
                                   class="search-input"
                                   placeholder="사번 또는 이름">
                        </div>

                        <div class="search-field">
                            <label for="searchDept">부서</label>
                            <select id="searchDept" class="search-input">
                                <option value="">전체 부서</option>
                            </select>
                        </div>

                        <div class="search-field">
                            <label for="searchJob">직급</label>
                            <select id="searchJob" class="search-input">
                                <option value="">전체 직급</option>
                            </select>
                        </div>

                        <div class="search-field">
                            <label for="searchStatus">재직 상태</label>
                            <select id="searchStatus" class="search-input">
                                <option value="">전체</option>
                                <option value="ACTIVE">재직</option>
                                <option value="LEAVE">휴직</option>
                                <option value="RETIRED">퇴직</option>
                            </select>
                        </div>

                    </div>

                    <div class="search-bottom">

                        <div class="search-field search-date-field">
                            <label for="startDate">입사일</label>

                            <div class="date-range">
                                <input type="date"
                                       id="startDate"
                                       class="search-input">

                                <span class="date-separator">~</span>

                                <input type="date"
                                       id="endDate"
                                       class="search-input"
                                       aria-label="입사일 종료일">
                            </div>
                        </div>

                        <div class="search-actions">

                            <button type="button"
                                    id="resetBtn"
                                    class="search-btn">
                                초기화
                            </button>

                            <button type="button"
                                    id="searchBtn"
                                    class="search-btn search-btn-primary">
                                검색
                            </button>

                        </div>

                    </div>

                </div>

                <!-- 검색 결과 -->
                <div class="search-results">

                    <div class="search-result-header">

                        <h2 class="search-result-title">
                            검색 결과
                            <span id="resultCount">0명</span>
                        </h2>

                        <a href="${pageContext.request.contextPath}/employees"
                           class="back-list-btn">
                            전체 사원 보기
                        </a>

                    </div>

                    <div class="search-table-wrap">

                        <table class="employee-table">

                            <thead>
                                <tr>
                                    <th>사번</th>
                                    <th>성명</th>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>이메일</th>
                                    <th>입사일</th>
                                    <th>재직 상태</th>
                                    <th>관리</th>
                                </tr>
                            </thead>

                            <tbody id="searchResultBody">
                                <tr>
                                    <td colspan="8" class="empty-message">
                                        검색 조건을 입력하고 검색 버튼을 눌러주세요.
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
const contextPath = "${pageContext.request.contextPath}";

/* 부서 목록 불러오기 */
async function loadDepartments() {
    try {
        const response = await fetch(contextPath + "/api/departments");

        if (!response.ok) {
            throw new Error("부서 목록 조회 실패");
        }

        const result = await response.json();
        const departments = Array.isArray(result) ? result : result.data;
        const select = document.getElementById("searchDept");

        select.innerHTML = '<option value="">전체 부서</option>';

        (departments || []).forEach(dept => {
            const option = document.createElement("option");
            option.value = dept.departmentId;
            option.textContent = dept.departmentName;
            select.appendChild(option);
        });

    } catch (error) {
        console.error("부서 목록 오류:", error);
    }
}

/* 사원 검색 */
async function searchEmployees() {
    try {
        const response = await fetch(contextPath + "/api/employees");

        if (!response.ok) {
            throw new Error("검색 실패");
        }

        const employees = await response.json();

        const keyword = $("#searchKeyword").val().trim().toLowerCase();
        const dept = $("#searchDept").val();
        const job = $("#searchJob").val();
        const status = $("#searchStatus").val();
        const startDate = $("#startDate").val();
        const endDate = $("#endDate").val();

        const result = employees.filter(emp => {

            const keywordMatch =
                String(emp.empId).includes(keyword) ||
                (emp.ename ?? "").toLowerCase().includes(keyword);

            const statusMatch =
                !status || emp.status === status;

            const hireDate = emp.hiredate
                ? new Date(emp.hiredate)
                : null;

            const startMatch =
                !startDate ||
                (hireDate &&
                 hireDate >= new Date(startDate + "T00:00:00"));

            const endMatch =
                !endDate ||
                (hireDate &&
                 hireDate <= new Date(endDate + "T23:59:59.999"));

            const deptMatch =
                !dept ||
                String(emp.department?.departmentId) === dept;

            const jobMatch =
                !job ||
                String(emp.job?.jobId) === job;

            return keywordMatch &&
                   deptMatch &&
                   jobMatch &&
                   statusMatch &&
                   startMatch &&
                   endMatch;
        });

        $("#resultCount").text(result.length + "명");
        printSearchResults(result);

    } catch (error) {
        console.error("사원 검색 오류:", error);
        alert("사원 검색 중 오류가 발생했습니다.");
    }
}

/* 검색 결과 출력 */
function printSearchResults(employees) {
    const tbody = $("#searchResultBody").empty();

    employees.forEach(emp => {
        const tr = $("<tr>");
        const url = contextPath + "/employees/" + emp.empId;

        $("<td>").text(emp.empId).appendTo(tr);
        $("<td>").text(emp.ename).appendTo(tr);
        $("<td>").text(emp.department?.departmentName ?? "-").appendTo(tr);
        $("<td>").text(emp.job?.jobName ?? "-").appendTo(tr);
        $("<td>").text(emp.email ?? "-").appendTo(tr);

        const hiredate = emp.hiredate
            ? new Date(emp.hiredate).toLocaleDateString("ko-KR")
            : "-";

        $("<td>").text(hiredate).appendTo(tr);

        const status = {
            ACTIVE: "재직",
            LEAVE: "휴직",
            RETIRED: "퇴직"
        }[emp.status] ?? "미확인";

        $("<td>").text(status).appendTo(tr);

        $("<td>").append(
            $("<a>").attr("href", url).text("상세"),
            " / ",
            $("<a>").attr("href", url + "/edit").text("수정")
        ).appendTo(tr);

        tbody.append(tr);
    });

    if (employees.length === 0) {
        $("<tr>").append(
            $("<td>")
                .attr("colspan", 8)
                .addClass("empty-message")
                .text("검색 결과가 없습니다.")
        ).appendTo(tbody);
    }
}

/* 검색 조건 초기화 */
function resetSearch() {
    $("#searchKeyword").val("");
    $("#searchDept").val("");
    $("#searchJob").val("");
    $("#searchStatus").val("");
    $("#startDate").val("");
    $("#endDate").val("");

    $("#resultCount").text("0명");

    $("#searchResultBody").html(
        '<tr><td colspan="8" class="empty-message">' +
        '검색 조건을 입력하고 검색 버튼을 눌러주세요.' +
        '</td></tr>'
    );
}

/* 이벤트 */
document.addEventListener("DOMContentLoaded", () => {
    loadDepartments();

    document.getElementById("searchBtn")
        .addEventListener("click", searchEmployees);

    document.getElementById("resetBtn")
        .addEventListener("click", resetSearch);

    document.getElementById("searchKeyword")
        .addEventListener("keydown", event => {
            if (event.key === "Enter") {
                searchEmployees();
            }
        });
});
</script>

</body>
</html>
