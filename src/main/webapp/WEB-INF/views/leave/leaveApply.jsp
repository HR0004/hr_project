<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>휴가 신청</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 휴가 신청 화면 전용 스타일: 기존 화면에 영향이 없도록 la- 접두어 사용 */
.la-page, .la-page * {
	box-sizing: border-box
}

.la-page {
	width: 100%;
    max-width: 1540px;
    margin: 0 auto;
    padding: 8px 50px 30px;
}

.la-page h1, .la-page h2, .la-page p {
	margin: 0
}

.la-heading {
	font-size: 20px;
	font-weight: 700;
	line-height: 1.5
}

.la-subheading {
	margin-top: 4px !important;
	color: #7d8ba1;
	font-size: 13px
}

.la-card {
	margin-top: 22px;
	border: 1px solid #dfe6ef;
	background: #fff
}

.la-card-header {
	min-height: 69px;
	padding: 23px 33px 20px;
	border-bottom: 1px solid #dfe6ef
}

.la-card-title {
	font-size: 16px;
	font-weight: 700
}

.la-card-body {
	padding: 28px 43px 0
}

.la-field {
	margin-bottom: 30px
}

.la-label {
	display: block;
	margin-bottom: 13px;
	color: #172033;
	font-size: 13px;
	font-weight: 500
}

.la-required {
	color: #be3033;
	font-weight: 700
}

.la-select-wrap {
	position: relative;
	max-width: 600px
}

.la-select-wrap:after {
	content: "";
	position: absolute;
	right: 20px;
	top: 18px;
	width: 10px;
	height: 10px;
	border-right: 1.5px solid #65748c;
	border-bottom: 1.5px solid #65748c;
	transform: rotate(45deg);
	pointer-events: none
}

.la-input, .la-select, .la-textarea {
	display: block;
	width: 100%;
	background: #fff;
	border: 1px solid #dfe6ef;
	border-radius: 0;
	font: inherit;
	color: #172033;
	outline: none
}

.la-input:focus, .la-select:focus, .la-textarea:focus {
	border-color: #8295b2;
	box-shadow: 0 0 0 2px rgba(130, 149, 178, .12)
}

.la-input, .la-select {
	height: 50px;
	padding: 0 19px
}

.la-select {
	appearance: none;
	-webkit-appearance: none;
	padding-right: 46px;
	cursor: pointer
}

.la-select:invalid {
	color: #7d8ba1
}

.la-input:disabled {
	background: #f6f8fb;
	color: #7d8ba1
}

.la-input::-webkit-calendar-picker-indicator {
	cursor: pointer;
	opacity: .6
}

.la-date-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 58px;
	max-width: 1160px
}

.la-radio-field {
	margin-top: 1px;
	margin-bottom: 29px
}

.la-radios {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: 74px;
	padding: 5px 0 0 5px
}

.la-radio-option {
	display: inline-flex;
	align-items: center;
	gap: 11px;
	font-weight: 400;
	cursor: pointer
}

.la-radio-option input {
	accent-color: #111a2f;
	width: 18px;
	height: 18px;
	margin: 0;
	cursor: pointer
}

.la-reason-field {
	margin-bottom: 0
}

.la-textarea-box {
	position: relative
}

.la-textarea {
	height: 152px;
	min-height: 152px;
	resize: vertical;
	padding: 16px 19px 36px
}

.la-textarea::placeholder {
	color: #96a5bb
}

.la-count {
	position: absolute;
	right: 17px;
	bottom: 13px;
	color: #92a0b6;
	font-size: 12px;
	background: #fff;
	padding-left: 6px
}

.la-notice {
	margin: 26px 0 18px !important;
	color: #74839c;
	font-size: 12px
}

.la-card-footer {
	margin-left: -10px;
	margin-right: -10px;
	margin-top: 16px;
	border-top: 1px solid #dfe6ef;
	min-height: 63px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 18px;
	padding: 20px 0 0
}

.la-btn {
	min-width: 101px;
	height: 45px;
	padding: 0 20px;
	border: 1px solid #dfe6ef;
	border-radius: 0;
	background: #fff;
	color: #172033;
	font: inherit;
	cursor: pointer
}

.la-btn:hover {
	background: #f6f8fb
}

.la-btn-primary {
	background: #111a2f;
	color: #fff;
	border-color: #111a2f
}

.la-btn-primary:hover {
	background: #27344d
}

@media ( max-width :800px) {
	.la-page {
		padding: 18px 20px 35px
	}
	.la-card-header {
		padding: 20px
	}
	.la-card-body {
		padding: 22px 20px 0
	}
	.la-date-grid {
		gap: 18px
	}
	.la-radios {
		gap: 22px
	}
}

@media ( max-width :560px) {
	.la-page {
		padding: 16px 14px 30px
	}
	.la-date-grid {
		grid-template-columns: 1fr;
		gap: 0
	}
	.la-field {
		margin-bottom: 22px
	}
	.la-radios {
		gap: 15px
	}
	.la-card-footer {
		padding-top: 16px
	}
}
/* 전체 레이아웃 래퍼 */
.page-wrapper {
	display: flex;
	width: 100%;
	min-height: 100vh;
	position: relative;
}

/* 사이드바 영역 자체의 고정 너비 확보 (보통 AdminLTE 기반 사이드바는 250px 사용) */
.page-wrapper>aside {
	width: 250px;
	flex-shrink: 0;
}

/* 우측 본문 영역: 사이드바 공간을 제외한 나머지를 꽉 채우도록 설정 */
.main-content {
	display: flex;
    flex-direction: column;
    flex: 1;
    min-width: 0;
    width: auto;
    background: #fff;
    overflow-x: hidden;
    padding-top: 0;
}
</style>
</head>
<body>
	<div class="page-wrapper">

		<%@ include file="../common/sidebar.jspf"%>

		<div class="main-content main-area">
			<%@ include file="../common/header.jspf"%>
			<main class="la-page">
				<h1 class="la-heading">휴가 신청</h1>
				<p class="la-subheading">휴가 종류와 기간을 입력하여 휴가를 신청합니다.</p>
				<section class="la-card" aria-labelledby="laFormTitle">
					<div class="la-card-header">
						<h2 class="la-card-title" id="laFormTitle">휴가 신청서</h2>
					</div>
					<form id="leaveApplyForm" name="leaveApplyForm" novalidate>
						<div class="la-card-body">

							<div class="la-date-grid">
								<div class="la-field">
									<label class="la-label" for="leaveStartDate">시작일 <span
										class="la-required">*</span></label> <input type="date"
										id="leaveStartDate" name="startDate" class="la-input" required>
								</div>
								<div class="la-field">
									<label class="la-label" for="leaveEndDate">종료일 <span
										class="la-required">*</span></label> <input type="date"
										id="leaveEndDate" name="endDate" class="la-input" required>
								</div>
							</div>
							<div class="la-field la-radio-field">
								<span class="la-label" id="halfDayLabel">반차 여부 <span
									class="la-required">*</span></span>
								<div class="la-radios" role="radiogroup"
									aria-labelledby="halfDayLabel">
									<label class="la-radio-option"><input type="radio"
										name="halfDayType" value="FULL" checked>종일</label> <label
										class="la-radio-option"><input type="radio"
										name="halfDayType" value="AM">오전 반차</label> <label
										class="la-radio-option"><input type="radio"
										name="halfDayType" value="PM">오후 반차</label>
								</div>
							</div>
							<div class="la-field la-reason-field">
								<label class="la-label" for="leaveReason">신청 사유 <span
									class="la-required">*</span></label>
								<div class="la-textarea-box">
									<textarea id="leaveReason" name="reason" class="la-textarea"
										maxlength="50" placeholder="휴가 신청 사유를 입력하세요" required></textarea>
									<span class="la-count" name="reasonCount">0 / 500</span>
								</div>
							</div>
							<p class="la-notice">※ 신청한 휴가는 관리자 승인 후 확정되며, 승인 결과는 나의 휴가 신청
								내역에서 확인할 수 있습니다.</p>
							<div class="la-card-footer">
								<button type="button" class="la-btn" name="cancelButton">취소</button>
								<button type="submit" class="la-btn la-btn-primary"
									name="applyButton">신청</button>
							</div>
						</div>
					</form>
				</section>
			</main>
		</div>
	</div>
	<!-- 공통 헤더/사이드바를 제외한 화면 본문 -->

	<script>
$(function () {
	const contextPath = "${pageContext.request.contextPath}";

    // 신청 사유 글자 수 표시
    $("textarea[name='reason']").on("input", function () {
        $("span[name='reasonCount']").text($(this).val().length + " / 500");
    });

    // 종료일은 시작일보다 빠를 수 없음
    $("input[name='startDate']").on("change", function () {
        const startDate = $(this).val();
        const endDate = $("input[name='endDate']");
        endDate.attr("min", startDate || null);
        if (startDate && endDate.val() && endDate.val() < startDate) endDate.val(startDate);
        if ($("input[name='halfDayType']:checked").val() !== "FULL") endDate.val(startDate);
    });

    // 반차는 시작일과 종료일이 같아야 함
    $("input[name='halfDayType']").on("change", function () {
        const halfDay = $(this).val() !== "FULL";
        const endDate = $("input[name='endDate']");
        if (halfDay) endDate.val($("input[name='startDate']").val());
        endDate.prop("disabled", halfDay);
    });

    $("button[name='cancelButton']").on("click", function () {
        window.location.href = contextPath + "/leave";
    });

    // 저장 API 미구현: 입력 검증만 수행하며 DB에는 저장하지 않음

 // 휴가 신청 DB 저장
 $("#leaveApplyForm").on("submit", async function(event) {

     event.preventDefault();

     const startDate = $("input[name='startDate']").val();

     const halfDayType =
         $("input[name='halfDayType']:checked").val();

     const endDate = halfDayType === "FULL"
         ? $("input[name='endDate']").val()
         : startDate;

     const reason =
         $("textarea[name='reason']").val().trim();

     if (!startDate || !endDate) {
         alert("휴가 기간을 선택하세요.");
         return;
     }

     if (endDate < startDate) {
         alert("종료일을 확인하세요.");
         return;
     }

     if (!reason || reason.length > 50) {
         alert("신청 사유를 1~50자로 입력하세요.");
         return;
     }

     const button = $("button[name='applyButton']");

     if (button.prop("disabled")) {
         return;
     }

     button.prop("disabled", true);

     try {

         const response = await fetch(
             contextPath + "/api/leave/my/requests",
             {
                 method: "POST",
                 headers: {
                     "Content-Type": "application/json"
                 },
                 body: JSON.stringify({
                     startDate: startDate,
                     endDate: endDate,
                     halfDayType: halfDayType,
                     reason: reason
                 })
             }
         );

         if (!response.ok) {
             throw new Error(
                 "신청 실패 (HTTP " + response.status + ")"
             );
         }

         alert("휴가 신청이 완료되었습니다.");

         window.location.href =
             contextPath + "/leave/history";

     } catch (error) {

         console.error(error);
         alert(error.message);

     } finally {

         button.prop("disabled", false);

     }

 });

});
</script>
</body>
</html>
