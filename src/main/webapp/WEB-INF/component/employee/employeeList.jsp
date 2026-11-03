<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 화면 테스트용 임시 데이터
    // 나중에 Controller → Service → Mapper 연결 후 교체

    int totalCount = 128;
    int activeCount = 116;
    int leaveCount = 8;
    int retiredCount = 4;

    String[][] employeeList = {
        {"E1001", "김민지", "백엔드팀", "대리",
         "minji@hrms.com", "2022-03-14", "재직"},

        {"E1002", "이준호", "경영지원팀", "과장",
         "junho@hrms.com", "2020-07-01", "재직"},

        {"E1003", "박서연", "프론트엔드팀", "사원",
         "seoyeon@hrms.com", "2024-01-08", "휴직"},

        {"E1004", "최유진", "인사팀", "사원",
         "yujin@hrms.com", "2021-09-06", "퇴직"}
    };
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>HRMS - 사원 관리</title>

<!-- Font Awesome -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- AdminLTE 3 -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<link rel="stylesheet"
      href="<%=request.getContextPath()%>/css/employee.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 헤더 -->
<%@ include file="/WEB-INF/component/common/header.jspf" %>   
 <!-- 공통 사이드바 -->
<%@ include file="/WEB-INF/component/common/sidebar.jspf" %>   
<!-- 사원 관리 대시보드 -->
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
                        <div class="employee-stat-number" id="totalCount">0
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">재직</div>
                        <div class="employee-stat-number" id="activeCount">0
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">휴직</div>
                        <div class="employee-stat-number" id="leaveCount">0
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">퇴직</div>
                        <div class="employee-stat-number" id="retiredCount">0
                        </div>
                    </div>

                </div>

                <!-- 사원 목록 상단 -->
                <div class="employee-toolbar">

                    <h2 class="employee-list-title">
                        사원 목록 조회
                    </h2>

                    <div class="employee-toolbar-actions">

                       
                            <a href="${pageContext.request.contextPath}/employees/search" class="employee-btn"> 
                            	<i class="fas fa-search"></i>
                            	검색/필터
                            </a>

                        <button type="button"
                            class="employee-register-btn"
                            onclick="registerEmployee()">
                            + 사원 등록
                        </button>

                    </div>

                </div>

                <!-- 검색 조건 -->
                <div class="employee-filter" id="employeeFilter">

                    <div class="filter-item">

                        <label for="searchKeyword">검색 조건</label>

                        <input type="text"
                            id="searchKeyword"
	                            placeholder="사번 / 이름 / 이메일"
                            oninput="filterEmployees()">

                    </div>

                    <div class="filter-item">

                        <label for="searchDept">부서</label>

                        <select id="searchDept"
                            onchange="filterEmployees()">

                            <option value="">전체 부서</option>
                            <option value="백엔드팀">백엔드팀</option>
                            <option value="경영지원팀">경영지원팀</option>
                            <option value="프론트엔드팀">프론트엔드팀</option>
                            <option value="인사팀">인사팀</option>

                        </select>

                    </div>

                    <div class="filter-item">

                        <label for="searchPosition">직급</label>

                        <select id="searchPosition"
                            onchange="filterEmployees()">

                            <option value="">전체 직급</option>
                            <option value="사원">사원</option>
                            <option value="대리">대리</option>
                            <option value="과장">과장</option>

                        </select>

                    </div>

                    <div class="filter-item">

                        <label for="searchStatus">재직 상태</label>

                        <select id="searchStatus"
                            onchange="filterEmployees()">

                            <option value="">전체</option>
                            <option value="재직">재직</option>
                            <option value="휴직">휴직</option>
                            <option value="퇴직">퇴직</option>

                        </select>

                    </div>

                </div>

                <!-- 사원 목록 -->
                <div class="employee-table-wrap">

                    <table id="employeeTable"
                        class="employee-table">

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
                        검색 결과가 없습니다.
                    </div>

                </div>

                <p class="employee-notice">
                    ※ 사원 선택 후 상세 조회, 정보 수정 또는
                    퇴직 처리를 진행합니다.
                </p>

            </div>
        </section>

    </div>

</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap 4 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- AdminLTE -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>
// 검색 및 필터
function filterEmployees() {

    const keyword = document.getElementById("searchKeyword")
        .value.trim().toLowerCase();

    const dept = document.getElementById("searchDept").value;
    const position = document.getElementById("searchPosition").value;
    const status = document.getElementById("searchStatus").value;

    const rows = document.querySelectorAll(
        "#employeeTable tbody tr"
    );

    let visibleCount = 0;

    rows.forEach(function(row) {

        const cells = row.querySelectorAll("td");

        const empId = cells[0].textContent.trim().toLowerCase();
        const name = cells[1].textContent.trim().toLowerCase();
        const department = cells[2].textContent.trim();
        const jobPosition = cells[3].textContent.trim();
        const email = cells[4].textContent.trim().toLowerCase();
        const empStatus = cells[6].textContent.trim();

        const matchKeyword =
            empId.includes(keyword) ||
            name.includes(keyword) ||
            email.includes(keyword);

        const matchDept = !dept || department === dept;
        const matchPosition = !position || jobPosition === position;
        const matchStatus = !status || empStatus === status;

        const matched =
            matchKeyword &&
            matchDept &&
            matchPosition &&
            matchStatus;

        row.style.display = matched ? "" : "none";

        if (matched) {
            visibleCount++;
        }
    });

    document.getElementById("employeeEmpty").style.display =
        visibleCount === 0 ? "block" : "none";
}

// 검색 조건 접기 / 펼치기
function toggleEmployeeFilter() {

    const filter = document.getElementById("employeeFilter");

    filter.hidden = !filter.hidden;
}

// 신규 사원 등록
function registerEmployee() {
    locationi.href="<%=request.getContextPath()%>/employees/new";
}

// 사원 상세 조회 / 수정
function viewEmployee(empId) {
    location.href = "<%=request.getContextPath()%>/employees/"+ encodeURIComponent(empId);
}


//사원 등록 페이지로 가기
function registerEmployee(){
	location.href="<%=request.getContextPath()%>/employees/new";
}

// 공통 사이드바에서 사원 관리 메뉴 활성화
document.addEventListener("DOMContentLoaded", function() {

    const links = document.querySelectorAll(
        ".main-sidebar .nav-link"
    );

    links.forEach(function(link) {
        link.classList.remove("active");

        if (link.textContent.includes("03 사원 관리")) {
            link.classList.add("active");
        }
    });
});
</script>

<script>
    /* ---------------------------
       사원 전체 조회
    --------------------------- */
    async function loadEmployees() {
        try {
            const response = await fetch(
                "${pageContext.request.contextPath}/api/employees"
            );

            if (!response.ok) throw new Error("조회 실패");

            const employees = await response.json();

            printEmployees(employees);
            printStatus(employees);

        } catch (error) {
            console.error("사원 조회 오류:", error);
        }
    }

    /* ---------------------------
       사원 목록 화면 출력
    --------------------------- */
    function printEmployees(employees) {

        const tbody = $("#employeeTableBody").empty();

        employees.forEach(emp => {

            const url = "${pageContext.request.contextPath}/employees/" + emp.empId;

            const status = {
                ACTIVE: ["재직", "status-active"],
                LEAVE: ["휴직", "status-leave"],
                RETIRED: ["퇴직", "status-retired"]
            }[emp.status] || ["미확인", ""];

            const tr = $("<tr>");

            // 사번
            $("<td>").text(emp.empId).appendTo(tr);

            // 이름
            $("<td>").append(
                $("<a>").addClass("employee-name")
                    .attr("href", url).text(emp.ename)
            ).appendTo(tr);

            // 부서, 직급, 이메일, 입사일
            [
                emp.departmentId,
                emp.jobId,
                emp.email,
                emp.hiredate
                    ? new Date(emp.hiredate).toLocaleDateString("ko-KR")
                    : "-"
            ].forEach(value => {
                $("<td>").text(value ?? "-").appendTo(tr);
            });

            // 상태
            $("<td>").append(
                $("<span>")
                    .addClass("employee-status " + status[1])
                    .text(status[0])
            ).appendTo(tr);

            // 관리 버튼
            $("<td>").append(
                $("<a>").addClass("employee-action-link")
                    .attr("href", url).text("상세"),
                " / ",
                $("<a>").addClass("employee-action-link")
                    .attr("href", url + "/edit").text("수정")
            ).appendTo(tr);

            tbody.append(tr);
        });
    }

    loadEmployees();
    
    /* ---------------------------
    사원 목록 화면 출력
 --------------------------- */
 
 	function printStatus(employees){
    	
    	$("#totalCount").text(employees.length);
 
    	$("#activeCount").text(employees.filter(emp=>emp.status ==="ACTIVE").length);
    	
    	$("#leaveCount").text(employees.filter(emp=>emp.status ==="LEAVE").length);
    	
    	$("#retiredCount").text(employees.filter(emp=>emp.status ==="RETIRED").length);
    	
    }
</script>



</body>
</html>
