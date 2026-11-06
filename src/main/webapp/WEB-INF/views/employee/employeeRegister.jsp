
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>HRMS - 신규 사원 등록</title>



<!-- 사원관리 통합 CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/employee.css">

</head>

<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

    <!-- 기존 공통 헤더 -->
    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <!-- 기존 공통 사이드바 -->
    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="content-wrapper employee-register-page">
        <main class="employee-register-container">

            <!-- 페이지 제목 -->
            <div class="employee-register-heading">
                <div>
                    <h1>신규 사원 등록</h1>
                    <p>사원 관리 / 신규 사원 등록</p>
                </div>

                <a href="${pageContext.request.contextPath}/employees"
                   class="employee-register-btn btn-outline">
                    <i class="fas fa-arrow-left"></i> 목록으로
                </a>
            </div>

            <!-- 사원 등록 폼 -->
            <section class="employee-register-card">

                <h2>사원 기본 정보</h2>
                <p class="employee-register-hint">
                    * 표시 항목은 필수 입력입니다.
                </p>

               <form id="employeeRegisterForm" novalidate>

                    <div class="employee-register-grid">

                        <!-- 사번 -->
                        <div class="register-field field-id">
                            <label>사번 *</label>
                            <input type="text"
                                   value="자동 생성"
                                   readonly>
                        </div>

                        <!-- 성명 -->
                        <div class="register-field field-name">
                            <label for="ename">성명 *</label>
                            <input type="text"
                                   id="ename"
                                   maxlength="30"
                                   placeholder="성명 입력"
                                   required>
                        </div>

                        <!-- 재직 상태 -->
                        <div class="register-field field-status">
                            <label for="status">재직 상태 *</label>
                            <select id="status" required>
                                <option value="ACTIVE">재직</option>
                                <option value="LEAVE">휴직</option>
                                <option value="RETIRED">퇴직</option>
                            </select>
                        </div>

                        <!-- 이메일 -->
                        <div class="register-field field-email">
                            <label for="email">이메일 *</label>
                            <input type="email"
                                   id="email"
                                   maxlength="40"
                                   placeholder="example@hrms.com"
                                   required>
                        </div>

                        <!-- 연락처 -->
                        <div class="register-field field-phone">
                            <label for="phone">연락처</label>
                            <input type="tel"
                                   id="phone"
                                   maxlength="13"
                                   placeholder="010-0000-0000">
                        </div>

                        <!-- 등록 전 확인 사항 -->
                        <div class="register-notice field-notice">
                            <h3>등록 전 확인 사항</h3>
                            <p>✓ 필수 입력값 확인</p>
                            <p>✓ 부서 및 직급 선택</p>
                            <p>✓ 사번 자동 생성</p>
                            <p>✓ 사원 기본 정보 저장</p>
                        </div>
							
						<!-- 로그인 ID -->	
						<div class="register-field field-login-id">
							<label for="loginId">로그인 ID *</label>
							<input type="text" id="loginId" placeholder="로그인 ID 입력" maxlength="30" required>
						</div>

                        <!-- 초기 비밀번호 -->
                        <div class="register-field field-password">
                            <label for="password">초기 비밀번호 *</label>
                            <input type="password"
                                   id="password"
                                   placeholder="초기 비밀번호 입력"
                                   minlength="8"
                                   required>
                        </div>

                        <!-- 입사일 -->
                        <div class="register-field field-hiredate">
                            <label for="hiredate">입사일 *</label>
                            <input type="date"
                                   id="hiredate"
                                   required>
                        </div>

                        <!-- 소속 부서 -->
                        <div class="register-field field-department">
                            <label for="departmentId">소속 부서 *</label>
                            <select id="departmentId" required>
                                <option value="">부서를 선택하세요</option>
                                <option value="1">경영지원팀</option>
                                <option value="2">개발팀</option>
                                <option value="3">영업팀</option>
                            </select>
                        </div>

                        <!-- 직급 -->
                        <div class="register-field field-job">
                            <label for="jobId">직급 *</label>
                            <select id="jobId" required>
                                <option value="">직급을 선택하세요</option>
                                <option value="1">사원</option>
                                <option value="2">대리</option>
                                <option value="3">과장</option>
                                <option value="4">차장</option>
                                <option value="5">부장</option>
                            </select>
                        </div>

                    </div>

                 

                

                    <!-- 버튼 -->
                    <div class="register-actions">

                        <a href="${pageContext.request.contextPath}/employees"
                           class="employee-register-btn btn-outline">
                            취소
                        </a>

                        <button type="submit"
                                id="registerBtn"
                                class="employee-register-btn btn-primary-custom">
                            사원 등록
                        </button>

                    </div>

                </form>
            </section>
        </main>
    </div>
</div>

<!-- 사원 등록 안내 팝업 -->
<div class="modal fade" id="registerPopup" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-body p-4">

                <h4 class="font-weight-bold mb-4">
                    <span id="popupIcon" class="mr-2"></span>
                    <span id="popupTitle"></span>
                </h4>

                <p id="popupMessage" class="mb-3"></p>

                <div id="popupDetail"
                     class="bg-light rounded p-3 mb-4"></div>

                <div class="d-flex">
                    <button type="button"
                            id="popupCancel"
                            class="btn btn-outline-secondary flex-fill mr-2"
                            data-dismiss="modal">
                        취소
                    </button>

                    <button type="button"
                            id="popupAction"
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

/* 사원 신규 등록 */
const registerEmployee = async () => {

    const emp = {
        ename: $("#ename").val().trim(),
        email: $("#email").val().trim(),
        phone: $("#phone").val().trim(),
        hiredate: $("#hiredate").val(),
        departmentId: Number($("#departmentId").val()),
        jobId: Number($("#jobId").val()),
        status: $("#status").val()
    };
    
    const account = {
    		emp:emp, loginId:$("#loginId").val().trim(),
    		password : $("#password").val()
    };

    try {
        $("#registerBtn").prop("disabled", true);

        const response = await fetch(
            "${pageContext.request.contextPath}/api/employees/register",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(account)
            }
        );

        if (!response.ok) {

            const message = await response.text();

            console.error("사원 등록 HTTP 상태:", response.status);
            console.error("서버 응답:", message);

            throw new Error(
                "사원 등록 실패 (HTTP " + response.status + ")"
            );
        }

        showRegisterPopup("success", {
            ename: emp.ename
        });
        
    } catch (error) {

        console.error("사원 등록 오류:", error);

        if (error.message.includes("이미 사용중인 로그인 ID")) {
            showRegisterPopup("duplicate");
        } else {
            $("#registerMessage").text(error.message);
            alert("사원 등록 중 오류가 발생했습니다.");
        }

    
       

    } finally {
        $("#registerBtn").prop("disabled", false);
    }
};
/* 등록 버튼 */
$("#employeeRegisterForm").on("submit", function(event) {

    event.preventDefault();

    // 필수 입력값 검사
    if (!this.checkValidity()) {
        showRegisterPopup("required");
        return;
    }

    // 입력한 사원 정보
    const ename = $("#ename").val().trim();
    const loginId = $("#loginId").val().trim();

    if (!ename || !loginId) {
        showRegisterPopup("required");
        return;
    }

    // 등록 확인 팝업
    showRegisterPopup("confirm", {
        ename: ename,
        loginId: loginId,
        onConfirm: registerEmployee
    });
});

/* 사이드바 사원 관리 메뉴 활성화 */
$(function() {

    $(".main-sidebar .nav-link").each(function() {

        $(this).toggleClass(
            "active",
            $(this).text().includes("03 사원 관리")
        );

    });

});


//사원 등록 팝업
const showRegisterPopup = (type, data = {}) => {

    const popups = {

        confirm: {
            icon: "❔",
            title: "신규 사원 등록 확인",
            message: "입력한 사원 정보를 등록하시겠습니까?",
            detail: "성명 " + (data.ename ?? "-") + " · 로그인 ID " + (data.loginId ?? "-"),
            button: "등록하기"
        },

        duplicate: {
            icon: "❗",
            title: "로그인 ID 중복 안내",
            message: "이미 사용 중인 로그인 ID입니다.",
            detail: "다른 로그인 ID를 입력해 주세요.",
            button: "닫기"
        },

        required: {
            icon: "❗",
            title: "필수 입력 항목 확인",
            message: "입력하지 않은 필수 항목이 있습니다.",
            detail: "필수 입력 항목을 확인해 주세요.",
            button: "확인"
        },

        success: {
            icon: "✅",
            title: "사원 등록 완료",
            message: "신규 사원이 정상적으로 등록되었습니다.",
            detail: "성명 " + (data.ename ?? "-"),
            button: "사원 목록 보기"
        }
    };

    const popup = popups[type];

    if (!popup) return;

    $("#popupIcon").text(popup.icon);
    $("#popupTitle").text(popup.title);
    $("#popupMessage").text(popup.message);
    $("#popupDetail").text(popup.detail);
    $("#popupAction").text(popup.button);

    // 확인 팝업과 완료 팝업만 보조 버튼 표시
    $("#popupCancel").toggle(
        type === "confirm" || type === "success"
    );

    $("#popupAction").off("click").on("click", () => {

        // 등록 확인 팝업
        if (type === "confirm") {

            // 팝업이 완전히 닫힌 다음 등록 실행
            $("#registerPopup").one("hidden.bs.modal", () => {
                if (data.onConfirm) {
                    data.onConfirm();
                }
            });

            $("#registerPopup").modal("hide");
            return;
        }

        // 등록 완료 팝업
        if (type === "success") {
            location.href =
                "${pageContext.request.contextPath}/employees";
            return;
        }

        // 중복 오류, 필수값 오류 팝업
        $("#registerPopup").modal("hide");

    });
    $("#registerPopup").modal("show");
};
</script>


</body>
</html>
