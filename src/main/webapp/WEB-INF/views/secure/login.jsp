<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>로그인</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css?v=20261106-2">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

    <div class="container login-container"
         style="max-width: 400px; margin-top: 50px;">

        <h2>로그인</h2>

        <div id="error-message"
             class="login-error"
             role="alert"
             aria-live="polite"></div>

        <form id="form1"
              action="${pageContext.request.contextPath}/login"
              method="post">

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">

            <div class="form-group">
                <input type="text"
                       class="form-control"
                       placeholder="Enter Your Id"
                       name="accountId"
                       aria-label="아이디"
                       autocomplete="username"
                       required>
            </div>

            <div class="form-group">
                <input type="password"
                       class="form-control"
                       id="pwd"
                       placeholder="Enter password"
                       name="pwd"
                       aria-label="비밀번호"
                       autocomplete="current-password"
                       required>
            </div>

            <button type="submit"
                    class="btn btn-primary btn-block"
                    id="bt-login">
                Submit
            </button>

        </form>
    </div>

    <script>
    (function () {
        const form = document.getElementById("form1");
        const button = document.getElementById("bt-login");
        const errorMessage = document.getElementById("error-message");

        let submitting = false;

        form.addEventListener("submit", async function (event) {
            event.preventDefault();

            if (submitting) {
                return;
            }

            errorMessage.textContent = "";
            submitting = true;
            button.disabled = true;

            let navigating = false;

            try {
                const formData = new URLSearchParams(
                    new FormData(form)
                );

                const response = await fetch(form.action, {
                    method: "POST",
                    credentials: "same-origin",
                    headers: {
                        "Content-Type":
                            "application/x-www-form-urlencoded; charset=UTF-8",
                        "Accept": "application/json"
                    },
                    body: formData
                });

                if (response.status === 403) {
                    errorMessage.textContent =
                        "로그인 요청이 거부되었습니다. 페이지를 새로고침한 뒤 다시 시도해 주세요.";
                    return;
                }

                const contentType =
                    response.headers.get("content-type") || "";

                if (!contentType.includes("application/json")) {
                    errorMessage.textContent =
                        "서버 응답을 확인할 수 없습니다. 로그인 처리 설정을 확인해 주세요.";
                    return;
                }

                const json = await response.json();

                if (response.ok && json.success) {
                    const allowedTargets = [
                        "${pageContext.request.contextPath}/dashboard",
                        "${pageContext.request.contextPath}/employee/home"
                    ];

                    // 서버에서 지정한 두 경로만 허용
                    if (!allowedTargets.includes(json.redirectUrl)) {
                        errorMessage.textContent =
                            "로그인 후 이동할 화면을 확인할 수 없습니다.";
                        return;
                    }

                    window.location.assign(json.redirectUrl);
                    navigating = true;

                } else {
                    errorMessage.textContent =
                        json.message ||
                        "아이디 또는 비밀번호가 일치하지 않습니다.";
                }

            } catch (error) {
                errorMessage.textContent =
                    "서버와의 통신 중 오류가 발생했습니다.";

            } finally {
                if (!navigating) {
                    submitting = false;
                    button.disabled = false;
                }
            }
        });
    }());
    </script>

</body>
</html>