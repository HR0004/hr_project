<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>직원 휴가 신청 관리</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
.main-content.main-area {
    display: flex;
    flex-direction: column;
    min-width: 0;
    width: auto;
    min-height: 100vh;
    background: #fff;
}

/* 관리자 휴가 관리 화면 전용 스타일. 공통 사이드바와 별도로 사용합니다. */
.alr-content-area {
	flex: 1;
	width: 100%;
	min-width: 0;
	background: #fff;
}

.alr-page, .alr-page * {
	box-sizing: border-box;
}

.alr-page {
	min-height: 100vh;
	padding: 27px 34px 60px;
	background: #fff;
	color: #172238;
	font: 14px/1.55 "Pretendard", "Malgun Gothic", Arial, sans-serif;
}

.alr-page h1, .alr-page h2, .alr-page p {
	margin: 0;
}

.alr-heading {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	gap: 18px;
	align-items: start;
	margin-bottom: 25px;
}

.alr-title {
	font-size: 22px;
	font-weight: 750;
	letter-spacing: -.4px;
}

.alr-subtitle {
	font-size: 13px;
	color: #7c8aa1;
	margin-top: 5px !important;
}

.alr-demo {
	font-size: 12px;
	color: #68768b;
	border: 1px solid #dfe6f0;
	padding: 7px 11px;
	border-radius: 5px;
	background: #f8fafc;
}

.alr-panel {
	border: 1px solid #dfe6ef;
	background: #fff;
	border-radius: 7px;
}

.alr-filter {
	padding: 21px 24px;
	display: flex;
	gap: 14px;
	align-items: end;
	flex-wrap: wrap;
}

.alr-field {
	display: flex;
	flex-direction: column;
	gap: 7px;
	min-width: 145px;
}

.alr-field label {
	font-size: 12px;
	font-weight: 650;
	color: #596981;
}

.alr-field input, .alr-field select {
	border: 1px solid #dbe3ee;
	background: #fff;
	height: 40px;
	border-radius: 5px;
	padding: 0 12px;
	min-width: 0;
	color: #273347;
	font: inherit;
}

.alr-field input[type=date] {
	min-width: 152px;
}

.alr-field.alr-grow {
	flex: 1;
	min-width: 170px;
}

.alr-actions {
	display: flex;
	align-items: center;
	gap: 8px;
}

.alr-btn {
	min-height: 39px;
	padding: 0 15px;
	border: 1px solid #dce4ee;
	border-radius: 5px;
	color: #28344a;
	background: #fff;
	cursor: pointer;
	font: inherit;
	white-space: nowrap;
}

.alr-btn:hover {
	background: #f3f6fa;
}

.alr-btn-primary {
	color: #fff;
	background: #182238;
	border-color: #182238;
}

.alr-btn-primary:hover {
	background: #2b3a56;
}

.alr-btn-small {
	min-height: 31px;
	font-size: 12px;
	padding: 0 10px;
}

.alr-btn:focus-visible, .alr-field input:focus-visible, .alr-field select:focus-visible
	{
	outline: 2px solid #668bc6;
	outline-offset: 2px;
}

.alr-stats {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 17px;
	margin: 21px 0 27px;
}

.alr-stat {
	border: 1px solid #dfe6ef;
	border-radius: 7px;
	padding: 18px 20px;
	min-height: 102px;
}

.alr-stat-label {
	font-size: 12px;
	color: #7e8ba0;
}

.alr-stat-value {
	font-size: 26px;
	font-weight: 750;
	margin-top: 8px;
}

.alr-panel-head {
	padding: 19px 23px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 10px;
	border-bottom: 1px solid #e1e7ef;
}

.alr-section-title {
	font-size: 16px;
	font-weight: 750;
}

.alr-count {
	font-size: 12px;
	color: #75849b;
}

.alr-scroll {
	overflow-x: auto;
}

.alr-table {
	border-collapse: collapse;
	width: 100%;
	min-width: 940px;
	font-size: 13px;
}

.alr-table thead {
	background: #f4f6f9;
}

.alr-table th {
	text-align: left;
	padding: 14px 15px;
	font-weight: 650;
	color: #4e5e75;
	white-space: nowrap;
	border-bottom: 1px solid #dfe6ef;
}

.alr-table td {
	padding: 15px;
	border-bottom: 1px solid #e9edf3;
	vertical-align: middle;
}

.alr-table tbody tr:hover {
	background: #fafbfc;
}

.alr-table tbody tr:last-child td {
	border-bottom: 0;
}

.alr-table .alr-ellipsis {
	max-width: 210px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.alr-pill {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 99px;
	font-size: 12px;
	font-weight: 600;
	white-space: nowrap;
}

.alr-pill-pending {
	color: #a76a10;
	background: #fff3de;
}

.alr-pill-approved {
	color: #18744a;
	background: #e7f5ec;
}

.alr-pill-rejected {
	color: #a83f43;
	background: #fceced;
}

.alr-row-actions {
	display: flex;
	flex-wrap: nowrap;
	gap: 6px;
}

.alr-empty {
	text-align: center;
	color: #8a95a7;
	padding: 42px 15px !important;
}

.alr-footer {
	padding: 15px 23px;
	color: #8b97a8;
	font-size: 12px;
	border-top: 1px solid #e8ecf2;
}

.alr-overlay {
	position: fixed;
	inset: 0;
	background: rgba(12, 19, 33, .47);
	z-index: 3000;
	display: none;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.alr-overlay.alr-open {
	display: flex;
}

.alr-dialog {
	background: #fff;
	width: min(100%, 540px);
	max-height: 90vh;
	overflow: auto;
	border-radius: 9px;
	box-shadow: 0 15px 60px #1114;
}

.alr-dialog-head {
	padding: 20px 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #e1e7ef;
}

.alr-dialog-head h2 {
	font-size: 18px;
}

.alr-close {
	border: 0;
	background: transparent;
	font-size: 25px;
	cursor: pointer;
	color: #738097;
}

.alr-detail {
	padding: 22px 25px;
	display: grid;
	grid-template-columns: 110px 1fr;
	column-gap: 12px;
	row-gap: 16px;
	font-size: 13px;
}

.alr-detail dt {
	color: #8290a5;
}

.alr-detail dd {
	margin: 0;
	overflow-wrap: anywhere;
}

.alr-dialog-bottom {
	border-top: 1px solid #e1e7ef;
	padding: 14px 25px;
	display: flex;
	justify-content: end;
}

@media ( max-width :1050px) {
	.alr-stats {
		gap: 10px;
	}
	.alr-stat {
		padding: 15px;
	}
}

@media ( max-width :767px) {
	.alr-content-area, .sidebar-collapse .alr-content-area {
		margin-left: 0;
	}
	.alr-page {
		padding: 20px 15px 35px;
	}
	.alr-stats {
		grid-template-columns: repeat(2, minmax(0, 1fr));
	}
	.alr-filter {
		padding: 15px;
	}
	.alr-field {
		flex: 1;
	}
}
</style>
</head>
<body style="margin: 0;">
<<<<<<< HEAD:src/main/webapp/WEB-INF/views/leave/adminLeaveRequests.jsp
	<!-- íë©´ íì¸ì© ì¬ì´ëë° ìë¦¬. JSPììë íë¡ì í¸ì sidebar.jspfê° ì¬ì©ë©ëë¤. -->
	<aside
		style="position: fixed; top: 0; left: 0; bottom: 0; width: 250px; background: #172238; color: #c5d1e5; padding: 28px 19px; font: 14px Arial;">
		<div
			style="font-size: 19px; font-weight: bold; color: white; margin-bottom: 27px">HEXAGON
			HRMS</div>
		<div style="padding: 12px 8px; border-bottom: 1px solid #344058">ì¸ì¬
			ê´ë¦¬</div>
		<div style="padding: 12px 8px; border-bottom: 1px solid #344058">ê·¼í
			ê´ë¦¬</div>
		<div style="padding: 12px 8px; border-bottom: 1px solid #344058">í´ê°
			ê´ë¦¬</div>
		<div style="padding: 12px 8px; border-bottom: 1px solid #344058">ê´ë¦¬ì
			ë©ë´</div>
	</aside>
	<div class="alr-content-area">
		<main class="alr-page">
		
			<header class="alr-heading">
				<div>
					<h1 class="alr-title">ì§ì í´ê° ì ì²­ ê´ë¦¬</h1>
					<p class="alr-subtitle">ë´ë¹ ì§ìì í´ê° ì ì²­ì
						ì¡°ííê³  ì¹ì¸ ìíë¥¼ íì¸í©ëë¤.</p>
				</div>
				<span class="alr-demo">íë©´ ìì ë°ì´í° Â· DB
					ë¯¸ì°ê²°</span>
			</header>
=======
>>>>>>> origin/develop:src/main/webapp/WEB-INF/views/leave/adminleave.jsp

	<%@ include file="../common/sidebar.jspf"%>

	<div class="main-content main-area">
		<%@ include file="../common/header.jspf"%>

		<div class="alr-content-area">
			<main class="alr-page">
				<header class="alr-heading">
					<div>
						<h1 class="alr-title">직원 휴가 신청 관리</h1>
						<p class="alr-subtitle">담당 직원의 휴가 신청을 조회하고 승인 상태를 확인합니다.</p>
					</div>
					<span class="alr-demo">화면 예시 데이터 · DB 미연결</span>
				</header>
				<section class="alr-panel alr-filter" aria-label="휴가 신청 검색 조건">
					<div class="alr-field">
						<label for="alrStartDate">신청 시작일</label><input id="alrStartDate"
							name="startDate" type="date" value="2026-10-01">
					</div>
					<div class="alr-field">
						<label for="alrEndDate">신청 종료일</label><input id="alrEndDate"
							name="endDate" type="date" value="2026-11-30">
					</div>
					<div class="alr-field">
						<label for="alrStatus">처리 상태</label> <select id="alrStatus"
							name="statusFilter"><option value="ALL">전체</option>
							<option value="PENDING">승인 대기</option>
							<option value="APPROVED">승인 완료</option>
							<option value="REJECTED">반려</option></select>
					</div>
					<div class="alr-field alr-grow">
						<label for="alrKeyword">사원 검색</label><input id="alrKeyword"
							name="keyword" type="search" placeholder="이름 또는 사번">
					</div>
					<div class="alr-actions">
						<button class="alr-btn alr-btn-primary" type="button"
							name="searchLeaveRequests">조회</button>
						<button class="alr-btn" type="button" name="resetLeaveRequests">초기화</button>
					</div>
				</section>
				<section class="alr-stats" aria-label="휴가 신청 집계">
					<div class="alr-stat">
						<div class="alr-stat-label">전체 신청</div>
						<div class="alr-stat-value" name="allCount">0건</div>
					</div>
					<div class="alr-stat">
						<div class="alr-stat-label">승인 대기</div>
						<div class="alr-stat-value" name="pendingCount">0건</div>
					</div>
					<div class="alr-stat">
						<div class="alr-stat-label">승인 완료</div>
						<div class="alr-stat-value" name="approvedCount">0건</div>
					</div>
					<div class="alr-stat">
						<div class="alr-stat-label">반려</div>
						<div class="alr-stat-value" name="rejectedCount">0건</div>
					</div>
				</section>
				<section class="alr-panel" aria-label="직원 휴가 신청 목록">
					<div class="alr-panel-head">
						<h2 class="alr-section-title">휴가 신청 목록</h2>
						<div class="alr-count" name="resultCount">총 0건</div>
					</div>
					<div class="alr-scroll">
						<table class="alr-table">
							<thead>
								<tr>
									<th>신청일</th>
									<th>사번 / 이름</th>
									<th>사용 기간</th>
									<th>신청 일수</th>
									<th>신청 사유</th>
									<th>처리 상태</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody name="leaveRequestRows"></tbody>
						</table>
					</div>
					<div class="alr-footer">※ 샘플 화면입니다. 승인·반려는 백엔드 권한 검증 및 처리 API
						연결 후 사용할 수 있습니다.</div>
				</section>
			</main>
		</div>
	</div>
	<!-- 상세 정보 팝업 -->
	<div class="alr-overlay" name="leaveDetailOverlay" role="dialog"
		aria-modal="true" aria-labelledby="alrDetailTitle">
		<div class="alr-dialog">
			<div class="alr-dialog-head">
				<h2 id="alrDetailTitle">휴가 신청 상세</h2>
				<button type="button" class="alr-close" name="closeLeaveDetail"
					aria-label="닫기">×</button>
			</div>
			<dl class="alr-detail" name="leaveDetailContent"></dl>
			<div class="alr-dialog-bottom">
				<button type="button" class="alr-btn" name="closeLeaveDetail">닫기</button>
			</div>
		</div>
	</div>
	<script>
// 개발용 예시. 실제 구현에서는 REST API 응답으로 교체합니다.
const adminLeaveDemo = [
    {requestId:101, empId:1, empName:"김민준", department:"개발팀", requestDate:"2026-11-05", startDate:"2026-11-17", endDate:"2026-11-18", days:2, reason:"개인 일정", status:"PENDING"},
    {requestId:102, empId:4, empName:"이서연", department:"개발팀", requestDate:"2026-11-04", startDate:"2026-11-12", endDate:"2026-11-12", days:0.5, reason:"오전 병원 진료", status:"PENDING"},
    {requestId:103, empId:7, empName:"박지훈", department:"개발팀", requestDate:"2026-11-03", startDate:"2026-11-10", endDate:"2026-11-10", days:1, reason:"가족 행사 참석", status:"APPROVED"},
    {requestId:104, empId:9, empName:"최유진", department:"개발팀", requestDate:"2026-10-29", startDate:"2026-11-06", endDate:"2026-11-07", days:2, reason:"개인 사정", status:"REJECTED"},
    {requestId:105, empId:11, empName:"정도현", department:"개발팀", requestDate:"2026-10-27", startDate:"2026-11-21", endDate:"2026-11-21", days:1, reason:"연차 사용", status:"APPROVED"},
    {requestId:106, empId:13, empName:"한지민", department:"개발팀", requestDate:"2026-10-20", startDate:"2026-10-24", endDate:"2026-10-24", days:1, reason:"개인 일정", status:"APPROVED"}
];
const adminLeaveStatusText = {PENDING:"승인 대기", APPROVED:"승인 완료", REJECTED:"반려"};
const adminLeaveStatusClass = {PENDING:"alr-pill-pending", APPROVED:"alr-pill-approved", REJECTED:"alr-pill-rejected"};
const displayLeaveRequests = function() {
    const start = $("input[name='startDate']").val();
    const end = $("input[name='endDate']").val();
    const status = $("select[name='statusFilter']").val();
    const keyword = $("input[name='keyword']").val().trim().toLowerCase();
    if (start && end && start > end) { alert("신청 종료일은 시작일보다 빠를 수 없습니다."); return; }
    const rows = adminLeaveDemo.filter(function(item) {
        return (!start || item.requestDate >= start) && (!end || item.requestDate <= end)
            && (status === "ALL" || item.status === status)
            && (!keyword || item.empName.toLowerCase().includes(keyword) || String(item.empId).includes(keyword));
    }).sort(function(a,b) { return b.requestDate.localeCompare(a.requestDate); });
    const $body = $("tbody[name='leaveRequestRows']").empty();
    $("div[name='allCount']").text(rows.length + "건");
    $("div[name='pendingCount']").text(rows.filter(r => r.status === "PENDING").length + "건");
    $("div[name='approvedCount']").text(rows.filter(r => r.status === "APPROVED").length + "건");
    $("div[name='rejectedCount']").text(rows.filter(r => r.status === "REJECTED").length + "건");
    $("div[name='resultCount']").text("총 " + rows.length + "건");
    if (rows.length === 0) {
        $body.append($("<tr>").append($("<td>", {colspan:7, "class":"alr-empty", text:"조회된 휴가 신청이 없습니다."})));
        return;
    }
    rows.forEach(function(item) {
        const $tr = $("<tr>");
        $tr.append($("<td>").text(item.requestDate));
        $tr.append($("<td>").text(item.empId + " / " + item.empName));
        $tr.append($("<td>").text(item.startDate + (item.startDate === item.endDate ? "" : " ~ " + item.endDate)));
        $tr.append($("<td>").text(item.days + "일"));
        $tr.append($("<td>", {"class":"alr-ellipsis", title:item.reason}).text(item.reason));
        $tr.append($("<td>").append($("<span>", {"class":"alr-pill " + adminLeaveStatusClass[item.status], text:adminLeaveStatusText[item.status]})));
        const $actions = $("<div>", {"class":"alr-row-actions"});
        $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small", text:"상세", "data-id":item.requestId, "data-action":"detail"}));
        if (item.status === "PENDING") {
            $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small alr-btn-primary", text:"승인", "data-id":item.requestId, "data-action":"approve"}));
            $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small", text:"반려", "data-id":item.requestId, "data-action":"reject"}));
        }
        $tr.append($("<td>").append($actions));
        $body.append($tr);
    });
};
const showLeaveDetail = function(id) {
    const item = adminLeaveDemo.find(row => row.requestId === id);
    if (!item) return;
    const details = [
        ["신청 번호", item.requestId], ["사원", item.empName + " (" + item.empId + ")"],
        ["소속 부서", item.department], ["신청일", item.requestDate],
        ["사용 기간", item.startDate + " ~ " + item.endDate], ["사용 일수", item.days + "일"],
        ["신청 사유", item.reason], ["처리 상태", adminLeaveStatusText[item.status]]
    ];
    const $content = $("dl[name='leaveDetailContent']").empty();
    details.forEach(function(pair) {
        $content.append($("<dt>").text(pair[0]));
        $content.append($("<dd>").text(pair[1]));
    });
    $("div[name='leaveDetailOverlay']").addClass("alr-open");
};
$(function() {
    displayLeaveRequests();
    $("button[name='searchLeaveRequests']").on("click", displayLeaveRequests);
    $("button[name='resetLeaveRequests']").on("click", function() {
        $("input[name='startDate']").val("2026-10-01");
        $("input[name='endDate']").val("2026-11-30");
        $("select[name='statusFilter']").val("ALL");
        $("input[name='keyword']").val("");
        displayLeaveRequests();
    });
    $("input[name='keyword']").on("keydown", function(e) { if (e.key === "Enter") displayLeaveRequests(); });
    $("tbody[name='leaveRequestRows']").on("click", "button[data-action]", function() {
        const action = $(this).attr("data-action");
        const id = Number($(this).attr("data-id"));
        if (action === "detail") { showLeaveDetail(id); return; }
        // 승인·반려는 실제 서버 검증과 DB 트랜잭션이 필요합니다. 화면에서만 성공 처리하지 않습니다.
        alert((action === "approve" ? "승인" : "반려") + " 기능은 아직 DB에 연결되지 않았습니다. 화면 예시입니다.");
    });
    $("button[name='closeLeaveDetail']").on("click", function() { $("div[name='leaveDetailOverlay']").removeClass("alr-open"); });
    $("div[name='leaveDetailOverlay']").on("click", function(e) { if (e.target === this) $(this).removeClass("alr-open"); });
    $(document).on("keydown", function(e) { if (e.key === "Escape") $("div[name='leaveDetailOverlay']").removeClass("alr-open"); });
});
</script>
</body>
</html>
