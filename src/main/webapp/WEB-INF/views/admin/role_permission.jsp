<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.Map,java.util.Set" %>

<%!
    private String rolePermissionText(Object value) {
        return org.springframework.web.util.HtmlUtils.htmlEscape(
            value == null ? "" : String.valueOf(value)
        );
    }
%>

<%
    List<Map<String, Object>> rpRoles =
        (List<Map<String, Object>>) request.getAttribute("roles");

    List<Map<String, Object>> rpPermissions =
        (List<Map<String, Object>>) request.getAttribute("permissions");

    Long rpRoleId =
        (Long) request.getAttribute("selectedRoleId");

    Set<Long> rpSelected =
        (Set<Long>) request.getAttribute("selectedPermissionIds");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>HRMS - 역할별 권한 설정</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/role-permission.css?v=1">
</head>

<body class="role-permission-page">

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <main class="main-area">

        <div class="top-nav-bar">
            <div class="page-title-area">
                <p class="tools-location">HRMS / 권한 관리</p>
                <h1>역할별 권한 설정</h1>
            </div>

            <%@ include file="/WEB-INF/views/common/header.jspf" %>
        </div>

        <% if (request.getAttribute("rolePermissionMessage") != null) { %>

        <p id="rolePermissionMessage"
           class="tools-message"
           role="alert"><%=rolePermissionText(request.getAttribute("rolePermissionMessage"))%></p>

        <% } %>

        <div class="tools-navigation">
            <a href="${pageContext.request.contextPath}/admin/accounts">
                사용자별 역할 부여
            </a>
        </div>

        <section class="tools-card">

            <h2>역할에 사용할 수 있는 기능 지정</h2>

            <p class="tools-description">
                역할을 선택한 뒤 조회해 주세요.
                변경된 권한은 해당 사용자가 재로그인한 뒤 적용됩니다.
            </p>

            <!-- 역할 조회 -->
            <form method="get"
                  action="${pageContext.request.contextPath}/admin/roles/permissions"
                  class="tools-role-picker">

                <label for="roleSelect">역할</label>

                <select id="roleSelect" name="roleId">
                    <%
                    for (Map<String, Object> row : rpRoles) {
                        long id =
                            ((Number) row.get("roleId")).longValue();
                    %>

                    <option value="<%=id%>"
                            <%=rpRoleId != null
                                && rpRoleId.longValue() == id
                                ? "selected" : ""%>>

                        <%=rolePermissionText(row.get("roleName"))%>
                        (<%=rolePermissionText(row.get("roleCode"))%>)
                    </option>

                    <% } %>
                </select>

                <button type="submit" class="tools-secondary">
                    조회
                </button>

            </form>

            <% if (rpRoleId != null) { %>

            <!-- 권한 저장 -->
            <form id="rolePermissionForm"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/roles/permissions">

                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">

                <input type="hidden"
                       name="roleId"
                       value="<%=rpRoleId%>">

                <div class="tools-permissions">

                    <%
                    for (Map<String, Object> row : rpPermissions) {
                        long id = ((Number) row.get(
                            "permissionId"
                        )).longValue();
                    %>

                    <label class="tools-permission">

                        <input type="checkbox"
                               name="permissionIds"
                               value="<%=id%>"
                               <%=rpSelected.contains(id)
                                   ? "checked" : ""%>>

                        <span>
                            <strong>
                                <%=rolePermissionText(
                                    row.get("permissionName")
                                )%>
                            </strong>

                            <small>
                                <%=rolePermissionText(
                                    row.get("permissionCode")
                                )%>
                            </small>
                        </span>

                    </label>

                    <% } %>

                </div>

                <p class="tools-description">
                    인사 관리자 역할의 계정 관리·역할 부여·역할별 권한 설정
                    권한은 유지해야 합니다.
                </p>

                <button id="rolePermissionSave"
                        type="submit"
                        class="tools-button">
                    권한 저장
                </button>

            </form>

            <% } else { %>

            <p class="tools-description">
                설정할 역할이 없습니다.
            </p>

            <% } %>

        </section>

    </main>

    <script>
    (function () {
        var form =
            document.getElementById("rolePermissionForm");

        var button =
            document.getElementById("rolePermissionSave");

        var busy = false;

        if (form) {
            form.addEventListener("submit", function (event) {
                if (
                    busy ||
                    !window.confirm("권한을 변경하시겠습니까?")
                ) {
                    event.preventDefault();
                    return;
                }

                busy = true;
                button.disabled = true;
                button.textContent = "저장 중...";
            });

            window.addEventListener("pageshow", function (event) {
                if (event.persisted) {
                    busy = false;
                    button.disabled = false;
                    button.textContent = "권한 저장";
                }
            });
        }

        var message =
            document.getElementById("rolePermissionMessage");

        if (message) {
            window.alert(message.textContent.trim());
        }
    }());
    </script>

</body>
</html>