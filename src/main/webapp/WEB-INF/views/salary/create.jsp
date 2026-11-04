<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>급여 등록</title>
<style>
    body {
        font-family: sans-serif;
        background: #f5f6f8;
        padding: 30px;
    }
    main {
        max-width: 560px;
        margin: auto;
        padding: 28px;
        background: white;
        border-radius: 12px;
    }
    label {
        display: block;
        margin-top: 18px;
        font-weight: bold;
    }
    input {
        box-sizing: border-box;
        width: 100%;
        margin-top: 6px;
        padding: 10px;
    }
    output {
        display: block;
        margin: 24px 0;
        font-size: 22px;
        font-weight: bold;
    }
    button {
        padding: 10px 18px;
        cursor: pointer;
    }
</style>
</head>
<body>
<main>
    <h1>급여 등록</h1>

    <form id="salaryForm"
          action="${pageContext.request.contextPath}/salary/create"
          method="post">

        <% if (request.getAttribute("_csrf") != null) { %>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}">
        <% } %>

        <label for="empId">사원 번호</label>
        <input id="empId" name="empId"
               type="number" min="1" step="1" required>

        <label for="salaryYearMonth">지급 연월</label>
        <input id="salaryYearMonth" name="salaryYearMonth"
               type="month" required>

        <label for="baseSalary">기본급 (원)</label>
        <input id="baseSalary" name="baseSalary"
               type="number" min="0" step="1"
               max="999999999999999" required>

        <label for="bonus">수당 (원)</label>
        <input id="bonus" name="bonus"
               type="number" min="0" step="1"
               max="999999999999999" value="0" required>

        <label for="deduction">공제 (원)</label>
        <input id="deduction" name="deduction"
               type="number" min="0" step="1"
               max="999999999999999" value="0" required>

        <label for="paymentDate">지급일</label>
        <input id="paymentDate" name="paymentDate" type="date">

        <output id="netSalary" aria-live="polite">
            예상 실수령액: —
        </output>

        <button type="submit">등록</button>
        <a href="${pageContext.request.contextPath}/salary/list">
            목록으로
        </a>
    </form>
</main>

<script>
const form = document.getElementById("salaryForm");
const output = document.getElementById("netSalary");
const amountIds = ["baseSalary", "bonus", "deduction"];

function updateNetSalary() {
    const inputs = amountIds.map(id => document.getElementById(id));

    if (inputs.some(input =>
            input.value === "" || !input.validity.valid)) {
        output.textContent = "예상 실수령액: —";
        return;
    }

    const [base, bonus, deduction] =
        inputs.map(input => Number(input.value));

    const net = base + bonus - deduction;

    output.textContent =
        "예상 실수령액: " + net.toLocaleString("ko-KR") + "원";
}

form.addEventListener("input", updateNetSalary);
updateNetSalary();
</script>
</body>
</html>