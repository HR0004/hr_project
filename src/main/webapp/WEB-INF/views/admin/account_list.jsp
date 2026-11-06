<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.Collections" %>
<%@ page import="com.hexagon.hrproject.domain.Account" %>
<%@ page import="com.hexagon.hrproject.domain.HrRole" %>

<%!
    private String accountListEscape(Object value) {
        if (value == null) return "";

        return String.valueOf(value)
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
%>

<%
    Object accountListValue =
        request.getAttribute("accountList");

    List<Account> accounts = accountListValue instanceof List
        ? (List<Account>) accountListValue
        : Collections.<Account>emptyList();

    String searchKeyword =
        accountListEscape(request.getAttribute("keyword"));

    int enabledCount = 0;
    int disabledCount = 0;
    int unassignedCount = 0;

    for (Account item : accounts) {
        if (item.getEnabled() == 1) {
            enabledCount++;
        } else {
            disabledCount++;
        }

        if (item.getRoles() == null || item.getRoles().isEmpty()) {
            unassignedCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>HRMS - 권한 관리</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employee.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/accountlist.css?v=1">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">

    <%@ include file="/WEB-INF/views/common/header.jspf" %>

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <main class="content-wrapper employee-page account-list-page">

        <!-- 페이지 제목 -->
        <section class="content-header">
            <div class="container-fluid">

                <h1 class="employee-page-title">
                    권한 관리
                </h1>

                <p class="employee-page-desc">
                    계정 조회 · 역할 부여 · 활성/비활성 관리
                </p>

            </div>
        </section>

        <section class="content">
            <div class="container-fluid">

                <!-- 계정 상태 변경 결과 -->
                <% if (request.getAttribute("accountStatusMessage") != null) { %>

                <p id="account-status-feedback"
                   class="account-status-feedback"
                   role="alert"><%=accountListEscape(request.getAttribute("accountStatusMessage"))%></p>

                <% } %>

                <!-- 조회된 계정 통계 -->
                <div class="employee-stats"
                     aria-label="조회된 계정 현황">

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">
                            조회 계정
                        </div>

                        <div class="employee-stat-number">
                            <%=accounts.size()%>
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">
                            사용 중
                        </div>

                        <div class="employee-stat-number">
                            <%=enabledCount%>
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">
                            사용 중지
                        </div>

                        <div class="employee-stat-number">
                            <%=disabledCount%>
                        </div>
                    </div>

                    <div class="employee-stat-card">
                        <div class="employee-stat-label">
                            역할 미지정
                        </div>

                        <div class="employee-stat-number">
                            <%=unassignedCount%>
                        </div>
                    </div>

                </div>

                <!-- 목록 제목과 작업 버튼 -->
                <div class="employee-toolbar">

                    <h2 class="employee-list-title">
                        권한 부여 대상 선택
                    </h2>

                    <div class="employee-toolbar-actions">

                        <button type="button"
                                class="employee-btn account-filter-toggle"
                                id="account-filter-toggle"
                                aria-controls="account-search-panel"
                                aria-expanded="true">

                            <i class="fas fa-search"
                               aria-hidden="true"></i>

                            검색/필터
                        </button>

                        <button type="submit"
                                form="account-selection-form"
                                class="employee-register-btn"
                                id="account-next-button"
                                disabled>
                            다음 · 역할 선택
                        </button>

                    </div>
                </div>

                <!-- 검색 폼 -->
                <form class="account-search-form"
                      id="account-search-panel"
                      method="get"
                      action="${pageContext.request.contextPath}/admin/accounts">

                    <label class="account-sr-only"
                           for="account-keyword">
                        이름 또는 로그인 아이디
                    </label>

                    <input type="search"
                           id="account-keyword"
                           name="keyword"
                           placeholder="이름 또는 로그인 아이디 검색"
                           value="<%=searchKeyword%>"
                           maxlength="100">

                    <button type="submit"
                            class="employee-search-btn account-search-submit">
                        검색
                    </button>

                    <a href="${pageContext.request.contextPath}/admin/accounts"
                       class="account-reset-link">
                        초기화
                    </a>

                </form>

                <!-- 계정 선택 폼 -->
                <form id="account-selection-form"
                      method="get"
                      action="${pageContext.request.contextPath}/admin/accounts"
                      data-account-base="${pageContext.request.contextPath}/admin/accounts/">

                    <div class="employee-table-wrap">

                        <table class="employee-table account-select-table">

                            <caption class="account-sr-only">
                                권한 관리 대상 계정 목록
                            </caption>

                            <thead>
                                <tr>
                                    <th scope="col">선택</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">로그인 아이디</th>
                                    <th scope="col">현재 역할</th>
                                    <th scope="col">계정 상태</th>
                                    <th scope="col">상태 변경</th>
                                </tr>
                            </thead>

                            <tbody>

                            <%
                            for (Account item : accounts) {

                                String employeeName =
                                    item.getEmp() != null
                                        ? item.getEmp().getEname()
                                        : null;

                                if (employeeName == null
                                        || employeeName.trim().isEmpty()) {
                                    employeeName = "사원 정보 없음";
                                }

                                boolean isOwnAccount =
                                    request.getUserPrincipal() != null
                                    && item.getLoginId() != null
                                    && item.getLoginId().equals(
                                        request.getUserPrincipal().getName()
                                    );

                                boolean blockSelfDisable =
                                    isOwnAccount && item.getEnabled() == 1;
                            %>

                                <tr data-account-row>

                                    <td>
                                        <input type="radio"
                                               name="accountId"
                                               value="<%=item.getAccountId()%>"
                                               aria-label="<%=accountListEscape(employeeName)%> 선택"
                                               data-user-label="<%=accountListEscape(employeeName + " (" + item.getLoginId() + ")")%>">
                                    </td>

                                    <td>
                                        <%=accountListEscape(employeeName)%>
                                    </td>

                                    <td>
                                        <%=accountListEscape(item.getLoginId())%>
                                    </td>

                                    <td>
                                    <%
                                        boolean hasRole = false;

                                        if (item.getRoles() != null) {
                                            for (HrRole role : item.getRoles()) {
                                                if (role == null) continue;

                                                hasRole = true;
                                    %>

                                        <span class="account-role-badge">
                                            <%=accountListEscape(
                                                role.getRoleName() != null
                                                    ? role.getRoleName()
                                                    : role.getRoleCode()
                                            )%>
                                        </span>

                                    <%
                                            }
                                        }

                                        if (!hasRole) {
                                    %>

                                        <span class="account-muted">
                                            미지정
                                        </span>

                                    <%
                                        }
                                    %>
                                    </td>

                                    <td>
                                        <span class="employee-status <%=item.getEnabled() == 1 ? "status-active" : "status-retired"%>">
                                            <%=item.getEnabled() == 1
                                                ? "사용 중"
                                                : "사용 중지"%>
                                        </span>
                                    </td>

                                    <td>
                                        <button type="submit"
                                                form="account-status-<%=item.getAccountId()%>"
                                                class="account-status-button <%=item.getEnabled() == 1 ? "account-disable" : "account-enable"%>"
                                                <%=blockSelfDisable ? "disabled" : ""%>>

                                            <%=blockSelfDisable
                                                ? "본인 계정"
                                                : (item.getEnabled() == 1
                                                    ? "비활성화"
                                                    : "활성화")%>

                                        </button>
                                    </td>

                                </tr>

                            <%
                            }

                            if (accounts.isEmpty()) {
                            %>

                                <tr>
                                    <td colspan="6"
                                        class="account-empty-list">
                                        조회된 계정이 없습니다.
                                        검색어를 바꾸거나 초기화해 주세요.
                                    </td>
                                </tr>

                            <%
                            }
                            %>

                            </tbody>

                        </table>

                    </div>

                </form>

                <!-- 상태 변경 폼: 선택 폼 밖에 배치 -->
                <% for (Account statusAccount : accounts) { %>

                <form id="account-status-<%=statusAccount.getAccountId()%>"
                      class="account-status-form"
                      method="post"
                      hidden
                      action="${pageContext.request.contextPath}/admin/accounts/<%=statusAccount.getAccountId()%>/status">

                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}">

                    <input type="hidden"
                           name="enabled"
                           value="<%=statusAccount.getEnabled() == 1 ? 0 : 1%>">

                    <input type="hidden"
                           name="keyword"
                           value="<%=searchKeyword%>">

                </form>

                <% } %>

                <p id="account-selection-message"
                   class="employee-notice"
                   role="status">
                    사용자를 선택해 주세요.
                </p>

                <p class="account-scope-note">
                    ※ 상단 숫자는 현재 검색 결과를 기준으로 표시합니다.
                    사용자를 선택한 뒤 다음 버튼으로 역할 관리 화면에 이동합니다.
                </p>

            </div>
        </section>

    </main>

</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>
(function () {
    var form = document.getElementById("account-selection-form");
    var next = document.getElementById("account-next-button");

    var message = document.getElementById(
        "account-selection-message"
    );

    var rows = form.querySelectorAll("[data-account-row]");

    function updateSelection() {
        var selected = form.querySelector(
            'input[name="accountId"]:checked'
        );

        next.disabled = !selected;

        message.textContent = selected
            ? "선택한 사용자: "
                + selected.getAttribute("data-user-label")
            : "사용자를 선택해 주세요.";

        Array.prototype.forEach.call(rows, function (row) {
            var radio = row.querySelector(
                'input[type="radio"]'
            );

            row.classList.toggle(
                "is-selected",
                radio.checked
            );
        });
    }

    form.addEventListener("change", updateSelection);

    Array.prototype.forEach.call(rows, function (row) {
        row.addEventListener("click", function (event) {
            if (event.target.closest("input, button, a, label")) {
                return;
            }

            row.querySelector(
                'input[type="radio"]'
            ).checked = true;

            updateSelection();
        });
    });

    form.addEventListener("submit", function (event) {
        event.preventDefault();

        var selected = form.querySelector(
            'input[name="accountId"]:checked'
        );

        if (!selected) {
            return;
        }

        window.location.assign(
            form.getAttribute("data-account-base")
            + encodeURIComponent(selected.value)
        );
    });

    // 검색 패널 열기/닫기
    var filterToggle = document.getElementById(
        "account-filter-toggle"
    );

    var searchPanel = document.getElementById(
        "account-search-panel"
    );

    filterToggle.addEventListener("click", function () {
        searchPanel.hidden = !searchPanel.hidden;

        filterToggle.setAttribute(
            "aria-expanded",
            String(!searchPanel.hidden)
        );

        if (!searchPanel.hidden) {
            document.getElementById("account-keyword").focus();
        }
    });

    // 계정 활성/비활성 변경
    var statusForms = document.querySelectorAll(
        ".account-status-form"
    );

    var statusButtons = document.querySelectorAll(
        ".account-status-button"
    );

    var initiallyDisabled = Array.prototype.map.call(
        statusButtons,
        function (button) {
            return button.disabled;
        }
    );

    var statusSubmitting = false;

    Array.prototype.forEach.call(statusForms, function (statusForm) {
        statusForm.addEventListener("submit", function (event) {

            var button = document.querySelector(
                'button[form="' + statusForm.id + '"]'
            );

            if (statusSubmitting || !button || button.disabled) {
                event.preventDefault();
                return;
            }

            if (!window.confirm("계정 상태를 변경하시겠습니까?")) {
                event.preventDefault();
                return;
            }

            statusSubmitting = true;

            Array.prototype.forEach.call(statusButtons, function (item) {
                item.disabled = true;
            });
        });
    });

    // 뒤로가기로 돌아왔을 때 버튼 상태 복구
    window.addEventListener("pageshow", function (event) {
        if (event.persisted) {
            statusSubmitting = false;

            Array.prototype.forEach.call(
                statusButtons,
                function (button, index) {
                    button.disabled = initiallyDisabled[index];
                }
            );

            updateSelection();
        }
    });

    // 서버에서 전달한 변경 결과
    var feedback = document.getElementById(
        "account-status-feedback"
    );

    if (feedback && feedback.textContent.trim()) {
        window.alert(feedback.textContent.trim());
    }

    updateSelection();
})();
</script>

</body>
</html>