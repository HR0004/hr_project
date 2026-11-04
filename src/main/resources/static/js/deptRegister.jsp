<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<script type="text/javascript">
const contextPath = document.body.dataset.contextPath;

const getList = async () => {
    try {
        const response = await fetch(contextPath + "/api/departments", {
            method: "GET"
        });

        const result = await response.json();

        if (!response.ok || !result.success) {
            throw new Error(result.message || "부서 목록 조회 실패");
        }

        renderList(result.data);

    } catch (error) {
        console.error(error);
        alert(error.message);
    }
};

const renderList = (list) => {
    const tbody = document.getElementById("departmentBody");
    tbody.innerHTML = "";

    let activeCount = 0;
    let inactiveCount = 0;

    list.forEach(dept => {
        if (dept.isActive === 1) {
            activeCount++;
        } else {
            inactiveCount++;
        }

        const tr = document.createElement("tr");

        tr.innerHTML = `
            <td>${dept.departmentCode}</td>
            <td>${dept.departmentName}</td>
            <td>${dept.isActive === 1 ? "활성" : "비활성"}</td>
            <td>
                <button type="button">수정</button>
            </td>
        `;

        tbody.appendChild(tr);
    });

    document.getElementById("totalCount").textContent = list.length;
    document.getElementById("activeCount").textContent = activeCount;
    document.getElementById("inactiveCount").textContent = inactiveCount;
};

document.getElementById("openRegisterBtn").addEventListener("click", () => {
    window.open(
        contextPath + "/departments/new",
        "departmentRegisterPopup",
        "width=650,height=500,top=100,left=200"
    );
});

getList();

</script>

</body>
</html>