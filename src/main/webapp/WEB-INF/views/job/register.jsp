<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>직급 등록</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- AdminLTE -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <!-- 직급 등록 전용 디자인 -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/job.css">
</head>
<body class="job-popup-body">

    <!-- 메인 화면 -->
    <div class="job-popup-card job-register-page">

        <main class="job-register-container">

            <!-- 상단 -->
            <div class="job-breadcrumb">
                HRMS / 직급 관리 / 직급 등록
            </div>

            <div class="job-page-heading">
                <div>
                    <h1>직급 등록</h1>
                    <p>새로운 직급을 등록합니다.</p>
                </div>
            </div>

            <!-- 안내 -->
            <div class="job-info-box">
                직급 코드는 등록 완료 후 자동으로 생성됩니다.
            </div>

            <!-- 직급 등록 -->
            <section class="job-register-card">

                <div class="job-card-heading">
                    <h2>직급 기본 정보</h2>
                    <p>직급 정보를 입력해 주세요.</p>
                </div>

                <form id="jobRegisterForm">

                    <div class="job-form-group">
                        <label for="jobName">
                            직급명 <span class="required">*</span>
                        </label>

                        <input type="text"
                               id="jobName"
                               name="jobName"
                               placeholder="예: 사원, 대리, 과장"
                               maxlength="20"
                               required>

                        <small>
                            직급명을 입력해 주세요.
                        </small>
                    </div>

                    <div class="job-form-group">
                        <label>직급 코드</label>

                        <input type="text"
                               value="등록 시 자동 생성"
                               readonly>

                        <small>
                            직급 코드는 서버에서 자동 생성됩니다.
                        </small>
                    </div>

                    <div class="job-form-actions">

                        <a href="${pageContext.request.contextPath}/jobs"
                           class="job-cancel-btn">
                            취소
                        </a>

                        <button type="submit"
                                id="registerBtn"
                                class="job-submit-btn">
                            직급 등록
                        </button>

                    </div>

                </form>

            </section>

        </main>

    </div>

<!-- AdminLTE JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>

const contextPath = "${pageContext.request.contextPath}";

// 직급 등록
const registJob = async (event) => {

    event.preventDefault();

    const jobName = document.getElementById("jobName").value.trim();
    const registerBtn = document.getElementById("registerBtn");

    if (!jobName) {
        alert("직급명을 입력하세요.");
        return;
    }

    registerBtn.disabled = true;

    try {

        const headers = {
            "Content-Type": "application/json",
            "Accept": "application/json"
        };

        // Spring Security CSRF 처리
        const csrfToken = "${_csrf.token}";
        const csrfHeader = "${_csrf.headerName}";

        if (csrfToken && csrfHeader) {
            headers[csrfHeader] = csrfToken;
        }

        const response = await fetch(contextPath + "/api/jobs", {
            method: "POST",
            headers: headers,
            body: JSON.stringify({
                jobName: jobName
            })
        });

        const contentType = response.headers.get("content-type") || "";

        if (!contentType.includes("application/json")) {
            throw new Error("서버 오류가 발생했습니다. HTTP " + response.status);
        }

        const result = await response.json();

        if (!response.ok || result.success === false) {
            throw new Error(result.message || "직급 등록에 실패했습니다.");
        }

        alert("직급이 등록되었습니다.");

        location.href = contextPath + "/jobs";

    } catch (error) {

        console.error("직급 등록 오류:", error);
        alert(error.message);

    } finally {
        registerBtn.disabled = false;
    }
};

// 폼 제출 이벤트
document.getElementById("jobRegisterForm")
    .addEventListener("submit", registJob);

</script>

</body>
</html>