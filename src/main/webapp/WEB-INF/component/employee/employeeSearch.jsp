<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>HRMS - 사원 조회 · 검색</title>

<!-- Font Awesome -->
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- AdminLTE -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<!-- 기존 사원 관리 CSS -->
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/employee.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 헤더 -->
    <%@ include file="/WEB-INF/component/common/header.jspf" %>

    <!-- 공통 사이드바 -->
    <%@ include file="/WEB-INF/component/common/sidebar.jspf" %>

    <div class="content-wrapper employee-page">

        <!-- 페이지 제목 -->
        <section class="content-header">
            <div class="container-fluid">

                <h1 class="employee-page-title">
                    사원 조회 · 검색
                </h1>

                <p class="employee-page-desc">
                    사번, 성명, 부서, 직급 및 재직 상태로 사원을 검색합니다.
                </p>

            </div>
        </section>

        <!-- 검색 화면 -->
        <section class="content">
            <div class="container-fluid">


<!-- 검색 조건 -->
<div class="card">
    <div class="card-body">

        <h5 class="mb-4">검색 조건</h5>

        <div class="row">

            <!-- 사번 / 성명 -->
            <div class="col-md-3 form-group">
                <label>사번 / 성명</label>
                <input type="text" id="searchKeyword"
                       class="form-control"
                       placeholder="사번 또는 이름">
            </div>

            <!-- 부서 -->
            <div class="col-md-3 form-group">
                <label>부서</label>
                <select id="searchDept" class="form-control">
                    <option value="">전체 부서</option>
                </select>
            </div>

            <!-- 직급 -->
            <div class="col-md-3 form-group">
                <label>직급</label>
                <select id="searchJob" class="form-control">
                    <option value="">전체 직급</option>
                </select>
            </div>

            <!-- 재직 상태 -->
            <div class="col-md-3 form-group">
                <label>재직 상태</label>
                <select id="searchStatus" class="form-control">
                    <option value="">전체</option>
                    <option value="ACTIVE">재직</option>
                    <option value="LEAVE">휴직</option>
                    <option value="RETIRED">퇴직</option>
                </select>
            </div>

        </div>

        <div class="row align-items-end">

            <!-- 입사일 -->
            <div class="col-md-6 form-group">
                <label>입사일</label>
                <div class="d-flex align-items-center">
                    <input type="date" id="startDate"
                           class="form-control">
                    <span class="mx-2">~</span>
                    <input type="date" id="endDate"
                           class="form-control">
                </div>
            </div>

            <!-- 버튼 -->
            <div class="col-md-6 form-group text-right">
                <button type="button" id="resetBtn"
                        class="btn btn-outline-secondary">
                    초기화
                </button>

                <button type="button" id="searchBtn"
                        class="btn btn-primary ml-2">
                    <i class="fas fa-search"></i> 검색
                </button>
            </div>

        </div>

    </div>
</div>


               
<!-- 검색 결과 -->
<div class="card">
    <div class="card-body">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                검색 결과
                <span id="resultCount" class="text-primary ml-2">0명</span>
            </h5>

            <a href="${pageContext.request.contextPath}/employees"
               class="btn btn-outline-secondary">
                전체 사원 보기
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover employee-table">
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
                        <td colspan="8" class="text-center text-muted py-4">
                            검색 조건을 입력하고 검색 버튼을 눌러주세요.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

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
		//사원 검색
		async function searchEmployees(){
			try{
				const response = await fetch(
					"${pageContext.request.contextPath}/api/employees");
				
				if(!response.ok){
					throw new Error("검색 실패");
				}
				
				const employees = await response.json();
				
				//입력한 검색어
				const keyword = $("#searchKeyword").val().trim().toLowerCase();
				const status = $("#searchStatus").val();
				const startDate = $("#startDate").val();
				const endDate = $("#endDate").val();
				
				const result = employees.filter(emp=>{
					
				//사번 또는 이름 검색
				const keywordMatch = String(emp.empId).includes(keyword) ||
										emp.ename.toLowerCase().includes(keyword);
				
				//재직 상태 일치 검색
				const statusMatch = status ==="" || emp.status === status;
				
				return keywordMatch && statusMatch;
				
				//입사일 검색
				const hireDate = emp.hiredate
					? new Date(emp.hiredate) : null;
					
				const dateMatch = (!startDate && !endDate) ||
					(hireDate && 
						(!startDate || hireDate >= new Date(startDate + "T00:00:00")) &&
						(!endDate || hireDate <= new Date(endDate + "T23:59:59.999"))
					);
				
				//모든 검색 조건 만족 여부
				return keywordMatch && statusMatch && dateMatch;
				
				});
				
				//검색 결과 출력
				
				console.log("검색 결과:", result);
				
				$("#resultCount").text(result.length + "명");
				
				printSearchResults(result);
				
			}catch(error){
				console.error("사원 검색 오류:",error);
			}
		}
		
		//검색 버튼 클릭
		$("#searchBtn").click(searchEmployees);
		
		//검색 결과 화면 출력
		function printSearchResults(employees){
			
			const tbody = $("#searchResultBody").empty();
			
			employees.forEach(emp=>{
				
				const tr = $("<tr>");
				const url = "${pageContext.request.contextPath}/employees/"+ emp.empId;
				
				$("<td>").text(emp.empId).appendTo(tr);
				$("<td>").text(emp.ename).appendTo(tr);
				$("<td>").text(emp.departmentId).appendTo(tr);
				$("<td>").text(emp.jobId).appendTo(tr);
				$("<td>").text(emp.email ?? "-").appendTo(tr);
			
				const hiredate = emp.hiredate
					? new Date(emp.hiredate).toLocaleDateString("ko-KR")
							: "-";
					
				$("<td>").text(hiredate).appendTo(tr);
				
				const status = {
					ACTIVE : "재직",
					LEAVE : "휴직",
					RETIRED : "퇴직",
				}[emp.status]?? "미확인";
				
				$("<td>").text(status).appendTo(tr);
				
				$("<td>").append(
					$("<a>").attr("href",url).text("상세"),"/",$("<a>").attr("href",url + "/edit").text("수정")).appendTo(tr);
				
					tbody.append(tr);
				});
			
			//검색 결과가 없을 때
			if(employees.length ===0){
				$("<tr>").append(
					$("<td>").attr("colspan",8).addClass("text-center py-4").text("검색 결과가 없습니다.")).appendTo(tbody);
			}
			
		}
		
		//검색 조건 초기화
		$("#resetBtn").click(function(){
			
			//검색 조건 비우기
			$("#searchKeyword").val("");
			$("#searchDept").val("");
			$("#searchJob").val("");
			$("#searchDate").val("");
			$("#startDate").val("");
			$("#endDate").val("");
			
			//검색 결과 초기화
			$("#resultCount").text("0명");
			
			$("#searchResultBody").html(
				'<tr><td colspan="8" class="text-center py-4">' +
				'검색 조건을 입력하고 검색 버튼을 눌러주세요.' +
				'</td></tr>');
		});
	</script>

</body>
</html>
