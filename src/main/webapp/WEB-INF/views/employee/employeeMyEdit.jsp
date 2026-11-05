
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HRMS - 내 정보 수정</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employeehome.css">
</head>

<body class="myedit-page">

<div class="myedit-layout">

    <!-- 사원 전용 사이드바 -->
    <aside class="myedit-sidebar">
        <div class="myedit-logo">▦ HRMS Employee</div>
        <div class="myedit-sidebar-title">인사관리 시스템</div>

        <nav class="myedit-menu">
            <a href="${pageContext.request.contextPath}/employee/home"
               class="myedit-menu-item active">01 내 정보</a>
            <span class="myedit-menu-item">02 근태 관리</span>
            <span class="myedit-menu-item">03 휴가 관리</span>
            <span class="myedit-menu-item">04 급여 조회</span>
        </nav>
    </aside>

    <!-- 메인 영역 -->
    <div class="myedit-main">

        <header class="myedit-header">
            <div class="myedit-header-user" id="loginUser">
                로그인 사용자
            </div>
        </header>

        <main class="myedit-content">

            <div class="myedit-heading">
                <h1>내 정보 수정</h1>
                <p>본인의 연락처와 이메일을 직접 수정할 수 있습니다.</p>
            </div>

            <!-- 안내 메시지 -->
            <div class="myedit-notice">
                <strong>ⓘ 회색 입력란은 수정할 수 없는 인사 정보입니다.</strong>
                <p>
                    성명·부서·직급·입사일 등 변경이 필요한 경우
                    인사 담당자에게 문의하세요.
                </p>
            </div>

            <form id="myInfoEditForm" novalidate>

                <!-- 기본 정보 카드 -->
                <section class="myedit-card">

                    <div class="myedit-card-heading">
                        <h2>기본 정보</h2>
                        <span class="myedit-status" id="statusBadge">
                            조회 전
                        </span>
                    </div>

                    <!-- 읽기 전용 정보 -->
                    <div class="myedit-grid">

                        <div class="myedit-field">
                            <label for="empId">사번 (변경 불가)</label>
                            <input type="text" id="empId"
                                   placeholder="사번" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>

                        <div class="myedit-field">
                            <label for="ename">성명 (변경 불가)</label>
                            <input type="text" id="ename"
                                   placeholder="성명" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>

                        <div class="myedit-field">
                            <label for="departmentName">부서 (변경 불가)</label>
                            <input type="text" id="departmentName"
                                   placeholder="부서" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>

                        <div class="myedit-field">
                            <label for="jobName">직급 (변경 불가)</label>
                            <input type="text" id="jobName"
                                   placeholder="직급" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>

                        <div class="myedit-field">
                            <label for="hiredate">입사일 (변경 불가)</label>
                            <input type="text" id="hiredate"
                                   placeholder="입사일" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>

                        <div class="myedit-field">
                            <label for="status">재직 상태 (변경 불가)</label>
                            <input type="text" id="status"
                                   placeholder="재직 상태" readonly>
                            <span class="myedit-lock">🔒</span>
                        </div>
                    </div>

                    <hr class="myedit-divider">

                    <!-- 수정 가능한 정보 -->
                    <h2 class="myedit-section-title">수정 가능한 정보</h2>

                    <div class="myedit-grid">
                        <div class="myedit-field">
                            <label for="email">이메일 *</label>
                            <input type="email" id="email"
                                   name="email"
                                   placeholder="example@hrms.com"
                                   maxlength="40"
                                   autocomplete="email"
                                   required>
                        </div>

                        <div class="myedit-field">
                            <label for="phone">연락처</label>
                            <input type="tel" id="phone"
                                   name="phone"
                                   placeholder="010-0000-0000"
                                   maxlength="13"
                                   autocomplete="tel">
                        </div>
                    </div>

                    <p id="myEditMessage"
                       class="myedit-message"
                       role="status"></p>
                </section>

                <!-- 저장 영역 -->
                <section class="myedit-actions">

                    <div class="myedit-actions-text">
                        <strong>저장 전 확인</strong>
                        <p>
                            이메일 형식과 연락처 입력값을 확인 후 저장하세요.
                            변경된 정보는 본인 계정에 반영됩니다.
                        </p>
                    </div>

                    <div class="myedit-buttons">

                        <button type="button"
                                id="cancelMyEditBtn"
                                class="myedit-btn myedit-btn-outline">
                            취소
                        </button>

                        <button type="button"
                                id="passwordChangeBtn"
                                class="myedit-btn myedit-btn-outline">
                            비밀번호 변경
                        </button>

                        <button type="submit"
                                id="saveMyInfoBtn"
                                class="myedit-btn myedit-btn-primary">
                            변경사항 저장
                        </button>
                    </div>
                </section>
            </form>
        </main>
    </div>
</div>


<!-- 비밀번호 변경 팝업 -->
<div id="passwordModal" class="password-modal">

    <div class="password-modal-content">

        <div class="password-modal-header">
            <h3>비밀번호 변경</h3>
            <button type="button" id="closePasswordModal">×</button>
        </div>

        <p class="password-modal-description">
            계정 보안을 위해 현재 비밀번호를 확인해 주세요.
        </p>

        <form id="passwordChangeForm">

            <label for="currentPassword">현재 비밀번호</label>
            <input type="password"
                   id="currentPassword"
                   autocomplete="current-password"
                   required>

            <label for="newPassword">새 비밀번호</label>
            <input type="password"
                   id="newPassword"
                   autocomplete="new-password"
                   required>

            <label for="confirmPassword">새 비밀번호 확인</label>
            <input type="password"
                   id="confirmPassword"
                   autocomplete="new-password"
                   required>

            <p id="passwordMessage" class="password-message"></p>

            <div class="password-modal-buttons">
                <button type="button"
                        id="cancelPasswordModal"
                        class="myedit-btn myedit-btn-outline">
                    취소
                </button>

                <button type="submit"
                        class="myedit-btn myedit-btn-primary">
                    비밀번호 변경
                </button>
            </div>
        </form>
    </div>
</div>


<!-- 내 정보 수정 공통 팝업 -->
<div id="myInfoModal" class="info-modal">

    <div class="info-modal-content">

        <div class="info-modal-title">
            <span id="infoModalIcon" class="info-modal-icon">?</span>
            <h3 id="infoModalTitle"></h3>
        </div>

        <p id="infoModalMessage"></p>

        <div class="info-modal-description"
             id="infoModalDescription"></div>

        <div class="info-modal-buttons">
            <button type="button"
                    id="infoModalCancel"
                    class="info-modal-secondary">
                취소
            </button>

            <button type="button"
                    id="infoModalConfirm"
                    class="info-modal-primary">
                확인
            </button>
        </div>

    </div>
</div>


<script>

// ========================================
// 1. 로그인한 사원 정보 불러오기
// ========================================

const loadMyEditInfo = async () => {

    try {
        const response = await fetch(
            "${pageContext.request.contextPath}/api/employees/me"
        );

        if (!response.ok) {
            throw new Error("사원 정보 조회 실패: " + response.status);
        }

        const emp = await response.json();

        document.getElementById("loginUser").textContent =
            emp.ename + " 사원";

        const status = {
            ACTIVE: "재직",
            LEAVE: "휴직",
            RETIRED: "퇴직"
        }[emp.status] ?? "-";

        // 수정 불가능한 정보
        document.getElementById("empId").value = emp.empId ?? "";
        document.getElementById("ename").value = emp.ename ?? "";

        document.getElementById("departmentName").value =
            emp.department?.departmentName ?? "";

        document.getElementById("jobName").value =
            emp.job?.jobName ?? "";

        document.getElementById("hiredate").value = emp.hiredate
            ? new Date(emp.hiredate).toLocaleDateString("ko-KR")
            : "";

        document.getElementById("status").value = status;
        document.getElementById("statusBadge").textContent =
            status === "재직" ? "재직 중" : status;

        // 수정 가능한 정보
        document.getElementById("email").value = emp.email ?? "";
        document.getElementById("phone").value = emp.phone ?? "";

    } catch (error) {
        console.error("내 정보 조회 오류:", error);

        document.getElementById("myEditMessage").textContent =
            "사원 정보를 불러오지 못했습니다.";
    }
};

document.addEventListener("DOMContentLoaded", loadMyEditInfo);


// ========================================
// 2. 공통 팝업
// ========================================

const showInfoModal = ({
    type = "confirm",
    title,
    message,
    description,
    cancelText = "취소",
    confirmText = "확인",
    onCancel,
    onConfirm
}) => {

    const modal = document.getElementById("myInfoModal");
    const icon = document.getElementById("infoModalIcon");
    const cancelBtn = document.getElementById("infoModalCancel");
    const confirmBtn = document.getElementById("infoModalConfirm");

    const icons = {
        confirm: "?",
        success: "✓",
        warning: "!",
        error: "!"
    };

    icon.textContent = icons[type];
    icon.className = "info-modal-icon " + type;

    document.getElementById("infoModalTitle").textContent = title;
    document.getElementById("infoModalMessage").textContent = message;
    document.getElementById("infoModalDescription").textContent = description;

    cancelBtn.textContent = cancelText;
    confirmBtn.textContent = confirmText;

    // 오류 팝업은 확인 버튼만 표시
    cancelBtn.style.display = type === "error" ? "none" : "";

    modal.classList.add("show");

    const closeModal = () => {
        modal.classList.remove("show");
    };

    cancelBtn.onclick = () => {
        closeModal();

        if (onCancel) {
            onCancel();
        }
    };

    confirmBtn.onclick = () => {
        closeModal();

        if (onConfirm) {
            onConfirm();
        }
    };
};


// ========================================
// 3. 내 정보 수정 - 저장 확인
// ========================================

const myInfoForm = document.getElementById("myInfoEditForm");

myInfoForm.noValidate = true;

myInfoForm.addEventListener("submit", (event) => {
    event.preventDefault();

    const email = document.getElementById("email").value.trim();
    const phone = document.getElementById("phone").value.trim();

    // 이메일 검사
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email) || email.length > 40) {

        showInfoModal({
            type: "error",
            title: "입력 정보 확인",
            message: "이메일 형식이 올바르지 않습니다.",
            description: "이메일 주소를 다시 확인해 주세요."
        });
        return;
    }

    // 연락처 검사
    if (phone && !/^010-\d{4}-\d{4}$/.test(phone)) {

        showInfoModal({
            type: "error",
            title: "입력 정보 확인",
            message: "연락처 형식이 올바르지 않습니다.",
            description: "010-0000-0000 형식으로 입력해 주세요."
        });
        return;
    }

    // 저장 확인 팝업
    showInfoModal({
        type: "confirm",
        title: "내 정보 변경 확인",
        message: "수정한 이메일과 연락처를 저장하시겠습니까?",
        description: "본인 계정의 연락처 정보만 변경됩니다.",
        cancelText: "취소",
        confirmText: "변경사항 저장",
        onConfirm: () => saveMyInfo(email, phone)
    });
});


// ========================================
// 4. 실제 DB 저장
// ========================================

const saveMyInfo = async (email, phone) => {

    const saveBtn = document.getElementById("saveMyInfoBtn");
    saveBtn.disabled = true;

    try {
        const response = await fetch(
            "${pageContext.request.contextPath}/api/employees/me",
            {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    email: email,
                    phone: phone
                })
            }
        );

        if (!response.ok) {
            const errorResponse = await response.json();

            throw new Error(
                errorResponse.message || "요청 처리에 실패했습니다."
            );
        }

        // 저장 완료 팝업
        showInfoModal({
            type: "success",
            title: "내 정보 수정 완료",
            message: "개인정보가 정상적으로 변경되었습니다.",
            description: "변경된 정보는 내 정보 화면에 반영됩니다.",
            cancelText: "닫기",
            confirmText: "내 정보 보기",
            onCancel: () => location.reload(),
            onConfirm: () => {
                location.href =
                    "${pageContext.request.contextPath}/employee/home";
            }
        });

    } catch (error) {
        console.error("정보 수정 오류:", error);

        showInfoModal({
            type: "error",
            title: "정보 수정 실패",
            message: "정보 수정 실패",
            description: error.message
        });

    } finally {
        saveBtn.disabled = false;
    }
};


// ========================================
// 5. 변경사항 취소 팝업
// ========================================

document.getElementById("cancelMyEditBtn")
    .addEventListener("click", () => {

        showInfoModal({
            type: "warning",
            title: "변경사항 취소",
            message: "저장하지 않은 변경사항이 있습니다.",
            description: "이 화면에서 나가면 변경 내용이 사라집니다.",
            cancelText: "계속 수정",
            confirmText: "변경 취소",
            onConfirm: () => {
                location.href =
                    "${pageContext.request.contextPath}/employee/home";
            }
        });
    });


// ========================================
// 6. 비밀번호 변경 팝업
// ========================================

const passwordModal = document.getElementById("passwordModal");
const passwordForm = document.getElementById("passwordChangeForm");
const passwordMessage = document.getElementById("passwordMessage");

// 팝업 닫기
const closePasswordPopup = () => {
    passwordModal.classList.remove("show");
    passwordForm.reset();
    passwordMessage.textContent = "";
};

// 팝업 열기
document.getElementById("passwordChangeBtn")
    .addEventListener("click", () => {
        passwordModal.classList.add("show");
    });

// X 버튼
document.getElementById("closePasswordModal")
    .addEventListener("click", closePasswordPopup);

// 취소 버튼
document.getElementById("cancelPasswordModal")
    .addEventListener("click", closePasswordPopup);


// ========================================
// 7. 비밀번호 변경 API
// ========================================

passwordForm.addEventListener("submit", async (event) => {
    event.preventDefault();

    const current =
        document.getElementById("currentPassword").value;

    const newPassword =
        document.getElementById("newPassword").value;

    const confirm =
        document.getElementById("confirmPassword").value;

    passwordMessage.style.color = "#bc3545";
    passwordMessage.textContent = "";

    // 입력값 검사
    if (!current || !newPassword || !confirm) {
        passwordMessage.textContent =
            "모든 항목을 입력해 주세요.";
        return;
    }

    if (newPassword.length < 8) {
        passwordMessage.textContent =
            "새 비밀번호는 8자 이상 입력해 주세요.";
        return;
    }

    if (newPassword !== confirm) {
        passwordMessage.textContent =
            "새 비밀번호가 일치하지 않습니다.";
        return;
    }

    if (current === newPassword) {
        passwordMessage.textContent =
            "현재 비밀번호와 다른 비밀번호를 입력해 주세요.";
        return;
    }

    const submitBtn =
        passwordForm.querySelector('button[type="submit"]');

    submitBtn.disabled = true;

    try {
        const response = await fetch(
            "${pageContext.request.contextPath}/api/accounts/me/password",
            {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    currentPassword: current,
                    newPassword: newPassword
                })
            }
        );

        if (!response.ok) {
            const errorResponse = await response.json();

            throw new Error(
                errorResponse.message || "요청 처리에 실패했습니다."
            );
        }

        closePasswordPopup();

        // 비밀번호 변경 완료 팝업
        showInfoModal({
            type: "success",
            title: "비밀번호 변경 완료",
            message: "비밀번호가 정상적으로 변경되었습니다.",
            description: "다음 로그인부터 새 비밀번호를 사용해 주세요.",
            cancelText: "닫기",
            confirmText: "확인"
        });

    } catch (error) {
        console.error("비밀번호 변경 오류:", error);
        passwordMessage.textContent = error.message;

    } finally {
        submitBtn.disabled = false;
    }
});

</script>
</body>
</html>
