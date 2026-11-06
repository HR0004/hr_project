
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HRMS - 사원 정보 수정</title>

   

    <!-- 사원 관리 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employee.css">
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

                <a href="${pageContext.request.contextPath}/employees"
                   class="employee-detail-button employee-detail-button-outline">
                    목록으로
                </a>
            </div>

            <!-- 수정 폼 -->
            <section class="employee-detail-card">

                <h2>사원 기본 정보</h2>
                <p>수정할 정보를 입력해 주세요.</p>

                <form id="employeeEditForm" novalidate>

                    <div class="row">

                        <!-- 사번 -->
                        <div class="col-md-6 mb-3">
                            <label for="empId">사번</label>
                            <input type="text"
                                   id="empId"
                                   class="employee-edit-input"
                                   readonly>
                        </div>

                        <!-- 이름 -->
                        <div class="col-md-6 mb-3">
                            <label for="ename">성명 *</label>
                            <input type="text"
                                   id="ename"
                                   class="employee-edit-input"
                                   required>
                        </div>

                        <!-- 이메일 -->
                        <div class="col-md-6 mb-3">
                            <label for="email">이메일 *</label>
                            <input type="email"
                                   id="email"
                                   class="employee-edit-input"
                                   required>
                        </div>

                        <!-- 연락처 -->
                        <div class="col-md-6 mb-3">
                            <label for="phone">연락처</label>
                            <input type="tel"
                                   id="phone"
                                   class="employee-edit-input">
                        </div>

                        <!-- 입사일 -->
                        <div class="col-md-6 mb-3">
                            <label for="hiredate">입사일 *</label>
                            <input type="date"
                                   id="hiredate"
                                   class="employee-edit-input"
                                   required>
                        </div>

                        <!-- 재직 상태 -->
                        <div class="col-md-6 mb-3">
                            <label for="status">재직 상태 *</label>
                            <select id="status"
                                    class="employee-edit-input"
                                    required>
                                <option value="ACTIVE">재직</option>
                                <option value="LEAVE">휴직</option>
                                <option value="RETIRED">퇴직</option>
                            </select>
                        </div>

                        <!-- 부서 -->
                        <div class="col-md-6 mb-3">
                            <label for="departmentId">소속 부서 *</label>
                            <select id="departmentId"
                                    class="employee-edit-input"
                                    required>
                                <option value="">부서를 선택하세요</option>
                                <option value="1">경영지원팀</option>
                                <option value="2">개발팀</option>
                                <option value="3">영업팀</option>
                            </select>
                        </div>

                        <!-- 직급 -->
                        <div class="col-md-6 mb-3">
                            <label for="jobId">직급 *</label>
                            <select id="jobId"
                                    class="employee-edit-input"
                                    required>
                                <option value="">직급을 선택하세요</option>
                                <option value="1">사원</option>
                                <option value="2">대리</option>
                                <option value="3">과장</option>
                                <option value="4">차장</option>
                                <option value="5">부장</option>
                            </select>
                        </div>

                    </div>

                    <!-- 안내 메시지 -->
                    <p id="editMessage" role="alert"></p>

                    <!-- 버튼 -->
                    <div class="employee-detail-action-buttons">

                        <a id="cancelBtn"
                           href="${pageContext.request.contextPath}/employees"
                           class="employee-detail-button employee-detail-button-outline">
                            취소
                        </a>

                        <button type="submit"
                                id="updateBtn"
                                class="employee-detail-button">
                            수정 완료
                        </button>

                    </div>

                </form>

            </section>

        </main>
    </div>

</div>

<!-- 사원 정보 수정 팝업 -->
<div class="modal fade" id="editPopup" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body p-4">

                <h4 class="font-weight-bold mb-4">
                    <span id="editPopupIcon" class="mr-2"></span>
                    <span id="editPopupTitle"></span>
                </h4>

                <p id="editPopupMessage"></p>

                <div class="bg-light rounded p-3 mb-4"
                     id="editPopupDetail"></div>

                <div class="d-flex">

                    <button type="button"
                            id="editPopupCancel"
                            class="btn btn-outline-secondary flex-fill mr-2"
                            data-dismiss="modal">
                        취소
                    </button>

                    <button type="button"
                            id="editPopupAction"
                            class="btn btn-primary flex-fill">
                        확인
                    </button>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- AdminLTE -->
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>

    // 수정할 사번 가져오기
    const empId = location.pathname.split("/").slice(-2)[0];

    const contextPath = "${pageContext.request.contextPath}";

    // 날짜를 yyyy-MM-dd 형식으로 변환
    const formatDate = (value) => {
        if (!value) return "";

        if (typeof value === "string") {
            return value.substring(0, 10);
        }

        const date = new Date(value);

     // 입사일 설정
        if (emp.hiredate != null) {
            const date = new Date(emp.hiredate);

            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, "0");
            const day = String(date.getDate()).padStart(2, "0");

            $("#hiredate").val(`${year}-${month}-${day}`);
        }
    };

    // DB에 있는 부서/직급 ID가 선택 목록에 없을 경우 처리
    const selectValue = (selector, value) => {
        const select = $(selector);
        const id = String(value ?? "");

        if (id && select.find("option").filter(function() {
            return this.value === id;
        }).length === 0) {
            select.append(
                $("<option>").val(id).text("현재 등록된 ID: " + id)
            );
        }

        select.val(id);
    };

 // 수정할 사원 정보 불러오기
    const loadEmployee = async () => {

        const empId = location.pathname.split("/").slice(-2)[0];

        try {
            const response = await fetch(
                "${pageContext.request.contextPath}/api/employees/" + empId
            );

            if (!response.ok) {
                throw new Error("사원 조회 실패");
            }

            const emp = await response.json();

            // 사원 기본 정보
            $("#empId").val(emp.empId);
            $("#ename").val(emp.ename);
            $("#email").val(emp.email);
            $("#phone").val(emp.phone);
            $("#status").val(emp.status);

            // 입사일 변환
            if (emp.hiredate != null) {
                const date = new Date(emp.hiredate);

                const year = date.getFullYear();
                const month = String(date.getMonth() + 1).padStart(2, "0");
                const day = String(date.getDate()).padStart(2, "0");

                $("#hiredate").val(year + "-" + month + "-" + day);
            }

            // 부서 및 직급
            $("#departmentId").val(emp.departmentId);
            $("#jobId").val(emp.jobId);

            console.log("조회한 사원 정보:", emp);

        } catch (error) {
            console.error("사원 조회 오류:", error);
            $("#editMessage").text(error.message);
        }
    };

    // 사원 정보 수정
    const updateEmployee = async () => {

        const emp = {
            ename: $("#ename").val().trim(),
            email: $("#email").val().trim(),
            phone: $("#phone").val().trim(),
            hiredate: $("#hiredate").val(),
            departmentId: Number($("#departmentId").val()),
            jobId: Number($("#jobId").val()),
            status: $("#status").val()
        };

        try {
            $("#updateBtn").prop("disabled", true);

            const response = await fetch(
                contextPath + "/api/employees/" + empId,
                {
                    method: "PUT",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(emp)
                }
            );

            if (!response.ok) {
                throw new Error("사원 정보 수정에 실패했습니다.");
            }

            showEditPopup("success");

        } catch (error) {

            console.error("사원 수정 오류:", error);
            showEditPopup("error", error.message);

        } finally {

            $("#updateBtn").prop("disabled", false);

        }
    };

    // 페이지 로딩 시 기존 정보 조회
    $(function() {
        loadEmployee();
    });

    // 수정 완료 버튼
    $("#employeeEditForm").on("submit", function(event) {

        event.preventDefault();
		
        //필수값 검사
        if (!this.checkValidity()) {
            showEditPopup("error", "필수 항목을 올바르게 입력해 주세요.");
            return;
        }
        
        //수정 확인 방법
        showEditPopup("confirm");
    });
        
     // 사원 정보 수정 팝업
        const showEditPopup = (type, message = "") => {

            const popups = {
                confirm: {
                    icon: "❔",
                    title: "사원 정보 수정 확인",
                    message: "변경한 사원 정보를 저장하시겠습니까?",
                    detail: "성명: " + $("#ename").val(),
                    button: "수정하기"
                },

                success: {
                    icon: "✅",
                    title: "사원 정보 수정 완료",
                    message: "사원 정보가 정상적으로 수정되었습니다.",
                    detail: "성명: " + $("#ename").val(),
                    button: "상세 화면 보기"
                },

                error: {
                    icon: "❗",
                    title: "사원 정보 수정 오류",
                    message: message || "입력 정보를 확인해 주세요.",
                    detail: "내용을 확인하고 다시 시도해 주세요.",
                    button: "확인"
                }
            };
            
            const popup = popups[type];
            
            $("#editPopupIcon").text(popup.icon);
            $("#editPopupTitle").text(popup.title);
            $("#editPopupMessage").text(popup.message);
            $("#editPopupDetail").text(popup.detail);
            $("#editPopupAction").text(popup.button);
            
            $("#editPopupCancel").toggle(type === "confirm");
            
            $("#editPopupAction").off("click").on("click", ()=>{
            	
            	if(type === "confirm"){
            		
            		//팝업이 완전히 닫힌 후 API 호출
            		$("#editPopup").one("hidden.bs.modal",() =>{
            			updateEmployee();
            		});
            		
            		$("#editPopup").modal("hide");
            		return
            	}
            	
            	if(type === "success"){
            		location.href = contextPath + "/employees/" + empId;
            		return
            	}
            	
            	$("#editPopup").modal("hide");
            });
            
            $("#editPopup").modal("show");
            };


</script>

</body>
</html>
