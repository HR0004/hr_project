<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>HRMS - 사원 상세 정보 조회</title>

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- AdminLTE -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<!-- 사원 관리 통합 CSS -->
<link rel="stylesheet" href="<%=contextPath%>/css/employee.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">

		<!-- 공통 헤더 -->
		<%@ include file="/WEB-INF/component/common/header.jspf"%>

		<!-- 공통 사이드바 -->
		<%@ include file="/WEB-INF/component/common/sidebar.jspf"%>

		<!-- 사원 상세 조회 -->
		<div class="content-wrapper employee-detail-page">

			<main class="employee-detail-container">

				<!-- 상단 제목 -->
				<div class="employee-detail-heading">

					<div>
						<h1>사원 상세 정보 조회</h1>
						<p>사원 관리 / 사원 목록 / 사원 상세 정보</p>
					</div>

					<a href="<%=contextPath%>/employees"
						class="employee-detail-button employee-detail-button-outline">

						<i class="fas fa-arrow-left"></i> 목록으로
					</a>

				</div>


				<!-- 사원 요약 정보 -->
				<section class="employee-detail-card employee-detail-summary">
					<div class="employee-detail-person">
						<div class="employee-detail-avatar">
							<i class="fas fa-user"></i>
						</div>
						<div>
							<h2 id="summaryName"></h2>
							<p>
								<span id="summaryEmpId"></span> · <span id="summaryDept"></span>
								/ <span id="summaryJob"></span>
							</p>
						</div>
					</div>

					<!-- 재직 상태 -->
					<span class="employee-detail-status" id="detailStatusBadge">
						<span class="employee-detail-status-dot"></span> <span
						id="summaryStatus"></span>
					</span>
				</section>


				<!-- 사원 기본 정보 -->
				<section class="employee-detail-card employee-detail-info">

					<h2>사원 기본 정보</h2>

					<p class="employee-detail-hint">tb_employee 기준 · 비밀번호는 보안상 표시하지
						않습니다.</p>

					<div class="employee-detail-grid">

						<!-- 사번 -->
						<div class="employee-detail-field">
							<label>사번</label>

							<div class="employee-detail-value">
								<span id="detailEmpId"></span>
							</div>
						</div>

						<!-- 성명 -->
						<div class="employee-detail-field">
							<label>성명</label>

							<div class="employee-detail-value" id="detailName"></div>
							<span id="detailName"></span>

						</div>

						<!-- 부서 -->
						<div class="employee-detail-field">
							<label>소속 부서</label>

							<div class="employee-detail-value">
								<span id="detailDept"></span>
							</div>
						</div>

						<!-- 직급 -->
						<div class="employee-detail-field">
							<label>직급</label>

							<div class="employee-detail-value">
								<span id="detailJob"></span>
							</div>
						</div>

						<!-- 이메일 -->
						<div class="employee-detail-field">
							<label>이메일</label>

							<div class="employee-detail-value">
								<span id="detailEmail"></span>
							</div>
						</div>

						<!-- 연락처 -->
						<div class="employee-detail-field">
							<label>연락처</label>

							<div class="employee-detail-value">
								<span id="detailPhone"></span>
							</div>
						</div>

						<!-- 입사일 -->
						<div class="employee-detail-field">
							<label>입사일</label>

							<div class="employee-detail-value">
								<span id="detailHiredate"></span>
							</div>
						</div>

						<!-- 재직 상태 -->
						<div class="employee-detail-field">
							<label>재직 상태</label>

							<div class="employee-detail-value">
								<span id="detailStatus"></span>
							</div>
						</div>

					</div>

				</section>

				<!-- 관리자 작업 -->
				<section class="employee-detail-card employee-detail-actions">

					<div class="employee-detail-actions-text">

						<span>관리자 작업</span>

						<p>사원 정보를 확인한 후 수정하거나 퇴직 처리를 진행할 수 있습니다.</p>

					</div>

					<div class="employee-detail-action-buttons">

						<!-- 목록으로 -->
						<a href="<%=contextPath%>/employees"
							class="employee-detail-button employee-detail-button-outline">

							목록으로 </a>

						<!-- 정보 수정 -->
						<button type="button"
							class="employee-detail-button employee-detail-button-primary"
							onclick="editEmployee()">정보 수정</button>

						<!-- 퇴직 처리 -->
						<button type="button"
							class="employee-detail-button employee-detail-button-danger"
							onclick="retireEmployee()">퇴직 처리</button>

					</div>

				</section>

			</main>

		</div>

	</div>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<!-- Bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- AdminLTE -->
	<script
		src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

	<script>
		// 사원 정보 수정
		function editEmployee() {
		    const empId = window.location.pathname.split("/").pop();

		    location.href = "${pageContext.request.contextPath}/employees/"
		        + empId + "/edit";
		}

		// 사원 퇴직 처리
function retireEmployee() {
    const empId = window.location.pathname.split("/").pop();

    alert("퇴직 처리 기능은 아직 구현 전입니다. 사번: " + empId);
			}		
			
		}
		

		// 사이드바의 사원 관리 메뉴 활성화
		document.addEventListener("DOMContentLoaded", function() {

			const links = document.querySelectorAll(".main-sidebar .nav-link");

			links.forEach(function(link) {

				link.classList.remove("active");

				if (link.textContent.includes("03 사원 관리")) {
					link.classList.add("active");
				}

			});

		});
	</script>

	<script>

	/* 사원 상세조회 */
	const getEmpDetail = async () => {
	    try {
	        const empId = window.location.pathname.split("/").pop();

	        const response = await fetch(
	            "${pageContext.request.contextPath}/api/employees/" + empId,
	            { method: "GET" }
	        );

	        if (!response.ok) {
	            throw new Error("사원 상세조회 실패");
	        }

	        const result = await response.json();

	        // 사원 요약 정보
	        $("#summaryName").text(result.ename);
	        $("#summaryEmpId").text(result.empId);
	        $("#summaryDept").text(result.departmentId);
	        $("#summaryJob").text(result.jobId);

	        // 사원 기본 정보
	        $("#detailEmpId").text(result.empId);
	        $("#detailName").text(result.ename);
	        $("#detailDept").text(result.departmentId);
	        $("#detailJob").text(result.jobId);
	        $("#detailEmail").text(result.email ?? "-");
	        $("#detailPhone").text(result.phone ?? "-");

	        const hiredate = result.hiredate
	            ? new Date(result.hiredate).toLocaleDateString("ko-KR")
	            : "-";

	        $("#detailHiredate").text(hiredate);

	        // 재직 상태
	        const status = {
	            ACTIVE: "재직",
	            LEAVE: "휴직",
	            RETIRED: "퇴직"
	        }[result.status] ?? "미확인";

	        $("#detailStatus").text(status);
	        $("#summaryStatus").text(status);

	        $("#detailStatusBadge")
	            .removeClass("is-active is-leave is-retired")
	            .addClass({
	                ACTIVE: "is-active",
	                LEAVE: "is-leave",
	                RETIRED: "is-retired"
	            }[result.status] ?? "");

	        console.log("사원 상세정보:", result);

	    } catch (error) {
	        console.error("사원 상세조회 오류:", error);
	        $(".employee-detail-summary, .employee-detail-info, .employee-detail-actions").hide();
	        $(".employee-detail-heading").after(
	            $("<section>")
	                .addClass("employee-detail-card employee-detail-not-found")
	                .text("사원 정보를 불러올 수 없습니다. 사번을 확인해 주세요.")
	        );
	    }
	};

	getEmpDetail();

	</script>


</body>
</html>
