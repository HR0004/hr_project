<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>휴가 신청 현황</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 휴가 신청 내역 전용 스타일: lh- 접두어 사용 */
.lh-page, .lh-page * {
	box-sizing: border-box
}

.lh-page {
	width: 100%;
    max-width: 1540px;
    margin: 0 auto;
    padding: 8px 49px 35px;
}

.lh-page h1, .lh-page h2, .lh-page p {
	margin: 0
}

.lh-heading {
	font-size: 20px;
	font-weight: 700;
	line-height: 1.5
}

.lh-caption {
	margin-top: 4px !important;
	color: #7d8ba1;
	font-size: 13px
}

.lh-filter-panel {
	margin-top: 21px;
	min-height: 105px;
	border: 1px solid #dfe6ef;
	padding: 20px 33px 15px;
	display: flex;
	align-items: end;
	justify-content: space-between;
	gap: 20px
}

.lh-filter-controls {
	display: flex;
	align-items: end;
	gap: 33px;
	flex-wrap: wrap
}

.lh-filter-title {
	display: block;
	font-weight: 500;
	margin-bottom: 9px;
	font-size: 13px
}

.lh-date-range {
	display: flex;
	align-items: center;
	gap: 14px
}

.lh-date-separator {
	color: #6d7e96
}

.lh-input, .lh-select {
	height: 40px;
	border: 1px solid #dfe6ef;
	border-radius: 0;
	background: #fff;
	font: inherit;
	color: #172033;
	outline: none;
	padding: 0 16px
}

.lh-input {
	width: 222px
}

.lh-input::-webkit-calendar-picker-indicator {
	opacity: .55;
	cursor: pointer
}

.lh-select-wrap {
	position: relative
}

.lh-select-wrap:after {
	content: "";
	position: absolute;
	right: 17px;
	top: 12px;
	width: 9px;
	height: 9px;
	border-right: 1.5px solid #62738d;
	border-bottom: 1.5px solid #62738d;
	transform: rotate(45deg);
	pointer-events: none
}

.lh-select {
	min-width: 192px;
	appearance: none;
	-webkit-appearance: none;
	padding-right: 42px
}

.lh-input:focus, .lh-select:focus {
	border-color: #8295b2
}

.lh-apply-btn {
	width: 141px;
	height: 45px;
	border: 1px solid #111a2f;
	background: #111a2f;
	color: #fff;
	font: inherit;
	cursor: pointer;
	white-space: nowrap;
	margin-bottom: 4px
}

.lh-apply-btn:hover {
	background: #26334d
}

.lh-card {
	margin-top: 23px;
	border: 1px solid #dfe6ef;
	background: #fff
}

.lh-card-head {
	min-height: 59px;
	padding: 18px 33px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #dfe6ef
}

.lh-card-title {
	font-size: 16px;
	font-weight: 700
}

.lh-count {
	font-size: 12px;
	color: #7d8ba1
}

.lh-table-scroll {
	width: 100%;
	overflow-x: auto
}

.lh-table {
	border-collapse: collapse;
	width: 100%;
	min-width: 980px;
	font-size: 13px
}

.lh-table thead {
	background: #f5f7fa
}

.lh-table th {
	text-align: left;
	font-weight: 700;
	height: 54px;
	padding: 13px 33px;
	white-space: nowrap;
	border-bottom: 1px solid #dfe6ef
}

.lh-table td {
	height: 68px;
	padding: 16px 33px;
	border-bottom: 1px solid #e2e8f1;
	vertical-align: middle;
	white-space: nowrap
}

.lh-table th:nth-child(1) {
	width: 12%
}

.lh-table th:nth-child(2) {
	width: 11%
}

.lh-table th:nth-child(3) {
	width: 22%
}

.lh-table th:nth-child(4) {
	width: 8%
}

.lh-table th:nth-child(5) {
	width: 17%
}

.lh-table th:nth-child(6) {
	width: 17%
}

.lh-table th:nth-child(7) {
	width: 13%
}

.lh-status {
	display: inline-block;
	text-align: center;
	min-width: 93px;
	padding: 5px 9px;
	border: 1px solid #e1e8f1;
	border-radius: 3px;
	background: #f0f3f7;
	color: #41536e;
	font-size: 12px
}

.lh-remark {
	color: #6d7e96
}

.lh-detail-btn {
	padding: 6px 2px;
	border: 0;
	background: transparent;
	color: #172033;
	font: inherit;
	cursor: pointer
}

.lh-detail-btn:hover {
	text-decoration: underline
}

.lh-empty {
	text-align: center !important;
	color: #7d8ba1
}

.lh-card-bottom {
	height: 131px;
	display: flex;
	align-items: end;
	justify-content: space-between;
	padding: 0 34px 33px
}

.lh-footer-count {
	color: #8190a7;
	font-size: 12px;
	margin-bottom: 9px
}

.lh-pagination {
	display: flex;
	align-items: center;
	gap: 4px
}

.lh-page-btn {
	width: 35px;
	height: 37px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background: #fff;
	border: 1px solid #dfe6ef;
	color: #52617b;
	cursor: pointer;
	font: inherit
}

.lh-page-btn.is-current {
	background: #f0f3f7;
	color: #172033
}

.lh-page-btn:disabled {
	opacity: .55;
	cursor: default
}

.lh-modal-overlay {
	display: none;
	position: fixed;
	inset: 0;
	z-index: 1050;
	background: rgba(17, 26, 47, .38);
	padding: 24px;
	align-items: center;
	justify-content: center
}

.lh-modal-overlay.is-open {
	display: flex
}

.lh-modal {
	max-width: 510px;
	width: 100%;
	background: #fff;
	border: 1px solid #dfe6ef;
	padding: 26px;
	box-shadow: 0 15px 50px rgba(12, 20, 36, .15)
}

.lh-modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-bottom: 15px;
	border-bottom: 1px solid #dfe6ef
}

.lh-modal-header h2 {
	font-size: 17px
}

.lh-modal-close {
	border: 0;
	background: transparent;
	font-size: 24px;
	line-height: 1;
	cursor: pointer;
	color: #5c6b82
}

.lh-modal-data {
	display: grid;
	grid-template-columns: 120px 1fr;
	gap: 13px;
	margin-top: 23px
}

.lh-modal-data dt {
	font-weight: 500;
	color: #7d8ba1
}

.lh-modal-data dd {
	margin: 0;
	white-space: normal;
	overflow-wrap: anywhere
}

.lh-modal-footer {
	text-align: right;
	margin-top: 26px
}

.lh-modal-ok {
	width: 90px;
	height: 39px;
	border: 0;
	background: #111a2f;
	color: white;
	cursor: pointer
}

@media ( max-width :1000px) {
	.lh-page {
		padding: 18px 20px 35px
	}
	.lh-filter-panel {
		align-items: stretch;
		flex-direction: column
	}
	.lh-filter-controls {
		gap: 16px
	}
	.lh-apply-btn {
		margin-left: auto
	}
	.lh-card-head {
		padding: 18px 22px
	}
	.lh-card-bottom {
		padding: 0 22px 28px
	}
}

@media ( max-width :600px) {
	.lh-page {
		padding: 16px 14px 30px
	}
	.lh-filter-panel {
		padding: 18px
	}
	.lh-date-range {
		gap: 6px
	}
	.lh-input {
		width: calc(( 100vw - 90px)/2);
		min-width: 0;
		font-size: 12px;
		padding: 0 8px
	}
	.lh-select {
		width: 100%
	}
	.lh-status-filter {
		width: 100%
	}
	.lh-filter-controls {
		display: block
	}
	.lh-filter-field {
		margin-bottom: 14px
	}
	.lh-apply-btn {
		width: 100%
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

		<!-- 공통 헤더/사이드바를 제외한 화면 본문 -->
		<div class="main-content main-area">
		
			<%@ include file="../common/header.jspf"%>
			<main class="lh-page">
				<h1 class="lh-heading">휴가 신청 내역</h1>
				<p class="lh-caption">신청한 휴가의 기간과 승인 상태를 확인할 수 있습니다.</p>

				<section class="lh-filter-panel" aria-label="휴가 신청 내역 검색 조건">
					<div class="lh-filter-controls">
						<div class="lh-filter-field">
							<label class="lh-filter-title" for="filterStartDate">신청
								기간</label>
							<div class="lh-date-range">
								<input type="date" class="lh-input" id="filterStartDate"
									name="filterStartDate" aria-label="신청 시작일"> <span
									class="lh-date-separator">~</span> <input type="date"
									class="lh-input" id="filterEndDate" name="filterEndDate"
									aria-label="신청 종료일">
							</div>
						</div>
						<div class="lh-filter-field lh-status-filter">
							<label class="lh-filter-title" for="filterStatus">승인 상태</label>
							<div class="lh-select-wrap">
								<select class="lh-select" id="filterStatus" name="filterStatus">
									<option value="ALL">전체</option>
									<option value="APPROVED">승인 완료</option>
									<option value="PENDING">승인 대기</option>
									<option value="REJECTED">반려</option>
									<option value="CANCELED">취소됨</option>
								</select>
							</div>
						</div>
					</div>
					<button type="button" class="lh-apply-btn" name="moveViewButton">휴가
						목록</button>
					<button type="button" class="lh-apply-btn" name="moveApplyButton">휴가
						신청</button>
				</section>

				<section class="lh-card" aria-labelledby="lhHistoryTitle">
					<div class="lh-card-head">
						<h2 class="lh-card-title" id="lhHistoryTitle">신청 내역</h2>
						<span class="lh-count" name="historyCount">총 0건</span>
					</div>
					<div class="lh-table-scroll">
						<table class="lh-table">
							<thead>
								<tr>
									<th scope="col">신청일</th>
									<th scope="col">휴가 종류</th>
									<th scope="col">휴가 기간</th>
									<th scope="col">일수</th>
									<th scope="col">승인 상태</th>
									<th scope="col">비고</th>
									<th scope="col">관리</th>
								</tr>
							</thead>
							<!-- 아래 5건은 Figma 시안의 예시 데이터. REST 조회 연결 시 교체 -->

							<tbody name="historyRows">
							</tbody>

							<tbody>
								<tr id="historyEmptyRow" style="display: none">
									<td colspan="7" class="lh-empty">검색 결과가 없습니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="lh-card-bottom">
						<span class="lh-footer-count" name="historyFooterCount">총
							0건</span>
						<nav class="lh-pagination" aria-label="페이지 이동">
							<button type="button" class="lh-page-btn" name="previousPage"
								aria-label="이전 페이지">‹</button>
							<span name="pageNumbers" class="lh-pagination"></span>
							<button type="button" class="lh-page-btn" name="nextPage"
								aria-label="다음 페이지">›</button>
						</nav>
					</div>
				</section>
			</main>

			<!-- 상세 버튼 클릭 시 보여주는 예시 상세 창 -->
			<div class="lh-modal-overlay" id="leaveDetailOverlay"
				role="presentation">
				<section class="lh-modal" role="dialog" aria-modal="true"
					aria-labelledby="leaveDetailTitle">
					<div class="lh-modal-header">
						<h2 id="leaveDetailTitle">휴가 신청 상세</h2>
						<button type="button" class="lh-modal-close" name="closeDetail"
							aria-label="닫기">×</button>
					</div>
					<dl class="lh-modal-data">
						<dt>신청일</dt>
						<dd name="detailSubmitted">-</dd>
						<dt>휴가 종류</dt>
						<dd name="detailType">-</dd>
						<dt>휴가 기간</dt>
						<dd name="detailPeriod">-</dd>
						<dt>사용 일수</dt>
						<dd name="detailDays">-</dd>
						<dt>승인 상태</dt>
						<dd name="detailStatus">-</dd>
						<dt>비고</dt>
						<dd name="detailRemark">-</dd>
					</dl>
					<div class="lh-modal-footer">
						<button type="button" class="lh-modal-ok" name="closeDetail">닫기</button>
					</div>
				</section>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			const contextPath = "${pageContext.request.contextPath}";
			const pageSize = 5;

			let allRows = [];
			let filteredRows = [];

			let currentPage = 1;
			let lastDetailButton = null;

			// 로그인한 사원의 휴가 신청 내역 조회
			async function loadHistory() {

				try {

					const response = await
					fetch(contextPath + "/api/leave/my/requests", {
						method : "GET"
					});

					if (!response.ok) {
						throw new Error("휴가 신청 내역 조회 실패: " + response.status);
					}

					const records = await
					response.json();

					if (!Array.isArray(records)) {
						throw new Error("서버 응답 형식이 올바르지 않습니다.");
					}

					console.log("휴가 신청 내역 조회 결과", records);

					const tbody = $("tbody[name='historyRows']");
					tbody.empty();

					// 승인 상태를 한글로 변환
					const statusNames = {
						APPROVED : "승인 완료",
						PENDING : "승인 대기",
						REJECTED : "반려",
						CANCELED : "취소됨"
					};

					// DB에서 가져온 기록을 테이블에 추가
					records.forEach(function(row) {

						const submitted = row.submittedDate || "-";
						const startDate = row.startDate || "-";
						const endDate = row.endDate || "-";

						const period = startDate === endDate ? startDate
								: startDate + " ~ " + endDate;

						const leaveType = row.leaveType || "휴가";
						const days = row.days != null ? row.days + "일" : "-";
						const status = statusNames[row.status] || row.status
								|| "-";
						const remark = row.remark || "-";

						const tr = $("<tr>");

						tr.attr("data-submitted", submitted);
						tr.attr("data-status", row.status || "");

						$("<td>").text(submitted).appendTo(tr);
						$("<td>").text(leaveType).appendTo(tr);
						$("<td>").text(period).appendTo(tr);
						$("<td>").text(days).appendTo(tr);

						const statusTd = $("<td>");

						$("<span>").addClass("lh-status").text(status)
								.appendTo(statusTd);

						tr.append(statusTd);

						$("<td>").addClass("lh-remark").text(remark).appendTo(
								tr);

						const detailTd = $("<td>");

						$("<button>").attr("type", "button").attr("name",
								"detailButton").addClass("lh-detail-btn").text(
								"상세").appendTo(detailTd);

						tr.append(detailTd);
						tbody.append(tr);

					});

					// 실제 DB 데이터로 목록 갱신
					allRows = tbody.children("tr").toArray();

					$("#historyEmptyRow td").text("검색 결과가 없습니다.");

					filterHistory();

				} catch (error) {

					console.error("휴가 신청 내역 조회 오류", error);

					allRows = [];
					filteredRows = [];

					$("tbody[name='historyRows']").empty();

					$("#historyEmptyRow td").text("휴가 신청 내역을 불러오지 못했습니다.");

					renderHistory();

				}

			}

			function renderHistory() {
				const total = filteredRows.length;
				const totalPages = Math.max(1, Math.ceil(total / pageSize));
				currentPage = Math.max(1, Math.min(currentPage, totalPages));

				$("span[name='historyCount']").text("총 " + total + "건");
				$("span[name='historyFooterCount']").text("총 " + total + "건");
				$(allRows).hide();

				filteredRows.slice((currentPage - 1) * pageSize,
						currentPage * pageSize).forEach(function(row) {
					$(row).show();
				});
				$("#historyEmptyRow").toggle(total === 0);

				const pageNumberBox = $("span[name='pageNumbers']");
				pageNumberBox.empty();
				for (let page = 1; page <= totalPages; page++) {
					const button = $("<button>", {
						type : "button",
						"class" : "lh-page-btn"
								+ (page === currentPage ? " is-current" : ""),
						text : page,
						"aria-label" : page + "페이지",
						"aria-current" : page === currentPage ? "page" : null
					});
					button.on("click", function() {
						currentPage = page;
						renderHistory();
					});
					pageNumberBox.append(button);
				}
				$("button[name='previousPage']").prop("disabled",
						currentPage <= 1);
				$("button[name='nextPage']").prop("disabled",
						currentPage >= totalPages);
			}

			function filterHistory() {
				const startDate = $("input[name='filterStartDate']").val();
				const endDate = $("input[name='filterEndDate']").val();
				const status = $("select[name='filterStatus']").val();
				if (startDate && endDate && startDate > endDate) {
					alert("조회 종료일은 시작일보다 빠를 수 없습니다.");
					return;
				}
				// 현재는 Figma 예시 행을 필터링. REST API 연결 후 서버 데이터로 대체.
				filteredRows = allRows.filter(function(row) {
					const submitted = $(row).attr("data-submitted");
					const rowStatus = $(row).attr("data-status");
					return (!startDate || submitted >= startDate)
							&& (!endDate || submitted <= endDate)
							&& (status === "ALL" || status === rowStatus);
				});
				currentPage = 1;
				renderHistory();
			}

			$(
					"input[name='filterStartDate'], input[name='filterEndDate'], select[name='filterStatus']")
					.on("change", filterHistory);
			$("button[name='previousPage']").on("click", function() {
				if (currentPage > 1) {
					currentPage--;
					renderHistory();
				}
			});
			$("button[name='nextPage']").on("click", function() {
				if (currentPage < Math.ceil(filteredRows.length / pageSize)) {
					currentPage++;
					renderHistory();
				}
			});
			// 버튼 이동

			$("button[name='moveApplyButton']").on("click", function() {
				console.log("휴가 신청 버튼 클릭 성공");
				window.location.href = contextPath + "/leave/apply";
			});

			$("button[name='moveViewButton']").on("click", function() {
				console.log("휴가 목록 버튼 클릭 성공");
				window.location.href = contextPath + "/leave";
			});

			// .버튼 이용

			$("tbody[name='historyRows']").on(
					"click",
					"button[name='detailButton']",
					function() {

						lastDetailButton = this;
						const cells = $(this).closest("tr").children("td");
						$("dd[name='detailSubmitted']").text(
								$(cells[0]).text().trim());
						$("dd[name='detailType']").text(
								$(cells[1]).text().trim());
						$("dd[name='detailPeriod']").text(
								$(cells[2]).text().trim());
						$("dd[name='detailDays']").text(
								$(cells[3]).text().trim());
						$("dd[name='detailStatus']").text(
								$(cells[4]).text().trim());
						$("dd[name='detailRemark']").text(
								$(cells[5]).text().trim());
						$("#leaveDetailOverlay").addClass("is-open");
						$("button[name='closeDetail']").first()
								.trigger("focus");
					});

			function closeDetail() {
				$("#leaveDetailOverlay").removeClass("is-open");
				if (lastDetailButton)
					$(lastDetailButton).trigger("focus");
			}

			$("button[name='closeDetail']").on("click", closeDetail);

			$("#leaveDetailOverlay").on("click", function(event) {
				if (event.target === this)
					closeDetail();
			});
			$(document)
					.on(
							"keydown",
							function(event) {
								if (event.key === "Escape"
										&& $("#leaveDetailOverlay").hasClass(
												"is-open"))
									closeDetail();
							});

			loadHistory();

		});
	</script>
</body>
</html>
