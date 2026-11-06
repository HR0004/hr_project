<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>나의 월별 근태 성적</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>
/* 월별 근태 성적 화면 전용 스타일 */
.ma-page, .ma-page * {
	box-sizing: border-box;
}

.ma-page {
	width: 100%;
    min-height: 0;
    padding: 21px 32px 60px 22px;
}

.ma-page h2, .ma-page h3, .ma-page p {
	margin: 0;
}

.ma-head {
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	gap: 20px;
}

.ma-title {
	font-size: 20px;
	font-weight: 750;
	line-height: 1.5;
}

.ma-subtitle {
	margin-top: 7px !important;
	font-size: 13px;
	line-height: 1.5;
	color: #7786a0;
}

.ma-search-controls {
	display: flex;
	gap: 10px;
	flex-shrink: 0;
	margin-top: 2px;
}

.ma-month-select, .ma-search-button {
	height: 46px;
	border: 1px solid #dfe7f1;
	border-radius: 7px;
	background: white;
	font-family: inherit;
	font-size: 13px;
	color: #1c2637;
}

.ma-month-select {
	width: 202px;
	padding: 0 20px;
	cursor: pointer;
}

.ma-search-button {
	width: 192px;
	cursor: pointer;
	transition: background .15s;
}

.ma-search-button:hover {
	background: #f5f7fa;
}

.ma-month-select:focus-visible, .ma-search-button:focus-visible {
	outline: 2px solid #6d8bb6;
	outline-offset: 2px;
}

/* 상단 근태 통계 카드 */
.ma-stats {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 34px;
	width: calc(100% - 41px);
	margin-top: 22px;
}

.ma-stat-card {
	min-height: 117px;
	padding: 19px 22px;
	border: 1px solid #e0e8f2;
	border-radius: 9px;
	background: #fff;
}

.ma-stat-label {
	color: #7585a0;
	font-size: 13px;
	line-height: 1.5;
}

.ma-stat-value {
	margin-top: 13px;
	font-size: 23px;
	font-weight: 750;
	line-height: 1.35;
	white-space: nowrap;
}

/* 월별 근태 요약 */
.ma-section-head {
	margin-top: 29px;
}

.ma-section-title {
	font-size: 17px;
	font-weight: 750;
	line-height: 1.5;
}

.ma-section-subtitle {
	margin-top: 3px !important;
	font-size: 13px;
	color: #7686a1;
	line-height: 1.6;
}

.ma-table-scroll {
	margin-top: 21px;
	overflow-x: auto;
}

.ma-table {
	width: 100%;
	min-width: 870px;
	border-collapse: separate;
	border-spacing: 0;
	table-layout: fixed;
	font-size: 13px;
}

.ma-table thead th {
	height: 54px;
	padding: 0 17px;
	background: #f0f3f7;
	text-align: left;
	color: #243044;
	font-weight: 700;
	border-bottom: 1px solid #e0e8f0;
}

.ma-table thead th:first-child {
	border-top-left-radius: 5px;
}

.ma-table thead th:last-child {
	border-top-right-radius: 5px;
}

.ma-table tbody td {
	height: 62px;
	padding: 0 17px;
	background: #fff;
	border-top: 0;
	border-bottom: 1px solid #e1e8f1;
	color: #202b3d;
	white-space: nowrap;
}

.ma-table tbody td:first-child {
	border-left: 1px solid #e1e8f1;
}

.ma-table tbody td:last-child {
	border-right: 1px solid #e1e8f1;
}

.ma-table tbody tr:last-child td:first-child {
	border-bottom-left-radius: 4px;
}

.ma-table tbody tr:last-child td:last-child {
	border-bottom-right-radius: 4px;
}

.ma-table tbody tr:hover td {
	background: #fafcff;
}

.ma-status-pending {
	color: #dd7016;
}

.ma-status-completed {
	color: #178a43;
}

.ma-empty {
	height: 83px !important;
	text-align: center;
	color: #78869b !important;
}

.ma-notice {
	margin-top: 12px !important;
	color: #8390a3;
	font-size: 12px;
}

@media ( max-width : 1050px) {
	.ma-stats {
		gap: 14px;
		width: 100%;
	}
	.ma-stat-card {
		padding: 18px 14px;
	}
	.ma-stat-value {
		font-size: 19px;
	}
}

@media ( max-width : 720px) {
	.ma-page {
		padding: 17px 14px 36px;
	}
	.ma-head {
		flex-direction: column;
	}
	.ma-search-controls {
		width: 100%;
	}
	.ma-month-select, .ma-search-button {
		width: 50%;
	}
	.ma-stats {
		grid-template-columns: repeat(2, minmax(0, 1fr));
	}
	.ma-stat-value {
		font-size: 18px;
		white-space: normal;
	}
	.ma-section-head {
		margin-top: 25px;
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
<body style="margin: 0;">

	<div class="page-wrapper">

		<%@ include file="../common/sidebar.jspf"%>

		<div class="main-content main-area">
		
			<%@ include file="../common/header.jspf" %>
			
			<main class="ma-page">
				<header class="ma-head">
					<div>
						<h2 class="ma-title">나의 월별 근태 성적</h2>
						<p class="ma-subtitle">월별 총근일수, 지각·조퇴, 결근 및 연장근무 현황을 확인할 수
							있습니다.</p>
					</div>
					<div class="ma-search-controls">
						<select class="ma-month-select" name="selectedMonth"
							aria-label="조회할 월 선택">
							<option value="2026-12">2026년 12월</option>
							<option value="2026-11">2026년 11월</option>
							<option value="2026-10" selected>2026년 10월</option>
							<option value="2026-09">2026년 09월</option>
							<option value="2026-08">2026년 08월</option>
							<option value="2026-07">2026년 07월</option>
							<option value="2026-06">2026년 06월</option>
							<option value="2026-05">2026년 05월</option>
							<option value="2026-04">2026년 04월</option>
							<option value="2026-03">2026년 03월</option>
							<option value="2026-02">2026년 02월</option>
							<option value="2026-01">2026년 01월</option>
						</select>
						<button type="button" class="ma-search-button"
							name="moveAttendanceButton">근태 현황</button>
					</div>
				</header>

				<!-- 선택한 월의 근태 통계 -->
				<section class="ma-stats" aria-label="선택 월 근태 통계">
					<div class="ma-stat-card">
						<p class="ma-stat-label">총 출근일수</p>
						<div class="ma-stat-value" name="totalWorkDays">-</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">지각 · 조퇴</p>
						<div class="ma-stat-value" name="lateEarlyCount">-</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">결근일수</p>
						<div class="ma-stat-value" name="absentDays">-</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">총 연장근무시간</p>
						<div class="ma-stat-value" name="overtimeTotal">-</div>
					</div>
				</section>

				<section aria-label="월별 근태 요약">
					<div class="ma-section-head">
						<h3 class="ma-section-title">월별 근태 요약</h3>
						<p class="ma-section-subtitle">개인별 월간 근태 집계</p>
					</div>
					<div class="ma-table-scroll">
						<table class="ma-table">
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 15%;">
								<col style="width: 14%;">
								<col style="width: 14%;">
								<col style="width: 14%;">
								<col style="width: 17%;">
								<col style="width: 11%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">대상 월</th>
									<th scope="col">총 출근일수</th>
									<th scope="col">지각 횟수</th>
									<th scope="col">조퇴 횟수</th>
									<th scope="col">결근일수</th>
									<th scope="col">총 연장근무시간</th>
									<th scope="col">정산 전송 상태</th>
								</tr>
							</thead>

							<tbody name="monthlyAttendanceRows">
								<tr>
									<td colspan="7" class="ma-empty">근태 데이터를 불러오는 중입니다.</td>
								</tr>
							</tbody>

						</table>
					</div>
				</section>
			</main>
		</div>
	</div>




	<script type="text/javascript">
		$(function() {

			const contextPath = "${pageContext.request.contextPath}";

			// 시연용 기본 퇴근 시각: 18:00
			const standardEndMinutes = 18 * 60;

			// 로그인한 사원의 근태 기록
			let attendanceRecords = [];

			// YYYY-MM 문자열 생성
			function monthKey(date) {
				return date.getFullYear() + "-"
						+ String(date.getMonth() + 1).padStart(2, "0");
			}

			// YYYY년 MM월 문자열 생성
			function monthLabel(month) {
				const parts = month.split("-");
				return parts[0] + "년 " + parts[1] + "월";
			}

			// 이번 달부터 지난 11개월까지 선택 목록 구성
			function initMonthSelect() {

				const select = $("select[name='selectedMonth']");
				const today = new Date();

				select.empty();

				for (let i = 0; i < 12; i++) {

					const date = new Date(today.getFullYear(), today.getMonth()
							- i, 1);

					const key = monthKey(date);

					$("<option>").val(key).text(monthLabel(key)).appendTo(
							select);
				}
			}

			// HH:mm 형식을 분으로 변환
			function toMinutes(time) {

				const match = String(time || "").match(/^(\d{1,2}):(\d{2})/);

				if (!match) {
					return null;
				}

				const hours = Number(match[1]);
				const minutes = Number(match[2]);

				if (hours > 23 || minutes > 59) {
					return null;
				}

				return hours * 60 + minutes;
			}

			// 분을 "N시간 N분"으로 표시
			function formatMinutes(total) {

				const hours = Math.floor(total / 60);
				const minutes = total % 60;

				return hours + "시간 " + minutes + "분";
			}

			// 해당 월의 실제 근태 통계 계산
			function calculateMonth(month) {

				const records = attendanceRecords.filter(function(row) {

					return String(row.workDate || "").startsWith(month);
				});

				// 날짜별 중복 기록 방지
				const byDate = new Map();

				records.forEach(function(row) {

					const date = String(row.workDate || "");
					const existing = byDate.get(date);

					if (!existing || (!existing.clockOut && row.clockOut)) {

						byDate.set(date, row);
					}
				});

				const rows = Array.from(byDate.values());

				let workDays = 0;
				let lateCount = 0;
				let earlyCount = 0;
				let absentCount = 0;
				let overtimeMinutes = 0;

				rows.forEach(function(row) {

					const status = String(row.status || "").toUpperCase();

					if (row.clockIn) {
						workDays++;
					}

					if (status === "LATE") {
						lateCount++;
					}

					if (status === "ABSENT") {
						absentCount++;
					}

					const clockOutMinutes = toMinutes(row.clockOut);

					if (clockOutMinutes !== null && row.clockIn) {

						if (clockOutMinutes < standardEndMinutes) {
							earlyCount++;
						}

						if (clockOutMinutes > standardEndMinutes) {

							overtimeMinutes += clockOutMinutes
									- standardEndMinutes;
						}
					}
				});

				return {
					month : month,
					recordCount : rows.length,
					workDays : workDays,
					late : lateCount,
					early : earlyCount,
					absent : absentCount,
					overtimeMinutes : overtimeMinutes
				};
			}

			// 상단 통계 카드 및 월별 근태 요약 출력
			function renderMonthlyAttendance() {

				const selectedMonth = $("select[name='selectedMonth']").val();

				if (!selectedMonth) {
					return;
				}

				const summary = calculateMonth(selectedMonth);

				$("div[name='totalWorkDays']").text(summary.workDays + "일");

				$("div[name='lateEarlyCount']").text(
						"지각 " + summary.late + "회 / 조퇴 " + summary.early + "회");

				// 결근은 현재 별도 집계 기능이 없으므로
				// 명시적인 ABSENT 기록이 있을 때만 표시
				$("div[name='absentDays']").text(
						summary.absent > 0 ? summary.absent + "일" : "미집계");

				$("div[name='overtimeTotal']").text(
						formatMinutes(summary.overtimeMinutes));

				const tbody = $("tbody[name='monthlyAttendanceRows']");

				tbody.empty();

				const parts = selectedMonth.split("-");
				const year = Number(parts[0]);
				const month = Number(parts[1]);

				let displayed = 0;

				// 선택 월을 포함한 최근 6개월
				for (let i = 0; i < 6; i++) {

					const date = new Date(year, month - 1 - i, 1);
					const key = monthKey(date);

					const row = calculateMonth(key);

					// DB에 기록이 없는 월은 건너뛰기
					if (row.recordCount === 0) {
						continue;
					}

					const tr = $("<tr>");

					$("<td>").text(monthLabel(row.month)).appendTo(tr);

					$("<td>").text(row.workDays + "일").appendTo(tr);

					$("<td>").text(row.late + "회").appendTo(tr);

					$("<td>").text(row.early + "회").appendTo(tr);

					$("<td>").text(row.absent > 0 ? row.absent + "일" : "미집계")
							.appendTo(tr);

					$("<td>").text(formatMinutes(row.overtimeMinutes))
							.appendTo(tr);

					// DB에 정산 전송 상태가 없으므로 임의 표시 금지
					$("<td>").text("미연동").appendTo(tr);

					tbody.append(tr);

					displayed++;
				}

				if (displayed === 0) {

					$("<tr>").append(
							$("<td>").attr("colspan", 7).addClass("ma-empty")
									.text("해당 기간의 근태 기록이 없습니다.")).appendTo(
							tbody);
				}
			}

			// 로그인한 사원의 실제 근태 기록 API 조회
			async function loadAttendance() {

				try {

					const response = await
					fetch(contextPath + "/api/attendance/my", {
						method : "GET"
					});

					if (!response.ok) {
						throw new Error("근태 조회 실패: " + response.status);
					}

					const result = await
					response.json();

					if (!Array.isArray(result)) {
						throw new Error("근태 조회 응답 형식 오류");
					}

					console.log("나의 근태 기록:", result);

					attendanceRecords = result;

					renderMonthlyAttendance();

				} catch (error) {

					console.error("월별 근태 조회 오류:", error);

					$("div[name='totalWorkDays']").text("-");
					$("div[name='lateEarlyCount']").text("-");
					$("div[name='absentDays']").text("-");
					$("div[name='overtimeTotal']").text("-");

					$("tbody[name='monthlyAttendanceRows']").empty().append(
							$("<tr>").append(
									$("<td>").attr("colspan", 7).addClass(
											"ma-empty").text(
											"근태 기록을 불러오지 못했습니다.")));
				}
			}

			// 월 변경 시 화면 다시 계산
			$("select[name='selectedMonth']").on("change",
					renderMonthlyAttendance);

			// 근태 현황 페이지 이동
			$("button[name='moveAttendanceButton']").on("click", function() {

				window.location.href = contextPath + "/attendance";
			});

			// 처음 페이지 열릴 때
			initMonthSelect();
			loadAttendance();

		});
	</script>

</body>
</html>
