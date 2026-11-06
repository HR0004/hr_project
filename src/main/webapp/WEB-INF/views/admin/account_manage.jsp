<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.Map,java.util.Collections,java.util.Objects" %>
<%@ page import="com.hexagon.hrproject.domain.Account" %>
<%@ page import="com.hexagon.hrproject.domain.HrRole" %>

<%!
    private String rolePreviewEscape(Object value) {
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
    Account managedAccount =
        (Account) request.getAttribute("account");

    List<HrRole> roleOptions =
        (List<HrRole>) request.getAttribute("roleList");

    if (roleOptions == null) {
        roleOptions = Collections.<HrRole>emptyList();
    }

    List<HrRole> assignedRoles = managedAccount == null
        ? null
        : managedAccount.getRoles();

    List<Map<String, Object>> permissionRows =
        (List<Map<String, Object>>)
            request.getAttribute("rolePermissions");

    boolean permissionDataReady = permissionRows != null;

    if (permissionRows == null) {
        permissionRows =
            Collections.<Map<String, Object>>emptyList();
    }

    boolean hasRoleOption = false;

    for (HrRole option : roleOptions) {
        if (option != null) {
            hasRoleOption = true;
            break;
        }
    }

    boolean saveCompleted =
        Boolean.TRUE.equals(
            request.getAttribute("roleSaveSuccess")
        );
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>HRMS - 권한 부여</title>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/account-manage.css?v=preview-1">
</head>

<body class="account-manage-page">

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <main class="main-area">

        <div class="top-nav-bar">
            <div class="page-title-area">
                <div class="breadcrumb">HRMS / 권한 관리</div>
                <h1>사원 계정 및 역할(Role) 설정</h1>
            </div>

            <%@ include file="/WEB-INF/views/common/header.jspf" %>
        </div>

        <section class="content-card">

            <% if (managedAccount != null) { %>

            <h2 class="account-info-title">
                계정 정보:
                <%=rolePreviewEscape(managedAccount.getLoginId())%>

                (<%=rolePreviewEscape(
                    managedAccount.getEmp() == null
                        ? ""
                        : managedAccount.getEmp().getEname()
                )%>)
            </h2>

            <% if (!permissionDataReady) { %>
            <p class="empty-message" role="alert">
                권한 정보를 불러오지 못했습니다.
                컨트롤러 적용 여부를 확인해 주세요.
            </p>
            <% } %>

            <form id="roleForm"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/accounts/<%=managedAccount.getAccountId()%>/roles"
                  data-save-completed="<%=saveCompleted%>">

                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <!-- 역할 선택 -->
                <section id="roleSelection"
                         aria-labelledby="roleSelectionTitle">

                    <h3 id="roleSelectionTitle" class="section-subtitle">
                        부여할 역할 선택
                    </h3>

                    <div class="role-list-container">

                        <%
                        for (HrRole option : roleOptions) {
                            if (option == null) continue;

                            boolean checked = false;

                            if (assignedRoles != null) {
                                for (HrRole assigned : assignedRoles) {
                                    if (assigned != null
                                            && Objects.equals(
                                                assigned.getHrRoleId(),
                                                option.getHrRoleId())) {

                                        checked = true;
                                        break;
                                    }
                                }
                            }
                        %>

                        <label class="role-label">

                            <input type="checkbox"
                                   name="roleIds"
                                   value="<%=option.getHrRoleId()%>"
                                   data-role-name="<%=rolePreviewEscape(option.getRoleName())%>"
                                   data-role-code="<%=rolePreviewEscape(option.getRoleCode())%>"
                                   <%=checked ? "checked" : ""%>>

                            <span>
                                <strong>
                                    <%=rolePreviewEscape(option.getRoleName())%>
                                </strong>
                                (<%=rolePreviewEscape(option.getRoleCode())%>)
                            </span>

                            <!-- DB에서 조회한 역할별 권한 정보 -->
                            <span class="role-permission-data" hidden>
                                <%
                                for (Map<String, Object> permissionRow
                                        : permissionRows) {

                                    if (!String.valueOf(
                                            option.getHrRoleId()
                                        ).equals(String.valueOf(
                                            permissionRow.get("roleId")
                                        ))) {
                                        continue;
                                    }
                                %>

                                <span
                                    data-permission-code="<%=rolePreviewEscape(permissionRow.get("permissionCode"))%>"
                                    data-permission-name="<%=rolePreviewEscape(permissionRow.get("permissionName"))%>">
                                </span>

                                <% } %>
                            </span>

                        </label>

                        <% } %>

                        <% if (!hasRoleOption) { %>
                        <p class="empty-message">
                            선택 가능한 역할이 없습니다.
                        </p>
                        <% } %>

                    </div>

                    <button id="previewButton"
                            type="button"
                            class="btn-save"
                            <%=hasRoleOption && permissionDataReady
                                ? ""
                                : "disabled"%>>
                        다음 · 권한 미리보기
                    </button>

                </section>

                <!-- 저장 전 미리보기 -->
                <section id="rolePreview"
                         aria-labelledby="previewTitle"
                         hidden>

                    <h3 id="previewTitle"
                        class="section-subtitle"
                        tabindex="-1">
                        저장 전 권한 미리보기
                    </h3>

                    <dl class="preview-summary">

                        <div>
                            <dt>사원</dt>
                            <dd>
                                <%=rolePreviewEscape(
                                    managedAccount.getEmp() == null
                                        ? "사원 정보 없음"
                                        : managedAccount.getEmp().getEname()
                                )%>
                            </dd>
                        </div>

                        <div>
                            <dt>로그인 아이디</dt>
                            <dd>
                                <%=rolePreviewEscape(
                                    managedAccount.getLoginId()
                                )%>
                            </dd>
                        </div>

                        <div>
                            <dt>선택한 역할</dt>
                            <dd id="previewRoles"></dd>
                        </div>

                    </dl>

                    <h4 class="section-subtitle">
                        선택한 역할에 연결된 권한
                    </h4>

                    <p id="previewEmpty"
                       class="empty-message"
                       role="status"
                       hidden>
                    </p>

                    <div id="permissionTableWrap"
                         class="preview-table-wrap">

                        <table class="preview-table">
                            <thead>
                                <tr>
                                    <th scope="col">권한 이름</th>
                                    <th scope="col">권한 코드</th>
                                </tr>
                            </thead>

                            <tbody id="previewPermissions"></tbody>
                        </table>

                    </div>

                    <p class="preview-note">
                        중복 권한은 한 번만 표시합니다.
                        변경된 권한은 대상 계정이 다시 로그인한 뒤 적용됩니다.
                    </p>

                    <div class="form-actions">

                        <button id="backButton"
                                type="button"
                                class="btn-list">
                            이전 · 역할 수정
                        </button>

                        <button id="saveButton"
                                type="submit"
                                class="btn-save"
                                disabled>
                            권한 저장하기
                        </button>

                    </div>

                </section>

            </form>

            <% } else { %>

            <p class="empty-message">
                조회된 계정 정보가 없습니다.
            </p>

            <% } %>

            <div class="list-navigation">
                <a class="btn-list"
                   href="${pageContext.request.contextPath}/admin/accounts">
                    목록으로
                </a>
            </div>

        </section>

    </main>

    <script>
    (function () {
        var form = document.getElementById("roleForm");
        if (!form) return;

        var selection = document.getElementById("roleSelection");
        var preview = document.getElementById("rolePreview");

        var previewButton = document.getElementById("previewButton");
        var backButton = document.getElementById("backButton");
        var saveButton = document.getElementById("saveButton");

        var roleOutput = document.getElementById("previewRoles");
        var permissionOutput =
            document.getElementById("previewPermissions");

        var emptyMessage = document.getElementById("previewEmpty");
        var tableWrap = document.getElementById("permissionTableWrap");

        var previewValid = false;
        var submitting = false;

        function showSelection() {
            previewValid = false;
            selection.hidden = false;
            preview.hidden = true;
            saveButton.disabled = true;
        }

        previewButton.addEventListener("click", function () {
            if (submitting || previewButton.disabled) return;

            var selected = form.querySelectorAll(
                'input[name="roleIds"]:checked'
            );

            var permissions = new Map();

            roleOutput.textContent = "";
            permissionOutput.textContent = "";

            Array.prototype.forEach.call(selected, function (input) {
                var badge = document.createElement("span");
                badge.className = "role-badge";

                badge.textContent =
                    input.dataset.roleName || input.dataset.roleCode;

                roleOutput.appendChild(badge);

                var source = input.closest("label").querySelectorAll(
                    "[data-permission-code]"
                );

                Array.prototype.forEach.call(source, function (item) {
                    var code = item.dataset.permissionCode;

                    if (code) {
                        permissions.set(
                            code,
                            item.dataset.permissionName || code
                        );
                    }
                });
            });

            permissions.forEach(function (name, code) {
                var row = document.createElement("tr");
                var nameCell = document.createElement("td");
                var codeCell = document.createElement("td");

                nameCell.textContent = name;
                codeCell.textContent = code;

                row.appendChild(nameCell);
                row.appendChild(codeCell);
                permissionOutput.appendChild(row);
            });

            if (!selected.length) {
                roleOutput.textContent = "선택된 역할 없음";
            }

            emptyMessage.hidden = permissions.size > 0;

            emptyMessage.textContent = !selected.length
                ? "선택된 역할이 없습니다. 저장하면 기존 역할이 모두 해제됩니다."
                : "선택한 역할에 연결된 세부 권한이 없습니다.";

            tableWrap.hidden = permissions.size === 0;

            selection.hidden = true;
            preview.hidden = false;
            previewValid = true;
            saveButton.disabled = false;

            document.getElementById("previewTitle").focus();
        });

        backButton.addEventListener("click", function () {
            if (submitting) return;

            showSelection();
            previewButton.focus();
        });

        form.addEventListener("change", function () {
            if (!submitting) {
                showSelection();
            }
        });

        form.addEventListener("submit", function (event) {
            if (submitting || !previewValid) {
                event.preventDefault();
                return;
            }

            var selected = form.querySelectorAll(
                'input[name="roleIds"]:checked'
            );

            var message = selected.length
                ? "권한을 변경하시겠습니까?"
                : "선택한 역할이 없습니다. 기존 역할을 모두 해제하시겠습니까?";

            if (!window.confirm(message)) {
                event.preventDefault();
                return;
            }

            submitting = true;
            saveButton.disabled = true;
            backButton.disabled = true;
            saveButton.textContent = "저장 중...";
        });

        window.addEventListener("pageshow", function (event) {
            if (event.persisted) {
                submitting = false;
                backButton.disabled = false;
                saveButton.textContent = "권한 저장하기";
                showSelection();
            }
        });

        if (form.dataset.saveCompleted === "true") {
            form.dataset.saveCompleted = "false";
            window.alert("권한이 변경되었습니다.");
        }
    }());
    </script>

</body>
</html>