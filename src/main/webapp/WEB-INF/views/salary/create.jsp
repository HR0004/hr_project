<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="org.springframework.validation.BindingResult" %>
<%@ page import="org.springframework.validation.BeanPropertyBindingResult" %>
<%@ page import="org.springframework.validation.FieldError" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>
<%@ page import="com.hexagon.hrproject.dto.request.SalaryCreateRequest" %>
<%!
    private String text(Object value) {
        return value == null ? "" : HtmlUtils.htmlEscape(value.toString());
    }

    private String value(BindingResult fields, String name) {
        // 변환에 실패한 값도 DTO의 null 대신 원래 입력 문자열로 표시한다.
        return text(fields.getFieldValue(name));
    }

    private String inputType(BindingResult fields, String name, String normalType) {
        // number/month/date 입력은 잘못된 문자열을 브라우저가 지우므로 오류 시 text로 보존한다.
        return fields.hasFieldErrors(name) ? "text" : normalType;
    }

    private String fieldMessage(BindingResult fields, String name) {
        FieldError error = fields.getFieldError(name);
        if (error == null) return "";
        if (error.isBindingFailure()) {
            if ("paymentDate".equals(name)) return "지급일을 yyyy-MM-dd 형식의 올바른 날짜로 입력하세요.";
            if ("empId".equals(name)) return "사원 번호는 1 이상의 정수로 입력하세요.";
            return "금액은 15자리 이내의 정수로 입력하세요.";
        }
        return text(error.getDefaultMessage());
    }
%>
<%
    SalaryCreateRequest formValue = (SalaryCreateRequest) request.getAttribute("salaryCreateRequest");
    if (formValue == null) formValue = new SalaryCreateRequest();
    BindingResult fields = (BindingResult) request.getAttribute(
            BindingResult.MODEL_KEY_PREFIX + "salaryCreateRequest");
    if (fields == null) fields = new BeanPropertyBindingResult(formValue, "salaryCreateRequest");
    Object errorMessage = request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
    .error-summary {
        padding: 14px;
        border: 1px solid #b42318;
        border-radius: 6px;
        background: #fff4f2;
        color: #8a1c13;
        line-height: 1.5;
    }
    .error-summary:focus { outline: 2px solid #b42318; outline-offset: 3px; }
    .field-error { color: #a51d13; margin: 6px 0 0; font-size: 14px; }
    .field-error:empty { display: none; }
    input[aria-invalid="true"] { border: 2px solid #b42318; }
    dialog {
        box-sizing: border-box;
        width: calc(100% - 32px);
        max-width: 540px;
        max-height: calc(100% - 32px);
        padding: 24px;
        border: 0;
        border-radius: 12px;
        overflow-y: auto;
    }
    dialog::backdrop { background: rgba(20, 30, 45, 0.5); }
    dialog h2 { margin-top: 0; }
    .review-description { color: #536173; line-height: 1.5; }
    .review-row {
        display: grid;
        grid-template-columns: 110px minmax(0, 1fr);
        gap: 12px;
        padding: 14px 0;
        border-bottom: 1px solid #e1e5ea;
    }
    .review-row dt { font-weight: bold; }
    .review-row dd { margin: 0; text-align: right; overflow-wrap: anywhere; }
    .review-net { background: #eef3fb; color: #194380; font-weight: bold; }
    .review-actions { display: flex; flex-wrap: wrap; justify-content: flex-end; gap: 12px; margin-top: 24px; }
    .confirm-button { border: 1px solid #2457a7; background: #2457a7; color: white; border-radius: 6px; }
    button:focus-visible { outline: 3px solid #2457a7; outline-offset: 3px; }
    button:disabled { cursor: wait; opacity: 0.6; }
    @media (max-width: 600px) {
        body { margin: 0; padding: 16px; }
        main { padding: 20px 16px; }
    }
</style>
</head>
<body>
<main>
    <h1>급여 등록</h1>

    <% if (errorMessage != null || fields.hasErrors()) { %>
    <div class="error-summary" id="formErrors" role="alert" tabindex="-1">
        <strong>급여를 등록하지 못했습니다.</strong>
        <p><%= errorMessage == null ? "입력값을 확인하세요." : text(errorMessage) %></p>
        <p>입력한 내용은 유지되어 있습니다. 내용을 확인한 뒤 다시 등록하세요.</p>
    </div>
    <% } %>

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
               type="<%= inputType(fields, "empId", "number") %>" min="1" step="1" inputmode="numeric"
               value="<%= value(fields, "empId") %>" required
               aria-invalid="<%= fields.hasFieldErrors("empId") %>" aria-describedby="empIdError">
        <p class="field-error" id="empIdError"><%= fieldMessage(fields, "empId") %></p>

        <label for="salaryYearMonth">지급 연월</label>
        <input id="salaryYearMonth" name="salaryYearMonth"
               type="<%= inputType(fields, "salaryYearMonth", "month") %>" placeholder="yyyy-MM"
               value="<%= value(fields, "salaryYearMonth") %>" required
               aria-invalid="<%= fields.hasFieldErrors("salaryYearMonth") %>" aria-describedby="salaryYearMonthError">
        <p class="field-error" id="salaryYearMonthError"><%= fieldMessage(fields, "salaryYearMonth") %></p>

        <label for="baseSalary">기본급 (원)</label>
        <input id="baseSalary" name="baseSalary"
               type="<%= inputType(fields, "baseSalary", "number") %>" min="0" step="1" inputmode="numeric"
               max="999999999999999" value="<%= value(fields, "baseSalary") %>" required
               aria-invalid="<%= fields.hasFieldErrors("baseSalary") %>" aria-describedby="baseSalaryError">
        <p class="field-error" id="baseSalaryError"><%= fieldMessage(fields, "baseSalary") %></p>

        <label for="bonus">수당 (원)</label>
        <input id="bonus" name="bonus"
               type="<%= inputType(fields, "bonus", "number") %>" min="0" step="1" inputmode="numeric"
               max="999999999999999" value="<%= value(fields, "bonus") %>" required
               aria-invalid="<%= fields.hasFieldErrors("bonus") %>" aria-describedby="bonusError">
        <p class="field-error" id="bonusError"><%= fieldMessage(fields, "bonus") %></p>

        <label for="deduction">공제 (원)</label>
        <input id="deduction" name="deduction"
               type="<%= inputType(fields, "deduction", "number") %>" min="0" step="1" inputmode="numeric"
               max="999999999999999" value="<%= value(fields, "deduction") %>" required
               aria-invalid="<%= fields.hasFieldErrors("deduction") %>" aria-describedby="deductionError">
        <p class="field-error" id="deductionError"><%= fieldMessage(fields, "deduction") %></p>

        <label for="paymentDate">지급일</label>
        <input id="paymentDate" name="paymentDate"
               type="<%= inputType(fields, "paymentDate", "date") %>" placeholder="yyyy-MM-dd"
               value="<%= value(fields, "paymentDate") %>"
               aria-invalid="<%= fields.hasFieldErrors("paymentDate") %>" aria-describedby="paymentDateError">
        <p class="field-error" id="paymentDateError"><%= fieldMessage(fields, "paymentDate") %></p>

        <output id="netSalary" aria-live="polite">
            예상 실수령액: —
        </output>

        <button id="reviewButton" type="submit">등록 내용 확인</button>
        <a href="${pageContext.request.contextPath}/salary/list">
            목록으로
        </a>
    </form>
</main>

<dialog id="salaryReview" aria-labelledby="reviewTitle" aria-describedby="reviewDescription">
    <h2 id="reviewTitle">급여 등록 내용 확인</h2>
    <p class="review-description" id="reviewDescription">아래 내역을 확인한 뒤 등록을 확정하세요.</p>
    <dl>
        <div class="review-row"><dt>사원 번호</dt><dd id="reviewEmpId"></dd></div>
        <div class="review-row"><dt>지급 연월</dt><dd id="reviewMonth"></dd></div>
        <div class="review-row"><dt>기본급</dt><dd id="reviewBase"></dd></div>
        <div class="review-row"><dt>수당</dt><dd id="reviewBonus"></dd></div>
        <div class="review-row"><dt>공제액</dt><dd id="reviewDeduction"></dd></div>
        <div class="review-row review-net"><dt>예상 실수령액</dt><dd id="reviewNet"></dd></div>
        <div class="review-row"><dt>지급일</dt><dd id="reviewDate"></dd></div>
    </dl>
    <div class="review-actions">
        <button id="reviewBack" type="button" autofocus>입력 수정</button>
        <button id="reviewConfirm" type="button" class="confirm-button">등록 확정</button>
    </div>
</dialog>

<script>
const form = document.getElementById("salaryForm");
const output = document.getElementById("netSalary");
const amountIds = ["baseSalary", "bonus", "deduction"];

function updateNetSalary() {
    const inputs = amountIds.map(id => document.getElementById(id));

    if (inputs.some(input =>
            input.value === "" || !input.validity.valid || !/^[0-9]+$/.test(input.value))) {
        output.textContent = "예상 실수령액: —";
        return;
    }

    const [base, bonus, deduction] =
        inputs.map(input => Number(input.value));

    if ([base, bonus, deduction].some(value =>
            !Number.isSafeInteger(value) || value > 999999999999999)) {
        output.textContent = "예상 실수령액: —";
        return;
    }

    const net = base + bonus - deduction;

    output.textContent =
        "예상 실수령액: " + net.toLocaleString("ko-KR") + "원";
}

form.addEventListener("input", updateNetSalary);
updateNetSalary();
const errors = document.getElementById("formErrors");
if (errors) errors.focus();

const review = document.getElementById("salaryReview");
const reviewButton = document.getElementById("reviewButton");
const confirmButton = document.getElementById("reviewConfirm");
let submitting = false;

function reviewAmount(id) {
    const raw = document.getElementById(id).value;
    const number = Number(raw);
    return raw !== "" && Number.isFinite(number)
        ? number.toLocaleString("ko-KR") + "원" : raw || "미입력";
}

function fillReview() {
    // 입력 문자열을 HTML로 해석하지 않고 텍스트로만 표시한다.
    const values = {
        reviewEmpId: document.getElementById("empId").value,
        reviewMonth: document.getElementById("salaryYearMonth").value,
        reviewBase: reviewAmount("baseSalary"),
        reviewBonus: reviewAmount("bonus"),
        reviewDeduction: reviewAmount("deduction"),
        reviewNet: output.textContent.replace("예상 실수령액: ", "").trim(),
        reviewDate: document.getElementById("paymentDate").value || "미정"
    };
    Object.entries(values).forEach(([id, text]) => {
        document.getElementById(id).textContent = text;
    });
    return values;
}

function confirmRegistration() {
    if (submitting) return;
    if (!form.reportValidity()) {
        if (review.open) review.close();
        return;
    }
    submitting = true;
    reviewButton.disabled = true;
    confirmButton.disabled = true;
    if (review.open) review.close();
    // 기존 POST로 입력값과 CSRF 토큰을 전송한다. 저장 시 검증과 금액 계산은 그대로 수행한다.
    HTMLFormElement.prototype.submit.call(form);
}

form.addEventListener("submit", event => {
    event.preventDefault();
    if (submitting || !form.reportValidity()) return;
    updateNetSalary();
    const values = fillReview();
    if (typeof review.showModal === "function") {
        if (!review.open) review.showModal();
    } else {
        const summary = [
            "사원 번호: " + values.reviewEmpId,
            "지급 연월: " + values.reviewMonth,
            "기본급: " + values.reviewBase,
            "수당: " + values.reviewBonus,
            "공제액: " + values.reviewDeduction,
            "예상 실수령액: " + values.reviewNet,
            "지급일: " + values.reviewDate,
            "이 내용으로 등록하시겠습니까?"
        ].join("\n");
        if (window.confirm(summary)) confirmRegistration();
    }
});

document.getElementById("reviewBack").addEventListener("click", () => review.close());
confirmButton.addEventListener("click", confirmRegistration);
review.addEventListener("close", () => {
    if (!submitting) reviewButton.focus();
});
window.addEventListener("pageshow", () => {
    submitting = false;
    reviewButton.disabled = false;
    confirmButton.disabled = false;
});
</script>
</body>
</html>
