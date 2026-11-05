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
	min-height: 100vh;
	padding: 21px 32px 60px 22px;
	border-top: 2px solid #edf1f6;
	background: #fff;
	color: #141c2d;
	font-family: "Pretendard", "Malgun Gothic", Arial, sans-serif;
	font-size: 14px;
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
	flex: 1;
	width: calc(100% - 250px);
	background: #fff;
	overflow-x: hidden;
	padding-top: 20px; /* 상단 여백이 필요하면 조절 */
}
</style>
</head>
<body style="margin: 0;">

	<div class="page-wrapper">

		<%@ include file="../common/sidebar.jspf"%>

		<div class="main-content main-area">
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
						<div class="ma-stat-value" name="totalWorkDays">21일</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">지각 · 조퇴</p>
						<div class="ma-stat-value" name="lateEarlyCount">지각 1회 / 조퇴
							1회</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">결근일수</p>
						<div class="ma-stat-value" name="absentDays">0일</div>
					</div>
					<div class="ma-stat-card">
						<p class="ma-stat-label">총 연장근무시간</p>
						<div class="ma-stat-value" name="overtimeTotal">6시간 20분</div>
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
								<!-- 최초 표시 예시. 조회 버튼을 누르면 아래 JavaScript가 이 목록을 갱신함. -->
								<tr>
									<td>2026년 10월</td>
									<td>21일</td>
									<td>1회</td>
									<td>1회</td>
									<td>0일</td>
									<td>6시간 20분</td>
									<td><span class="ma-status-pending">전송 대기</span></td>
								</tr>
								<tr>
									<td>2026년 09월</td>
									<td>20일</td>
									<td>0회</td>
									<td>0회</td>
									<td>0일</td>
									<td>4시간 10분</td>
									<td><span class="ma-status-completed">전송 완료</span></td>
								</tr>
								<tr>
									<td>2026년 08월</td>
									<td>22일</td>
									<td>2회</td>
									<td>0회</td>
									<td>0일</td>
									<td>8시간 30분</td>
									<td><span class="ma-status-completed">전송 완료</span></td>
								</tr>
								<tr>
									<td>2026년 07월</td>
									<td>21일</td>
									<td>1회</td>
									<td>1회</td>
									<td>1일</td>
									<td>3시간 45분</td>
									<td><span class="ma-status-completed">전송 완료</span></td>
								</tr>
								<tr>
									<td>2026년 06월</td>
									<td>22일</td>
									<td>0회</td>
									<td>0회</td>
									<td>0일</td>
									<td>5시간 00분</td>
									<td><span class="ma-status-completed">전송 완료</span></td>
								</tr>
								<tr>
									<td>2026년 05월</td>
									<td>19일</td>
									<td>1회</td>
									<td>0회</td>
									<td>1일</td>
									<td>2시간 15분</td>
									<td><span class="ma-status-completed">전송 완료</span></td>
								</tr>
							</tbody>
						</table>
					</div>
				</section>
			</main>
		</div>
	</div>



	<script type="text/javascript">
		const contextPath = "";
		// 현재는 Figma 화면과 동일한 샘플 데이터.
		// 실제 DB 연결 시 이 배열 대신 REST API 응답을 사용하면 됨.
		const monthlyAttendanceDemo = [ {
			month : "2026-10",
			workDays : 21,
			late : 1,
			early : 1,
			absent : 0,
			overtime : "6시간 20분",
			status : "전송 대기"
		}, {
			month : "2026-09",
			workDays : 20,
			late : 0,
			early : 0,
			absent : 0,
			overtime : "4시간 10분",
			status : "전송 완료"
		}, {
			month : "2026-08",
			workDays : 22,
			late : 2,
			early : 0,
			absent : 0,
			overtime : "8시간 30분",
			status : "전송 완료"
		}, {
			month : "2026-07",
			workDays : 21,
			late : 1,
			early : 1,
			absent : 1,
			overtime : "3시간 45분",
			status : "전송 완료"
		}, {
			month : "2026-06",
			workDays : 22,
			late : 0,
			early : 0,
			absent : 0,
			overtime : "5시간 00분",
			status : "전송 완료"
		}, {
			month : "2026-05",
			workDays : 19,
			late : 1,
			early : 0,
			absent : 1,
			overtime : "2시간 15분",
			status : "전송 완료"
		} ];

		const monthLabel = function(month) {
			const parts = month.split("-");
			return parts[0] + "년 " + parts[1] + "월";
		};

		// 선택한 월 및 그 이전 최대 5개월의 요약을 표시
		const getMonthlyAttendance = function() {
			const selectedMonth = $("select[name='selectedMonth']").val();
			const target = monthlyAttendanceDemo.find(function(row) {
				return row.month === selectedMonth;
			});

			if (target) {
				$("div[name='totalWorkDays']").text(target.workDays + "일");
				$("div[name='lateEarlyCount']").text(
						"지각 " + target.late + "회 / 조퇴 " + target.early + "회");
				$("div[name='absentDays']").text(target.absent + "일");
				$("div[name='overtimeTotal']").text(target.overtime);
			} else {
				$("div[name='totalWorkDays']").text("-");
				$("div[name='lateEarlyCount']").text("-");
				$("div[name='absentDays']").text("-");
				$("div[name='overtimeTotal']").text("-");
			}

			const parts = selectedMonth.split("-");
			const endDate = new Date(Number(parts[0]), Number(parts[1]) - 1, 1);
			const startDate = new Date(endDate.getFullYear(), endDate
					.getMonth() - 5, 1);
			const startKey = startDate.getFullYear() + "-"
					+ String(startDate.getMonth() + 1).padStart(2, "0");

			const rows = monthlyAttendanceDemo.filter(function(row) {
				return row.month >= startKey && row.month <= selectedMonth;
			}).sort(function(a, b) {
				return b.month.localeCompare(a.month);
			});

			const $tbody = $("tbody[name='monthlyAttendanceRows']");
			$tbody.empty();
			if (rows.length === 0) {
				$tbody.append($("<tr>").append($("<td>", {
					"class" : "ma-empty",
					"colspan" : 7,
					"text" : "해당 기간의 근태 데이터가 없습니다."
				})));
				return;
			}
			rows.forEach(function(row) {
				const $tr = $("<tr>");
				$tr.append($("<td>").text(monthLabel(row.month)));
				$tr.append($("<td>").text(row.workDays + "일"));
				$tr.append($("<td>").text(row.late + "회"));
				$tr.append($("<td>").text(row.early + "회"));
				$tr.append($("<td>").text(row.absent + "일"));
				$tr.append($("<td>").text(row.overtime));
				const $status = $("<span>", {
					"class" : row.status === "전송 완료" ? "ma-status-completed"
							: "ma-status-pending",
					"text" : row.status
				});
				$tr.append($("<td>").append($status));
				$tbody.append($tr);
			});
		};

		$(function() {
			$("button[name='moveAttendanceButton']").on("click", function() {
				//getMonthlyAttendance();
				window.location.href = contextPath + "/attendance";
			});
		});
	</script>
</body>
</html>
