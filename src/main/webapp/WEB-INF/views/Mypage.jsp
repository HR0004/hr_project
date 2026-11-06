<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.jsp.PageContext" %>
<%@ page import="javax.servlet.jsp.JspFactory" %>

<%!
    private String mypageText(PageContext context, String expression) {
        Object value = JspFactory.getDefaultFactory()
            .getJspApplicationContext(context.getServletContext())
            .getExpressionFactory()
            .createValueExpression(
                context.getELContext(),
                expression,
                Object.class
            )
            .getValue(context.getELContext());

        if (value == null) {
            return "";
        }

        return value.toString()
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>HRMS - 마이페이지</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">

    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/hrms-mypage.css?v=password-1">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="main-content main-area hrms-page">

        <div class="top-nav-bar">
            <div class="page-title-area">
                <h2>마이페이지</h2>
                <p class="mypage-location">홈 &gt; 마이페이지</p>
            </div>

            <%@ include file="/WEB-INF/views/common/header.jspf" %>
        </div>

        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">👤</div>

                <div>
                    <h3 class="mypage-name">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.emp.ename != null ? sessionScope.loginUser.emp.ename : '사용자'}"
                        ) %>님
                    </h3>

                    <span class="label label-primary">
                        <%= request.isUserInRole("HR_ADMIN")
                            ? "인사 관리자"
                            : "일반 사원" %>
                    </span>
                </div>
            </div>

            <h4 class="mypage-info-title">내 정보</h4>

            <div class="row">
                <div class="col-md-6 info-group">
                    <div class="info-label">아이디</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.loginId}"
                        ) %>
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">이름</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.emp.ename}"
                        ) %>
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">이메일</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.emp.email != null ? sessionScope.loginUser.emp.email : 'admin@hrms.com'}"
                        ) %>
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">연락처</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.emp.phone != null ? sessionScope.loginUser.emp.phone : '010-1234-5678'}"
                        ) %>
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">입사일</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.emp.hiredate != null ? sessionScope.loginUser.emp.hiredate : '2024-01-01'}"
                        ) %>
                    </div>
                </div>

                <div class="col-md-6 info-group">
                    <div class="info-label">최종 로그인</div>
                    <div class="info-value">
                        <%= mypageText(
                            pageContext,
                            "${sessionScope.loginUser.lastLoginAt != null ? sessionScope.loginUser.lastLoginAt : '방금 전'}"
                        ) %>
                    </div>
                </div>
            </div>
        </div>

        <section class="profile-card password-card"
                 aria-labelledby="password-title">

            <h3 id="password-title" class="password-title">
                비밀번호 변경
            </h3>

            <p class="password-note">
                현재 비밀번호를 확인한 후 새 비밀번호로 변경합니다.
            </p>

            <div id="password-message"
                 class="password-message"
                 role="status"
                 aria-live="polite"
                 hidden></div>

            <form id="password-form"
                  class="password-form"
                  action="${pageContext.request.contextPath}/api/accounts/me/password"
                  method="post">

                <div class="form-group">
                    <label for="current-password">현재 비밀번호</label>
                    <input type="password"
                           class="form-control"
                           id="current-password"
                           name="currentPassword"
                           autocomplete="current-password"
                           required>
                </div>

                <div class="form-group">
                    <label for="new-password">새 비밀번호</label>
                    <input type="password"
                           class="form-control"
                           id="new-password"
                           name="newPassword"
                           autocomplete="new-password"
                           minlength="8"
                           aria-describedby="password-help"
                           required>

                    <p id="password-help" class="password-help">
                        8자 이상으로 입력해 주세요.
                    </p>
                </div>

                <div class="form-group">
                    <label for="confirm-password">새 비밀번호 확인</label>
                    <input type="password"
                           class="form-control"
                           id="confirm-password"
                           name="newPasswordConfirm"
                           autocomplete="new-password"
                           minlength="8"
                           required>
                </div>

                <button type="submit"
                        id="password-submit"
                        class="password-submit">
                    비밀번호 변경
                </button>
            </form>
        </section>
    </div>

    <script>
    (function () {
        const form = document.getElementById("password-form");
        const button = document.getElementById("password-submit");
        const messageBox = document.getElementById("password-message");

        let submitting = false;

        function showMessage(message, success) {
            messageBox.textContent = message;
            messageBox.className =
                "password-message " +
                (success ? "password-success" : "password-error");

            messageBox.setAttribute(
                "role",
                success ? "status" : "alert"
            );

            messageBox.hidden = false;
        }

        form.addEventListener("submit", async function (event) {
            event.preventDefault();

            if (submitting) {
                return;
            }

            messageBox.hidden = true;

            const currentPassword =
                document.getElementById("current-password").value;

            const newPassword =
                document.getElementById("new-password").value;

            const confirmPassword =
                document.getElementById("confirm-password").value;

            if (!currentPassword || !newPassword || !confirmPassword) {
                showMessage("비밀번호를 모두 입력해 주세요.", false);
                return;
            }

            if (newPassword.length < 8) {
                showMessage("새 비밀번호는 8자 이상이어야 합니다.", false);
                return;
            }

            if (newPassword !== confirmPassword) {
                showMessage(
                    "새 비밀번호와 확인 값이 일치하지 않습니다.",
                    false
                );
                return;
            }

            if (currentPassword === newPassword) {
                showMessage(
                    "현재 비밀번호와 다른 비밀번호를 입력해 주세요.",
                    false
                );
                return;
            }

            const headers = {
                "Content-Type": "application/json; charset=UTF-8",
                "Accept": "text/plain, application/json"
            };

            const csrfToken =
                document.querySelector('meta[name="_csrf"]').content;

            const csrfHeader =
                document.querySelector('meta[name="_csrf_header"]').content;

            if (csrfHeader && csrfToken) {
                headers[csrfHeader] = csrfToken;
            }

            submitting = true;
            button.disabled = true;
            button.textContent = "변경 중...";

            try {
                const response = await fetch(form.action, {
                    method: "PUT",
                    credentials: "same-origin",
                    headers: headers,
                    body: JSON.stringify({
                        currentPassword: currentPassword,
                        newPassword: newPassword
                    })
                });

                if (response.status === 401 || response.redirected) {
                    showMessage("다시 로그인한 후 변경해 주세요.", false);
                    return;
                }

                if (response.status === 403) {
                    showMessage(
                        "요청이 거부되었습니다. 페이지를 새로고침한 뒤 다시 시도해 주세요.",
                        false
                    );
                    return;
                }

                const contentType =
                    response.headers.get("content-type") || "";

                const text = await response.text();

                let result = null;

                try {
                    result = JSON.parse(text);
                } catch (ignored) {
                }

                if (!response.ok || (result && result.success === false)) {
                    let message =
                        "비밀번호를 변경하지 못했습니다. 입력 내용을 확인해 주세요.";

                    if (
                        result &&
                        typeof result.message === "string" &&
                        result.message
                    ) {
                        message = result.message;

                    } else if (
                        contentType.includes("text/plain") &&
                        text.trim()
                    ) {
                        message = text;
                    }

                    showMessage(message, false);
                    return;
                }

                if (contentType.includes("text/html")) {
                    showMessage(
                        "서버 응답을 확인할 수 없습니다. 다시 로그인한 후 시도해 주세요.",
                        false
                    );
                    return;
                }

                form.reset();
                showMessage("비밀번호가 변경되었습니다.", true);

            } catch (error) {
                showMessage("서버와의 통신 중 오류가 발생했습니다.", false);

            } finally {
                submitting = false;
                button.disabled = false;
                button.textContent = "비밀번호 변경";
            }
        });
    }());
    </script>

</body>
</html>