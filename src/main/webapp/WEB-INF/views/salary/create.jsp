
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HRMS - 급여 등록</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/salary.css">
</head>

<body class="hold-transition sidebar-mini layout-fixed">

	<div class="wrapper">

		<%@ include file="/WEB-INF/views/common/header.jspf"%>
		<%@ include file="/WEB-INF/views/common/sidebar.jspf"%>

		<div class="content-wrapper salary-page">

			<section class="content-header">
				<div class="container-fluid salary-heading">
					<h1>급여 등록</h1>
					<p>지급 대상과 금액을 입력한 뒤 급여 내역을 검토해 주세요.</p>
				</div>
			</section>

			<section class="content">
				<div class="container-fluid">

					<div class="salary-notice">사원과 지급 연월을 선택하면 기존 급여 등록 여부를
						확인합니다.</div>


					<c:if test="${not empty errorMessage}">
						<div class="salary-alert salary-alert-error">
							<c:out value="${errorMessage}" />
						</div>


						<a
							href="${pageContext.request.contextPath}/salary/list?salaryYearMonth=${salaryCreateRequest.salaryYearMonth}&amp;employeeKeyword=${salaryCreateRequest.empId}"
							class="salary-cancel-btn"> 기존 급여 내역 보기 </a>

					</c:if>


					<form id="salaryCreateForm" method="post"
						action="${pageContext.request.contextPath}/salary/create">

						<c:if test="${not empty _csrf}">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}">
						</c:if>

						<div class="salary-form-card">

							<h2>급여 정보</h2>

							<div class="salary-form-grid">

								<!-- 대상 사원 -->
								<div class="salary-field">
									<label for="empId">대상 사원 *</label> <select id="empId"
										name="empId" class="salary-form-input" required>

										<option value="">사원을 선택하세요</option>

										<c:forEach var="emp" items="${salaryEmployees}">

											<option value="${emp.empId}"
												<c:if test="${salaryCreateRequest.empId == emp.empId}">
                                                selected
                                            </c:if>>
												<c:out value="${emp.empId}" /> -
												<c:out value="${emp.employeeName}" />
											</option>

										</c:forEach>
									</select>
								</div>

								<!-- 지급 연월 -->
								<div class="salary-field">
									<label for="salaryYearMonth">지급 연월 *</label> <input
										type="month" id="salaryYearMonth" name="salaryYearMonth"
										class="salary-form-input"
										value="<c:out value='${salaryCreateRequest.salaryYearMonth}'/>"
										required>
								</div>

								<!-- 기본급 -->
								<div class="salary-field">
									<label for="baseSalary">기본급 *</label> <input type="number"
										id="baseSalary" name="baseSalary" class="salary-form-input"
										min="0" max="999999999999999" step="1" placeholder="기본급 입력"
										value="<c:out value='${salaryCreateRequest.baseSalary}'/>"
										required> <small>원 단위로 입력합니다.</small>
								</div>

								<!-- 수당 -->
								<div class="salary-field">
									<label for="bonus">수당 *</label> <input type="number" id="bonus"
										name="bonus" class="salary-form-input" min="0"
										max="999999999999999" step="1"
										value="<c:out value='${salaryCreateRequest.bonus}'/>" required>

									<small>수당이 없으면 0원을 입력합니다.</small>
								</div>

								<!-- 공제액 -->
								<div class="salary-field">
									<label for="deduction">공제액 *</label> <input type="number"
										id="deduction" name="deduction" class="salary-form-input"
										min="0" max="999999999999999" step="1"
										value="<c:out value='${salaryCreateRequest.deduction}'/>"
										required> <small>공제액이 없으면 0원을 입력합니다.</small>
								</div>

								<!-- 지급일 -->
								<div class="salary-field">
									<label for="paymentDate">지급일</label> <input type="date"
										id="paymentDate" name="paymentDate" class="salary-form-input"
										value="<c:out value='${salaryCreateRequest.paymentDate}'/>">

									<small>미정인 경우 비워둘 수 있습니다.</small>
								</div>

							</div>

							<div class="salary-preview">
								<div>
									<span>예상 실수령액</span> <small>기본급 + 수당 - 공제액</small>
								</div>
								<strong id="netSalaryPreview">0원</strong>
							</div>

							<p id="salaryValidationMessage" class="salary-validation-message"
								role="alert"></p>

						</div>

						<div class="salary-form-actions">
							<a href="${pageContext.request.contextPath}/salary/list"
								class="salary-cancel-btn">취소</a>

							<button type="button" id="salaryReviewBtn"
								class="salary-confirm-btn">급여 검토</button>
						</div>

					</form>

				</div>
			</section>
		</div>
	</div>

	<!-- 최종 등록 확인 팝업 -->
	<div id="salaryModal" class="salary-modal-overlay" hidden>

		<div class="salary-modal" role="dialog" aria-modal="true"
			aria-labelledby="salaryModalTitle">

			<span class="salary-modal-badge">최종 검토</span>

			<h2 id="salaryModalTitle">급여를 등록하시겠습니까?</h2>
			<p>아래 계산 결과와 지급 정보를 확인해 주세요.</p>

			<div class="salary-modal-summary">
				<div>
					<span>대상 사원</span><strong id="reviewEmployee"></strong>
				</div>
				<div>
					<span>지급 연월</span><strong id="reviewMonth"></strong>
				</div>
				<div>
					<span>기본급</span><strong id="reviewBase"></strong>
				</div>
				<div>
					<span>수당</span><strong id="reviewBonus"></strong>
				</div>
				<div>
					<span>공제액</span><strong id="reviewDeduction"></strong>
				</div>
				<div>
					<span>지급일</span><strong id="reviewDate"></strong>
				</div>
			</div>

			<div class="salary-modal-total">
				<span>실수령액</span> <strong id="reviewNet"></strong>
			</div>

			<div class="salary-modal-actions">
				<button type="button" id="salaryBackBtn" class="salary-cancel-btn">돌아가기</button>

				<button type="button" id="salarySubmitBtn"
					class="salary-confirm-btn">등록 확정</button>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

	<script>
const salaryForm = document.getElementById("salaryCreateForm");
const salaryModal = document.getElementById("salaryModal");
const validationMessage = document.getElementById("salaryValidationMessage");

const baseInput = document.getElementById("baseSalary");
const bonusInput = document.getElementById("bonus");
const deductionInput = document.getElementById("deduction");

const money = value => Number(value).toLocaleString("ko-KR") + "원";

function getAmount(input) {
    return input.value.trim() === "" ? NaN : Number(input.value);
}

function calculateNet() {
    const base = getAmount(baseInput);
    const bonus = getAmount(bonusInput);
    const deduction = getAmount(deductionInput);

    if (![base, bonus, deduction].every(Number.isSafeInteger) ||
        [base, bonus, deduction].some(v => v < 0 || v > 999999999999999)) {
        return null;
    }

    const net = base + bonus - deduction;
    return Number.isSafeInteger(net) &&
           Math.abs(net) <= 999999999999999 ? net : null;
}

function updatePreview() {
    const net = calculateNet();

    document.getElementById("netSalaryPreview").textContent =
        net === null ? "입력값 확인 필요" : money(net);
}

[baseInput, bonusInput, deductionInput].forEach(input => {
    input.addEventListener("input", updatePreview);
});

document.getElementById("salaryReviewBtn").addEventListener("click", () => {

    validationMessage.textContent = "";

    if (!salaryForm.reportValidity()) {
        return;
    }

    const net = calculateNet();

    if (net === null) {
        validationMessage.textContent =
            "금액은 0 이상의 15자리 이내 정수로 입력하고, 계산 결과도 확인해 주세요.";
        return;
    }

    const employeeSelect = document.getElementById("empId");

    document.getElementById("reviewEmployee").textContent =
        employeeSelect.options[employeeSelect.selectedIndex].text.trim();

    document.getElementById("reviewMonth").textContent =
        document.getElementById("salaryYearMonth").value;

    document.getElementById("reviewBase").textContent =
        money(getAmount(baseInput));

    document.getElementById("reviewBonus").textContent =
        money(getAmount(bonusInput));

    document.getElementById("reviewDeduction").textContent =
        money(getAmount(deductionInput));

    document.getElementById("reviewDate").textContent =
        document.getElementById("paymentDate").value || "미정";

    document.getElementById("reviewNet").textContent = money(net);

    salaryModal.hidden = false;
});

document.getElementById("salaryBackBtn").addEventListener("click", () => {
    salaryModal.hidden = true;
});

document.getElementById("salarySubmitBtn").addEventListener("click", event => {

    if (!salaryForm.reportValidity() || calculateNet() === null) {
        salaryModal.hidden = true;
        return;
    }

    event.currentTarget.disabled = true;
    event.currentTarget.textContent = "등록 중...";

    salaryForm.submit();
});

updatePreview();
</script>

</body>
</html>
