
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>부서 관리</title>



<!-- 부서 관리 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/department.css">
</head>

<body class="hold-transition sidebar-mini">

	<div class="wrapper">

		<!-- 공통 헤더 -->
		<%@ include file="../common/header.jspf"%>

		<!-- 공통 사이드바 -->
		<%@ include file="../common/sidebar.jspf"%>

		<!-- 메인 콘텐츠 -->
		<div class="content-wrapper employee-search-page">

			<section class="content-header">
				<div class="container-fluid">
					<h2 class="page-title">부서 관리</h2>
					<p class="page-path">HRMS / 부서 관리</p>
				</div>
			</section>

			<section class="content">
				<div class="container-fluid">

					<!-- 부서 통계 -->
					<section class="summary-row">

						<div class="summary-card">
							<p>전체 부서</p>
							<h3 id="totalCount">0</h3>
						</div>

						<div class="summary-card">
							<p>활성 부서</p>
							<h3 id="activeCount">0</h3>
						</div>

						<div class="summary-card">
							<p>비활성 부서</p>
							<h3 id="inactiveCount">0</h3>
						</div>

					</section>

					<!-- 검색 및 등록 -->
					<section class="table-top">

						<h3>목록 조회</h3>

						<div class="table-actions">

							<input type="text" id="keyword" placeholder="부서명 / 부서 코드 검색">

							<select id="searchStatus" aria-label="부서 상태 필터">
								<option value="">전체 상태</option>
								<option value="1">활성</option>
								<option value="0">비활성</option>
							</select>

							<button type="button" id="openRegisterBtn" class="primary-btn">
								+ 부서 등록</button>

						</div>

					</section>

					<!-- 부서 목록 -->
					<table class="department-table">

						<thead>
							<tr>
								<th>부서 코드</th>
								<th>부서명</th>
								<th>인원</th>
								<th>상태</th>
								<th>관리</th>
							</tr>
						</thead>

						<tbody id="departmentBody"></tbody>
						
					</table>

				</div>
			</section>

		</div>

	</div>


	<!-- 부서 관리 JavaScript -->
	<script>

const contextPath = '${pageContext.request.contextPath}';

let departmentList = [];


// 1. 부서 목록 조회
const getList = async () => {

    try {
        const response = await fetch(
            contextPath + "/api/departments", {
                method: "GET"
            }
        );

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "부서 목록 조회 실패");
        }

        departmentList = result.data;

        filterDepartments();
        updateSummary();

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
};


// 2. 부서 목록 출력
const renderList = (list) => {

    const tbody = document.getElementById("departmentBody");

    tbody.replaceChildren();

    if (list.length === 0) {
        const tr = document.createElement("tr");
        const td = document.createElement("td");
        td.colSpan = 5;
        td.textContent = "검색 결과가 없습니다.";
        td.style.textAlign = "center";
        tr.appendChild(td);
        tbody.appendChild(tr);
        return;
    }

    list.forEach(dept => {

        const tr = document.createElement("tr");

        // 부서 코드
        const code = document.createElement("td");
        code.textContent = dept.departmentCode;

        // 부서명
        const name = document.createElement("td");
        name.textContent = dept.departmentName;
        
        // 부서별 사원 수
        const employeeCount = document.createElement("td");
        employeeCount.textContent = (dept.employeeCount ?? 0) + "명";

        // 상태
        const active = Number(dept.isActive) === 1;

        const status = document.createElement("td");
        status.textContent = active ? "활성" : "비활성";

        // 관리 버튼
        const action = document.createElement("td");

        // 수정 버튼
        const editBtn = document.createElement("button");
        editBtn.type = "button";
        editBtn.textContent = "수정";

        editBtn.onclick = () => {

        	window.open(
        		    contextPath + "/jobs/new",
        		    "jobRegisterPopup",
        		    "width=700,height=700,scrollbars=yes"
        		);
        };

        // 비활성화 버튼
        const deleteBtn = document.createElement("button");
        deleteBtn.type = "button";
        deleteBtn.textContent = "비활성화";

        deleteBtn.onclick = () => {
            deactivate(dept.departmentId);
        };

        editBtn.disabled = !active;
        deleteBtn.disabled = !active;

        action.append(editBtn, deleteBtn);

        tr.append(code, name, employeeCount, status, action);

        tbody.appendChild(tr);
    });
};


// 3. 부서 비활성화
const deactivate = async (departmentId) => {

    if (!confirm("해당 부서를 비활성화하시겠습니까?")) {
        return;
    }

    try {
        const response = await fetch(
            contextPath + "/api/departments/" + departmentId, {
                method: "DELETE"
            }
        );

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "부서 비활성화 실패");
        }

        alert(result.message);

        location.reload();

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
};


// 4. 부서 통계
const updateSummary = () => {

    const activeCount = departmentList.filter(
        dept => Number(dept.isActive) === 1
    ).length;

    document.getElementById("totalCount").textContent =
        departmentList.length;

    document.getElementById("activeCount").textContent =
        activeCount;

    document.getElementById("inactiveCount").textContent =
        departmentList.length - activeCount;
};


// 5. 부서 검색 (별도 JS 파일 없이 현재 JSP에서 처리)
const filterDepartments = () => {
    const keyword = document.getElementById("keyword")
        .value.trim().toLowerCase();
    const status = document.getElementById("searchStatus").value;

    const filtered = departmentList.filter(dept => {
        const code = String(dept.departmentCode ?? "").toLowerCase();
        const name = String(dept.departmentName ?? "").toLowerCase();
        const matchesKeyword = code.includes(keyword) || name.includes(keyword);
        const matchesStatus = status === "" || Number(dept.isActive) === Number(status);
        return matchesKeyword && matchesStatus;
    });

    renderList(filtered);
};

document.getElementById("keyword")
    .addEventListener("input", filterDepartments);

document.getElementById("searchStatus")
    .addEventListener("change", filterDepartments);


//부서 등록 팝업
document.getElementById("openRegisterBtn").addEventListener("click", () => {

    const width = 550;
    const height = 400;

    const left = Math.round(window.screenX + (window.outerWidth - width) / 2);
    const top = Math.round(window.screenY + (window.outerHeight - height) / 2);

    window.open(
        contextPath + "/departments/new",
        "departmentRegisterPopup",
        "width=" + width +
        ",height=" + height +
        ",left=" + left +
        ",top=" + top +
        ",scrollbars=yes,resizable=yes"
    );
});


// 7. 목록 자동 조회
getList();

</script>


	<!-- AdminLTE 동작에 필요한 JS -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

</body>
</html>
