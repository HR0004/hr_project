<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<script type="text/javascript">
const contextPath = document.body.dataset.contextPath;

//부서 목록 조회
const getList = async () => {

 try {
     const response = await fetch(contextPath + "/api/departments", {
         method: "GET"
     });

     if (!response.ok) {
         throw new Error("부서 목록 조회 실패");
     }

     const result = await response.json();

     if (!result.success) {
         throw new Error(result.message);
     }

     console.log("부서 목록:", result.data);

     renderList(result.data);

 } catch (error) {
     console.error(error);
     alert(error.message);
 }
};

//조회한 부서 데이터를 테이블에 출력
const renderList = (list) => {

 const tbody = document.getElementById("departmentBody");

 tbody.replaceChildren();

 document.getElementById("totalCount").textContent = list.length;

 list.forEach(dept => {

     const tr = document.createElement("tr");

     const code = document.createElement("td");
     code.textContent = dept.departmentCode;

     const name = document.createElement("td");
     name.textContent = dept.departmentName;

     const status = document.createElement("td");
     status.textContent = String(dept.isActive) === "1"
         ? "활성" : "비활성";

     const action = document.createElement("td");
     const button = document.createElement("button");
     button.textContent = "수정";
     button.disabled = true; // 수정 기능 구현 시 연결
     action.appendChild(button);

     tr.append(code, name, status, action);

     tbody.appendChild(tr);
 });
};

//부서 등록 화면 이동
document.getElementById("bt-regist").addEventListener("click", () => {
 location.href = contextPath + "/departments/new";
});

//페이지를 열면 목록 자동 조회
getList();
</script>
<body>

</body>
</html>