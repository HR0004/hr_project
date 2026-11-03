
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>부서 등록</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            padding: 40px;
        }

        .card {
            max-width: 600px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>부서 등록</h2>

    <form id="registerForm">
        <p>부서 코드는 등록 시 자동 생성됩니다.</p>

        <label for="departmentName">부서명</label>
        <input type="text"
               id="departmentName"
               name="departmentName"
               placeholder="부서명을 입력하세요."
               required
               maxlength="50">

        <div>
            <button type="button" id="cancelBtn">취소</button>
            <button type="submit">등록</button>
        </div>
    </form>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';

document.getElementById("registerForm").addEventListener("submit", async function(e) {
    e.preventDefault();

    const departmentName = document.getElementById("departmentName").value.trim();

    if (!departmentName) {
        alert("부서명을 입력하세요.");
        return;
    }

    try {
        const response = await fetch(contextPath + "/api/departments", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                departmentName: departmentName
            })
        });

        if (!response.ok) {
            throw new Error("등록 실패");
        }

        const result = await response.text();

        if (Number(result) !== 1) {
            throw new Error("등록 결과 확인 필요: " + result);
        }

        alert("부서가 등록되었습니다!");

        // 등록 성공 후 부서 관리 메인으로 이동
        location.href = contextPath + "/departments";

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
});

// 취소 버튼을 누르면 메인으로 이동
document.getElementById("cancelBtn").addEventListener("click", function() {
    location.href = contextPath + "/departments";
});
</script>

</body>
</html>
