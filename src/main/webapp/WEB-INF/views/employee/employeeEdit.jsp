
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    // DB 연결 전 임시 데이터
    // 사번, 이름, 부서, 직급, 이메일, 연락처, 입사일, 상태
    String[][] employees = {
        {"E1001", "김민지", "백엔드팀", "대리",
         "minji@hrms.com", "010-1234-5678", "2022-03-14", "재직"},

        {"E1002", "이준호", "경영지원팀", "과장",
         "junho@hrms.com", "", "2020-07-01", "재직"},

        {"E1003", "박서연", "프론트엔드팀", "사원",
         "seoyeon@hrms.com", "", "2024-01-08", "휴직"},

        {"E1004", "최유진", "인사팀", "사원",
         "yujin@hrms.com", "", "2021-09-06", "퇴직"}
    };

    String empId = (String) request.getAttribute("empId");
    String[] emp = null;

    for (String[] employee : employees) {
        if (employee[0].equals(empId)) {
            emp = employee;
            break;
        }
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>HRMS - 사원 정보 수정</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <!-- 통합 CSS -->
    <link rel="stylesheet"
          href="<%=contextPath%>/css/employee.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <!-- 공통 헤더 -->
    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <!-- 공통 사이드바 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="content-wrapper employee-detail-page employee-edit-page">

        <main class="employee-detail-container">

            <!-- 페이지 제목 -->
            <div class="employee-detail-heading">

                <div>
                    <h1>사원 정보 수정</h1>
                    <p>사원 관리 / 사원 목록 / 사원 정보 수정</p>
                </div>

                <a href="<%=contextPath%>/employees"
                   class="employee-detail-button employee-detail-button-outline">
                    목록으로
                </a>

            </div>

            <% if (emp == null) { %>

                <section class="employee-detail-card employee-detail-not-found">
                    <h2>사원 정보를 찾을 수 없습니다.</h2>

                    <a href="<%=contextPath%>/employees"
                       class="employee-detail-button employee-detail-button-outline">
                        목록으로
                    </a>
                </section>

            <% } else { %>

                <!-- 프로필 요약 -->
                <section class="employee-detail-card employee-detail-summary">

                    <div class="employee-detail-person">
                        <div class="employee-detail-avatar">
                            <i class="fas fa-user"></i>
                        </div>

                        <div>
                            <h2><%=emp[1]%></h2>
                            <p><%=emp[0]%> · <%=emp[2]%> / <%=emp[3]%></p>
                        </div>
                    </div>

                    <span class="employee-detail-status
                        <%= "재직".equals(emp[7]) ? "is-active" :
                            "휴직".equals(emp[7]) ? "is-leave" : "is-retired" %>">
                        <%=emp[7]%>
                    </span>

                </section>

                <!-- 수정 폼 -->
                <form id="employeeEditForm" onsubmit="return testEdit(event)">

                    <section class="employee-detail-card employee-detail-info">

                        <h2>사원 기본 정보 수정</h2>
                        <p class="employee-detail-hint">
                            수정할 항목을 입력해 주세요.
                        </p>

                        <div class="employee-detail-grid">

                            <!-- 사번 -->
                            <div class="employee-detail-field">
                                <label for="empId">사번</label>
                                <input type="text"
                                       id="empId"
                                       name="empId"
                                       class="employee-edit-input"
                                       value="<%=emp[0]%>"
                                       readonly>
                            </div>

                            <!-- 성명 -->
                            <div class="employee-detail-field">
                                <label for="name">성명</label>
                                <input type="text"
                                       id="name"
                                       name="name"
                                       class="employee-edit-input"
                                       value="<%=emp[1]%>"
                                       maxlength="50"
                                       required>
                            </div>

                            <!-- 부서 -->
                            <div class="employee-detail-field">
                                <label for="department">소속 부서</label>
                                <select id="department"
                                        name="department"
                                        class="employee-edit-input"
                                        required>
                                    <option value="백엔드팀" <%= "백엔드팀".equals(emp[2]) ? "selected" : "" %>>백엔드팀</option>
                                    <option value="프론트엔드팀" <%= "프론트엔드팀".equals(emp[2]) ? "selected" : "" %>>프론트엔드팀</option>
                                    <option value="경영지원팀" <%= "경영지원팀".equals(emp[2]) ? "selected" : "" %>>경영지원팀</option>
                                    <option value="인사팀" <%= "인사팀".equals(emp[2]) ? "selected" : "" %>>인사팀</option>
                                </select>
                            </div>

                            <!-- 직급 -->
                            <div class="employee-detail-field">
                                <label for="position">직급</label>
                                <select id="position"
                                        name="position"
                                        class="employee-edit-input"
                                        required>
                                    <option value="사원" <%= "사원".equals(emp[3]) ? "selected" : "" %>>사원</option>
                                    <option value="대리" <%= "대리".equals(emp[3]) ? "selected" : "" %>>대리</option>
                                    <option value="과장" <%= "과장".equals(emp[3]) ? "selected" : "" %>>과장</option>
                                </select>
                            </div>

                            <!-- 이메일 -->
                            <div class="employee-detail-field">
                                <label for="email">이메일</label>
                                <input type="email"
                                       id="email"
                                       name="email"
                                       class="employee-edit-input"
                                       value="<%=emp[4]%>"
                                       maxlength="100"
                                       required>
                            </div>

                            <!-- 연락처 -->
                            <div class="employee-detail-field">
                                <label for="phone">연락처</label>
                                <input type="tel"
                                       id="phone"
                                       name="phone"
                                       class="employee-edit-input"
                                       value="<%=emp[5]%>"
                                       placeholder="010-1234-5678"
                                       maxlength="20"
                                       required>
                            </div>

                            <!-- 입사일 -->
                            <div class="employee-detail-field">
                                <label for="hireDate">입사일</label>
                                <input type="text"
                                       id="hireDate"
                                       class="employee-edit-input"
                                       value="<%=emp[6]%>"
                                       readonly>
                            </div>

                            <!-- 재직 상태 -->
                            <div class="employee-detail-field">
                                <label for="status">재직 상태</label>
                                <input type="text"
                                       id="status"
                                       class="employee-edit-input"
                                       value="<%=emp[7]%>"
                                       readonly>
                            </div>

                        </div>

                    </section>

                    <!-- 하단 버튼 -->
                    <section class="employee-detail-card employee-detail-actions">

                        <div class="employee-detail-actions-text">
                            <span>관리자 작업</span>
                            <p>수정 내용을 확인한 후 저장할 수 있습니다.</p>
                        </div>

                        <div class="employee-detail-action-buttons">

                            <a href="<%=contextPath%>/employees/<%=emp[0]%>"
                               class="employee-detail-button employee-detail-button-outline">
                                취소
                            </a>

                            <button type="submit"
                                    class="employee-detail-button employee-detail-button-primary">
                                수정 내용 확인
                            </button>

                        </div>

                    </section>

                </form>

            <% } %>

        </main>

    </div>

</div>

<!-- AdminLTE -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>
    function testEdit(event) {
        event.preventDefault();

        const form = document.getElementById("employeeEditForm");

        if (!form.reportValidity()) {
            return false;
        }

        alert("입력값 검증 완료!\nDB 미연결 상태이므로 아직 저장되지는 않습니다.");

        return false;
    }

    // 사원 관리 메뉴 활성화
    document.addEventListener("DOMContentLoaded", function() {
        const links = document.querySelectorAll(".main-sidebar .nav-link");

        links.forEach(function(link) {
            link.classList.remove("active");

            if (link.textContent.includes("03 사원 관리")) {
                link.classList.add("active");
            }
        });
    });
    
    //수정할 사원 정보 불러오기
    const loadEmployee = async () => {
    	
    	//URL 에서 사번 추출
    	const empId = location.pathname.split("/").slice(-2)[0];
    	
    	try{
    		const response = await fetch(
    			"${pageContext.request.contextPath}/api/employees/"+empId);
    	
    		if (!response.ok){
    			throw new Error("사원 조회 실패");
    		}
    		
    		const emp = await response.json();
    		
    		console.log("수정할 사원 정보:" , emp);
    		
    	}catch(error){
    		console.error("사원 조회 오류:",error);
    	}
    };
    
    //페이지가 열리면 실행
    $(function(){
    	loadEmployee();
    });
    
    
</script>

</body>
</html>
