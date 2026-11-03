<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>부서 관리</title>
</head>
<body>

    <h1>부서 관리 메인 화면</h1>
    <p>부서 등록이 완료되었습니다.</p>

    <button onclick="location.href='${pageContext.request.contextPath}/departments/new'">
        + 부서 등록
    </button>

</body>
</html>