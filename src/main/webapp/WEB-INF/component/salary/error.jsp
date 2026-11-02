<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>급여 처리 오류</title>
</head>
<body>
    <h1>급여 처리 안내</h1>

    <p><%= HtmlUtils.htmlEscape(
        String.valueOf(request.getAttribute("errorMessage"))
    ) %></p>

    <button type="button" onclick="history.back()">이전 화면</button>

    <a href="${pageContext.request.contextPath}/salary/list">
        급여 목록
    </a>
</body>
</html>