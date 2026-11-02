<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 부서 등록</title>
</head>
<body>

<h2>신규 부서 등록</h2>

<div>
    <label>부서코드</label>
    <input type="text" value="자동 생성" readonly>
</div>

<div>
    <label>부서명 *</label>
    <input type="text" id="departmentName"
           placeholder="부서명을 입력하세요">
</div>

<button type="button" onclick="registerDepartment()">
    등록
</button>

<script>
async function registerDepartment() {

    const name = document.getElementById("departmentName")
                         .value.trim();

    if (!name) {
        alert("부서명을 입력하세요.");
        return;
    }

    try {
        const response = await fetch(
            "${pageContext.request.contextPath}/api/departments",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    departmentName: name
                })
            }
        );

        if (!response.ok) {
            throw new Error("등록 실패");
        }

        alert("부서 등록 성공!");

    } catch (error) {
        console.error(error);
        alert("부서 등록 중 오류가 발생했습니다.");
    }
}
</script>

</body>
</html>s