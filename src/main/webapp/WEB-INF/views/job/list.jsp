
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>직급 관리</title>

<!-- AdminLTE 3 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- 기존 부서 목록과 같은 레이아웃을 임시 재사용 (디자인 정리 전) -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/job.css">
</head>

<body class="hold-transition sidebar-mini">

	<div class="wrapper">

		<!-- 공통 헤더 -->
		<%@ include file="../common/header.jspf"%>

		<!-- 공통 사이드바 -->
		<%@ include file="../common/sidebar.jspf"%>

		<!-- 메인 콘텐츠 -->
		<div class="content-wrapper">

			<section class="content-header">
				<div class="container-fluid">
					<h2 class="page-title">직급 관리</h2>
					<p class="page-path">HRMS / 직급 관리</p>
				</div>
			</section>

			<section class="content">
				<div class="container-fluid">

					<!-- 직급 통계 -->
					<section class="summary-row">

						<div class="summary-card">
							<p>전체 직급</p>
							<h3 id="totalCount">0</h3>
						</div>

						<div class="summary-card">
							<p>활성 직급</p>
							<h3 id="activeCount">0</h3>
						</div>

						<div class="summary-card">
							<p>비활성 직급</p>
							<h3 id="inactiveCount">0</h3>
						</div>

					</section>

					<!-- 검색 및 등록 -->
					<section class="table-top">

						<h3>목록 조회</h3>

						<div class="table-actions">

							<input type="text" id="keyword" placeholder="직급명 / 직급 코드 검색">

                            <select id="searchStatus" aria-label="직급 상태 필터">
                                <option value="">전체 상태</option>
                                <option value="1">활성</option>
                                <option value="0">비활성</option>
                            </select>

							<button type="button" id="openRegisterBtn" class="primary-btn">
								+ 직급 등록</button>

						</div>

					</section>

					<!-- 직급 목록 -->
					<table class="job-table">

						<thead>
							<tr>
								<th>직급 코드</th>
								<th>직급명</th>
								<th>인원</th>
								<th>상태</th>
								<th>관리</th>
							</tr>
						</thead>

						<tbody id="jobBody"></tbody>

					</table>

				</div>
			</section>

		</div>

	</div>


    <!-- 직급 관리 JavaScript -->
	<script>

const contextPath = '${pageContext.request.contextPath}';

let jobList = [];


// 1. 직급 목록 조회
const getList = async () => {

    try {
        const response = await fetch(
            contextPath + "/api/jobs", {
                method: "GET"
            }
        );

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "직급 목록 조회 실패");
        }

        if (!Array.isArray(result.data)) {
            throw new Error("직급 목록 데이터가 배열이 아닙니다. RestJobController의 getList() 응답을 확인하세요.");
        }
        jobList = result.data;

        filterJobs();
        updateSummary();

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
};


// 2. 직급 목록 출력
const renderList = (list) => {

    const tbody = document.getElementById("jobBody");

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

    list.forEach(job => {

        const tr = document.createElement("tr");

        // 직급 코드
        const code = document.createElement("td");
        code.textContent = job.jobCode;

        // 직급명
        const name = document.createElement("td");
        name.textContent = job.jobName;
        
        // 직급별 사원 수
        const employeeCount = document.createElement("td");
        employeeCount.textContent = job.employeeCount == null ? "-" : job.employeeCount + "명";

        // 상태
        const active = Number(job.isActive) === 1;

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
                contextPath + "/jobs/edit?jobId="
                    + job.jobId,
                "jobEditPopup",
                "width=600,height=450"
            );
        };

        // 비활성화 버튼
        const deleteBtn = document.createElement("button");
        deleteBtn.type = "button";
        deleteBtn.textContent = "비활성화";

        deleteBtn.onclick = () => {
            deactivate(job.jobId);
        };

        editBtn.disabled = !active;
        deleteBtn.disabled = !active;

        action.append(editBtn, deleteBtn);

        tr.append(code, name, employeeCount, status, action);

        tbody.appendChild(tr);
    });
};


// 3. 직급 비활성화
const deactivate = async (jobId) => {

    if (!confirm("해당 직급을 비활성화하시겠습니까?")) {
        return;
    }

    try {
        const response = await fetch(
            contextPath + "/api/jobs/" + jobId, {
                method: "DELETE"
            }
        );

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "직급 비활성화 실패");
        }

        alert(result.message);

        location.reload();

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
};


// 4. 직급 통계
const updateSummary = () => {

    const activeCount = jobList.filter(
        job => Number(job.isActive) === 1
    ).length;

    document.getElementById("totalCount").textContent =
        jobList.length;

    document.getElementById("activeCount").textContent =
        activeCount;

    document.getElementById("inactiveCount").textContent =
        jobList.length - activeCount;
};


// 5. 직급 검색 (별도 JS 파일 없이 현재 JSP에서 처리)
const filterJobs = () => {
    const keyword = document.getElementById("keyword")
        .value.trim().toLowerCase();
    const status = document.getElementById("searchStatus").value;

    const filtered = jobList.filter(job => {
        const code = String(job.jobCode ?? "").toLowerCase();
        const name = String(job.jobName ?? "").toLowerCase();
        const matchesKeyword = code.includes(keyword) || name.includes(keyword);
        const matchesStatus = status === "" || Number(job.isActive) === Number(status);
        return matchesKeyword && matchesStatus;
    });

    renderList(filtered);
};

document.getElementById("keyword")
    .addEventListener("input", filterJobs);

document.getElementById("searchStatus")
    .addEventListener("change", filterJobs);


// 6. 등록 팝업
document.getElementById("openRegisterBtn").addEventListener("click", () => {

    window.open(
        contextPath + "/jobs/new",
        "jobRegisterPopup",
        "width=650,height=450"
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
