<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>부서 등록</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/css/department.css">
</head>

<body class="popup-body">

<div class="popup-card">

    <h2>신규 부서 등록</h2>

    <p class="popup-description">
        부서 코드는 등록 시 자동 생성됩니다.
    </p>

    <form id="registerForm">

        <div class="form-group">
            <label for="departmentName">부서명</label>

            <input type="text"
                   id="departmentName"
                   name="departmentName"
                   placeholder="부서명을 입력하세요."
                   maxlength="50"
                   required>
        </div>

        <div class="button-group">

            <button type="button" id="cancelBtn">
                취소
            </button>

            <button type="submit" class="primary-btn">
                등록
            </button>

        </div>

    </form>

</div>

<script>

const contextPath = '${pageContext.request.contextPath}';


// 부서 등록

const regist = async () => {

    const departmentName =
        document.getElementById("departmentName").value.trim();

    if (!departmentName) {
        alert("부서명을 입력하세요.");
        return;
    }

    try {
        const headers = {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json"
        };

        // Spring Security CSRF
        const csrfToken = "${_csrf.token}";
        const csrfHeader = "${_csrf.headerName}";

        if (csrfToken && csrfHeader) {
            headers[csrfHeader] = csrfToken;
        }

        const response = await fetch(
            contextPath + "/api/departments", {
                method: "POST",
                headers: headers,
                body: JSON.stringify({ departmentName })
            }
        );

        const contentType =
            response.headers.get("content-type") || "";

        if (!contentType.includes("application/json")) {
            throw new Error(
                "JSON 응답이 아닙니다. HTTP " + response.status
            );
        }

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "부서 등록 실패");
        }

        alert(result.message);

        if (window.opener && !window.opener.closed) {
            window.opener.location.reload();
            window.close();
        } else {
            location.href = contextPath + "/departments";
        }

    } catch (error) {
        console.error("부서 등록 오류:", error);
        alert(error.message);
    }
};



// 등록 버튼 이벤트
document.getElementById("registerForm")
    .addEventListener("submit", function(e) {

        e.preventDefault();
        regist();

    });


// 취소 버튼 이벤트
document.getElementById("cancelBtn")
    .addEventListener("click", function() {

        if (window.opener && !window.opener.closed) {
            window.close();
        } else {
            location.href = contextPath + "/departments";
        }

    });

</script>

</body>
</html>