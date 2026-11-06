<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ì§ì í´ê° ì ì²­ ê´ë¦¬</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* ê´ë¦¬ì í´ê° ê´ë¦¬ íë©´ ì ì©. ê³µíµ ì¬ì´ëë° CSSë¥¼ ë³ê²½íì§ ììµëë¤. */
.alr-content-area {
	margin-left: 250px;
	min-width: 0;
	background: #fff;
}

.sidebar-collapse .alr-content-area {
	margin-left: 74px;
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

			<section class="alr-panel alr-filter"
				aria-label="í´ê° ì ì²­ ê²ì ì¡°ê±´">
				<div class="alr-field">
					<label for="alrStartDate">ì ì²­ ììì¼</label><input
						id="alrStartDate" name="startDate" type="date" value="2026-10-01">
				</div>
				<div class="alr-field">
					<label for="alrEndDate">ì ì²­ ì¢ë£ì¼</label><input
						id="alrEndDate" name="endDate" type="date" value="2026-11-30">
				</div>
				<div class="alr-field">
					<label for="alrStatus">ì²ë¦¬ ìí</label> <select id="alrStatus"
						name="statusFilter"><option value="ALL">ì ì²´</option>
						<option value="PENDING">ì¹ì¸ ëê¸°</option>
						<option value="APPROVED">ì¹ì¸ ìë£</option>
						<option value="REJECTED">ë°ë ¤</option></select>
				</div>
				<div class="alr-field alr-grow">
					<label for="alrKeyword">ì¬ì ê²ì</label><input id="alrKeyword"
						name="keyword" type="search" placeholder="ì´ë¦ ëë ì¬ë²">
				</div>
				<div class="alr-actions">
					<button class="alr-btn alr-btn-primary" type="button"
						name="searchLeaveRequests">ì¡°í</button>
					<button class="alr-btn" type="button" name="resetLeaveRequests">ì´ê¸°í</button>
				</div>
			</section>

			<section class="alr-stats" aria-label="í´ê° ì ì²­ ì§ê³">
				<div class="alr-stat">
					<div class="alr-stat-label">ì ì²´ ì ì²­</div>
					<div class="alr-stat-value" name="allCount">0ê±´</div>
				</div>
				<div class="alr-stat">
					<div class="alr-stat-label">ì¹ì¸ ëê¸°</div>
					<div class="alr-stat-value" name="pendingCount">0ê±´</div>
				</div>
				<div class="alr-stat">
					<div class="alr-stat-label">ì¹ì¸ ìë£</div>
					<div class="alr-stat-value" name="approvedCount">0ê±´</div>
				</div>
				<div class="alr-stat">
					<div class="alr-stat-label">ë°ë ¤</div>
					<div class="alr-stat-value" name="rejectedCount">0ê±´</div>
				</div>
			</section>

			<section class="alr-panel" aria-label="ì§ì í´ê° ì ì²­ ëª©ë¡">
				<div class="alr-panel-head">
					<h2 class="alr-section-title">í´ê° ì ì²­ ëª©ë¡</h2>
					<div class="alr-count" name="resultCount">ì´ 0ê±´</div>
				</div>
				<div class="alr-scroll">
					<table class="alr-table">
						<thead>
							<tr>
								<th>ì ì²­ì¼</th>
								<th>ì¬ë² / ì´ë¦</th>
								<th>ì¬ì© ê¸°ê°</th>
								<th>ì ì²­ ì¼ì</th>
								<th>ì ì²­ ì¬ì </th>
								<th>ì²ë¦¬ ìí</th>
								<th>ê´ë¦¬</th>
							</tr>
						</thead>
						<tbody name="leaveRequestRows"></tbody>
					</table>
				</div>
				<div class="alr-footer">â» ìí íë©´ìëë¤.
					ì¹ì¸Â·ë°ë ¤ë ë°±ìë ê¶í ê²ì¦ ë° ì²ë¦¬ API ì°ê²° í
					ì¬ì©í  ì ììµëë¤.</div>
			</section>
		</main>
	</div>

	<!-- ìì¸ ì ë³´ íì -->
	<div class="alr-overlay" name="leaveDetailOverlay" role="dialog"
		aria-modal="true" aria-labelledby="alrDetailTitle">
		<div class="alr-dialog">
			<div class="alr-dialog-head">
				<h2 id="alrDetailTitle">í´ê° ì ì²­ ìì¸</h2>
				<button type="button" class="alr-close" name="closeLeaveDetail"
					aria-label="ë«ê¸°">Ã</button>
			</div>
			<dl class="alr-detail" name="leaveDetailContent"></dl>
			<div class="alr-dialog-bottom">
				<button type="button" class="alr-btn" name="closeLeaveDetail">ë«ê¸°</button>
			</div>
		</div>
	</div>
	<script>
// ê°ë°ì© ìì. ì¤ì  êµ¬íììë REST API ìëµì¼ë¡ êµì²´í©ëë¤.
const adminLeaveDemo = [
    {requestId:101, empId:1, empName:"ê¹ë¯¼ì¤", department:"ê°ë°í", requestDate:"2026-11-05", startDate:"2026-11-17", endDate:"2026-11-18", days:2, reason:"ê°ì¸ ì¼ì ", status:"PENDING"},
    {requestId:102, empId:4, empName:"ì´ìì°", department:"ê°ë°í", requestDate:"2026-11-04", startDate:"2026-11-12", endDate:"2026-11-12", days:0.5, reason:"ì¤ì  ë³ì ì§ë£", status:"PENDING"},
    {requestId:103, empId:7, empName:"ë°ì§í", department:"ê°ë°í", requestDate:"2026-11-03", startDate:"2026-11-10", endDate:"2026-11-10", days:1, reason:"ê°ì¡± íì¬ ì°¸ì", status:"APPROVED"},
    {requestId:104, empId:9, empName:"ìµì ì§", department:"ê°ë°í", requestDate:"2026-10-29", startDate:"2026-11-06", endDate:"2026-11-07", days:2, reason:"ê°ì¸ ì¬ì ", status:"REJECTED"},
    {requestId:105, empId:11, empName:"ì ëí", department:"ê°ë°í", requestDate:"2026-10-27", startDate:"2026-11-21", endDate:"2026-11-21", days:1, reason:"ì°ì°¨ ì¬ì©", status:"APPROVED"},
    {requestId:106, empId:13, empName:"íì§ë¯¼", department:"ê°ë°í", requestDate:"2026-10-20", startDate:"2026-10-24", endDate:"2026-10-24", days:1, reason:"ê°ì¸ ì¼ì ", status:"APPROVED"}
];
const adminLeaveStatusText = {PENDING:"ì¹ì¸ ëê¸°", APPROVED:"ì¹ì¸ ìë£", REJECTED:"ë°ë ¤"};
const adminLeaveStatusClass = {PENDING:"alr-pill-pending", APPROVED:"alr-pill-approved", REJECTED:"alr-pill-rejected"};

const displayLeaveRequests = function() {
    const start = $("input[name='startDate']").val();
    const end = $("input[name='endDate']").val();
    const status = $("select[name='statusFilter']").val();
    const keyword = $("input[name='keyword']").val().trim().toLowerCase();
    if (start && end && start > end) { alert("ì ì²­ ì¢ë£ì¼ì ììì¼ë³´ë¤ ë¹ ë¥¼ ì ììµëë¤."); return; }

    const rows = adminLeaveDemo.filter(function(item) {
        return (!start || item.requestDate >= start) && (!end || item.requestDate <= end)
            && (status === "ALL" || item.status === status)
            && (!keyword || item.empName.toLowerCase().includes(keyword) || String(item.empId).includes(keyword));
    }).sort(function(a,b) { return b.requestDate.localeCompare(a.requestDate); });
    const $body = $("tbody[name='leaveRequestRows']").empty();
    $("div[name='allCount']").text(rows.length + "ê±´");
    $("div[name='pendingCount']").text(rows.filter(r => r.status === "PENDING").length + "ê±´");
    $("div[name='approvedCount']").text(rows.filter(r => r.status === "APPROVED").length + "ê±´");
    $("div[name='rejectedCount']").text(rows.filter(r => r.status === "REJECTED").length + "ê±´");
    $("div[name='resultCount']").text("ì´ " + rows.length + "ê±´");
    if (rows.length === 0) {
        $body.append($("<tr>").append($("<td>", {colspan:7, "class":"alr-empty", text:"ì¡°íë í´ê° ì ì²­ì´ ììµëë¤."})));
        return;
    }
    rows.forEach(function(item) {
        const $tr = $("<tr>");
        $tr.append($("<td>").text(item.requestDate));
        $tr.append($("<td>").text(item.empId + " / " + item.empName));
        $tr.append($("<td>").text(item.startDate + (item.startDate === item.endDate ? "" : " ~ " + item.endDate)));
        $tr.append($("<td>").text(item.days + "ì¼"));
        $tr.append($("<td>", {"class":"alr-ellipsis", title:item.reason}).text(item.reason));
        $tr.append($("<td>").append($("<span>", {"class":"alr-pill " + adminLeaveStatusClass[item.status], text:adminLeaveStatusText[item.status]})));
        const $actions = $("<div>", {"class":"alr-row-actions"});
        $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small", text:"ìì¸", "data-id":item.requestId, "data-action":"detail"}));
        if (item.status === "PENDING") {
            $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small alr-btn-primary", text:"ì¹ì¸", "data-id":item.requestId, "data-action":"approve"}));
            $actions.append($("<button>", {type:"button", "class":"alr-btn alr-btn-small", text:"ë°ë ¤", "data-id":item.requestId, "data-action":"reject"}));
        }
        $tr.append($("<td>").append($actions));
        $body.append($tr);
    });
};
const showLeaveDetail = function(id) {
    const item = adminLeaveDemo.find(row => row.requestId === id);
    if (!item) return;
    const details = [
        ["ì ì²­ ë²í¸", item.requestId], ["ì¬ì", item.empName + " (" + item.empId + ")"],
        ["ìì ë¶ì", item.department], ["ì ì²­ì¼", item.requestDate],
        ["ì¬ì© ê¸°ê°", item.startDate + " ~ " + item.endDate], ["ì¬ì© ì¼ì", item.days + "ì¼"],
        ["ì ì²­ ì¬ì ", item.reason], ["ì²ë¦¬ ìí", adminLeaveStatusText[item.status]]
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
        // ì¹ì¸Â·ë°ë ¤ë ì¤ì  ìë² ê²ì¦ê³¼ DB í¸ëì­ìì´ íìí©ëë¤. íë©´ììë§ ì±ê³µ ì²ë¦¬íì§ ììµëë¤.
        alert((action === "approve" ? "ì¹ì¸" : "ë°ë ¤") + " ê¸°ë¥ì ìì§ DBì ì°ê²°ëì§ ìììµëë¤. íë©´ ìììëë¤.");
    });
    $("button[name='closeLeaveDetail']").on("click", function() { $("div[name='leaveDetailOverlay']").removeClass("alr-open"); });
    $("div[name='leaveDetailOverlay']").on("click", function(e) { if (e.target === this) $(this).removeClass("alr-open"); });
    $(document).on("keydown", function(e) { if (e.key === "Escape") $("div[name='leaveDetailOverlay']").removeClass("alr-open"); });
});
</script>
</body>
</html>
