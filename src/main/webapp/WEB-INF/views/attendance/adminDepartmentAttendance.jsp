<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ë¶ì ê·¼í íí©</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* ë¶ì ê·¼í ê´ë¦¬ì íë©´ ì ì©. ì¬ì´ëë°Â·ê³µíµ ë ì´ììì ìí¥ì ì£¼ì§ ììµëë¤. */
.dat-content-area {
	margin-left: 250px;
	min-width: 0;
	background: #fff;
}

.sidebar-collapse .dat-content-area {
	margin-left: 74px;
}

.dat-page, .dat-page * {
	box-sizing: border-box;
}

.dat-page {
	min-height: 100vh;
	padding: 27px 34px 60px;
	background: #fff;
	color: #172238;
	font: 14px/1.55 "Pretendard", "Malgun Gothic", Arial, sans-serif;
}

.dat-page h1, .dat-page h2, .dat-page p {
	margin: 0;
}

.dat-header {
	display: flex;
	flex-wrap: wrap;
	align-items: start;
	justify-content: space-between;
	gap: 15px;
	margin-bottom: 24px;
}

.dat-title {
	font-size: 22px;
	font-weight: 750;
	letter-spacing: -.4px;
}

.dat-subtitle {
	color: #7c8aa1;
	font-size: 13px;
	margin-top: 5px !important;
}

.dat-demo {
	font-size: 12px;
	color: #68768b;
	border: 1px solid #dfe6f0;
	padding: 7px 11px;
	border-radius: 5px;
	background: #f8fafc;
}

.dat-panel {
	border: 1px solid #dfe6ef;
	background: #fff;
	border-radius: 7px;
}

.dat-filter {
	padding: 21px 24px;
	display: flex;
	align-items: end;
	flex-wrap: wrap;
	gap: 14px;
}

.dat-field {
	display: flex;
	flex-direction: column;
	gap: 7px;
	min-width: 145px;
}

.dat-field label {
	font-size: 12px;
	font-weight: 650;
	color: #596981;
}

.dat-field input, .dat-field select {
	border: 1px solid #dbe3ee;
	border-radius: 5px;
	height: 40px;
	padding: 0 12px;
	font: inherit;
	background: #fff;
	color: #273347;
	min-width: 0;
}

.dat-field.dat-grow {
	flex: 1;
	min-width: 180px;
}

.dat-btn-row {
	display: flex;
	gap: 8px;
}

.dat-btn {
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

.dat-btn:hover {
	background: #f3f6fa;
}

.dat-btn-primary {
	background: #182238;
	color: #fff;
	border-color: #182238;
}

.dat-btn-primary:hover {
	background: #2b3a56;
}

.dat-btn-small {
	min-height: 31px;
	padding: 0 10px;
	font-size: 12px;
}

.dat-btn:focus-visible, .dat-field input:focus-visible, .dat-field select:focus-visible
	{
	outline: 2px solid #668bc6;
	outline-offset: 2px;
}

.dat-stats {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 17px;
	margin: 21px 0 27px;
}

.dat-stat {
	border: 1px solid #dfe6ef;
	border-radius: 7px;
	padding: 18px 20px;
	min-height: 102px;
}

.dat-stat-label {
	color: #7e8ba0;
	font-size: 12px;
}

.dat-stat-value {
	font-size: 26px;
	font-weight: 750;
	margin-top: 8px;
}

.dat-panel-head {
	border-bottom: 1px solid #e1e7ef;
	padding: 19px 23px;
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
	align-items: center;
	justify-content: space-between;
}

.dat-section-title {
	font-weight: 750;
	font-size: 16px;
}

.dat-count {
	font-size: 12px;
	color: #75849b;
}

.dat-scroll {
	overflow-x: auto;
}

.dat-table {
	width: 100%;
	min-width: 850px;
	border-collapse: collapse;
	font-size: 13px;
}

.dat-table thead {
	background: #f4f6f9;
}

.dat-table th {
	text-align: left;
	color: #4e5e75;
	font-weight: 650;
	border-bottom: 1px solid #dfe6ef;
	padding: 14px 16px;
	white-space: nowrap;
}

.dat-table td {
	padding: 16px;
	border-bottom: 1px solid #e9edf3;
	vertical-align: middle;
}

.dat-table tbody tr:hover {
	background: #fafbfc;
}

.dat-table tbody tr:last-child td {
	border-bottom: 0;
}

.dat-pill {
	display: inline-block;
	font-size: 12px;
	font-weight: 600;
	padding: 4px 10px;
	border-radius: 99px;
	white-space: nowrap;
}

.dat-pill-normal {
	color: #197849;
	background: #e7f5ec;
}

.dat-pill-late {
	color: #a66d14;
	background: #fff2da;
}

.dat-pill-early {
	color: #a66d14;
	background: #fff2da;
}

.dat-pill-leave {
	color: #3e67a1;
	background: #e8f0fc;
}

.dat-pill-unknown {
	color: #6b7485;
	background: #eff1f4;
}

.dat-empty {
	text-align: center;
	color: #8290a5;
	padding: 43px 16px !important;
}

.dat-footer {
	border-top: 1px solid #e8ecf2;
	padding: 15px 23px;
	color: #8793a5;
	font-size: 12px;
}

.dat-overlay {
	position: fixed;
	inset: 0;
	background: rgba(12, 19, 33, .47);
	z-index: 3000;
	display: none;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.dat-overlay.dat-open {
	display: flex;
}

.dat-dialog {
	background: #fff;
	border-radius: 9px;
	max-height: 90vh;
	overflow: auto;
	width: min(100%, 510px);
	box-shadow: 0 15px 60px #1114;
}

.dat-dialog-head {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #e1e7ef;
	padding: 20px 25px;
}

.dat-dialog-head h2 {
	font-size: 18px;
}

.dat-close {
	border: 0;
	background: transparent;
	cursor: pointer;
	color: #758298;
	font-size: 25px;
}

.dat-detail {
	display: grid;
	grid-template-columns: 115px 1fr;
	gap: 16px 12px;
	margin: 0;
	padding: 23px 25px;
	font-size: 13px;
}

.dat-detail dt {
	color: #8290a5;
}

.dat-detail dd {
	margin: 0;
}

.dat-dialog-bottom {
	border-top: 1px solid #e1e7ef;
	padding: 14px 25px;
	display: flex;
	justify-content: end;
}

@media ( max-width :1050px) {
	.dat-stats {
		gap: 10px;
	}
	.dat-stat {
		padding: 15px;
	}
}

@media ( max-width :767px) {
	.dat-content-area, .sidebar-collapse .dat-content-area {
		margin-left: 0;
	}
	.dat-page {
		padding: 20px 15px 35px;
	}
	.dat-stats {
		grid-template-columns: repeat(2, minmax(0, 1fr));
	}
	.dat-filter {
		padding: 15px;
	}
	.dat-field {
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
	<div class="dat-content-area">
		<main class="dat-page">
		
			<header class="dat-header">
				<div>
					<h1 class="dat-title">ë¶ì ê·¼í íí©</h1>
					<p class="dat-subtitle">ê°ì ë¶ì ì§ìì ì¼ë³
						ì¶í´ê·¼ ë° ê·¼í ìíë¥¼ íì¸í©ëë¤.</p>
				</div>
				<span class="dat-demo">íë©´ ìì ë°ì´í° Â· DB
					ë¯¸ì°ê²°</span>
			</header>

			<section class="dat-panel dat-filter"
				aria-label="ë¶ì ê·¼í ì¡°í ì¡°ê±´">
				<div class="dat-field">
					<label for="datDepartment">ì¡°í ë¶ì</label><input
						id="datDepartment" type="text" name="departmentLabel"
						value="ê°ë°í (ìì)" readonly>
				</div>
				<div class="dat-field">
					<label for="datWorkDate">ê·¼ë¬´ ì¼ì</label><input
						id="datWorkDate" name="workDate" type="date" value="2026-11-05">
				</div>
				<div class="dat-field">
					<label for="datStatus">ê·¼í ìí</label> <select id="datStatus"
						name="attendanceStatus"><option value="ALL">ì ì²´</option>
						<option value="NORMAL">ì ì ì¶ê·¼</option>
						<option value="LATE">ì§ê°</option>
						<option value="EARLY">ì¡°í´</option>
						<option value="LEAVE">í´ê°</option>
						<option value="UNKNOWN">ë¯¸ê¸°ë¡</option></select>
				</div>
				<div class="dat-field dat-grow">
					<label for="datKeyword">ì§ì ê²ì</label><input id="datKeyword"
						name="attendanceKeyword" type="search"
						placeholder="ì´ë¦ ëë ì¬ë²">
				</div>
				<div class="dat-btn-row">
					<button type="button" class="dat-btn dat-btn-primary"
						name="searchDepartmentAttendance">ê·¼í ì¡°í</button>
					<button type="button" class="dat-btn"
						name="resetDepartmentAttendance">ì´ê¸°í</button>
				</div>
			</section>

			<section class="dat-stats" aria-label="ë¶ì ê·¼í ìì½">
				<div class="dat-stat">
					<div class="dat-stat-label">ì¡°í ì§ì</div>
					<div class="dat-stat-value" name="allEmployees">0ëª</div>
				</div>
				<div class="dat-stat">
					<div class="dat-stat-label">ì ì ì¶ê·¼</div>
					<div class="dat-stat-value" name="normalEmployees">0ëª</div>
				</div>
				<div class="dat-stat">
					<div class="dat-stat-label">ì§ê° Â· ì¡°í´</div>
					<div class="dat-stat-value" name="lateEmployees">0ëª</div>
				</div>
				<div class="dat-stat">
					<div class="dat-stat-label">í´ê° Â· ë¯¸ê¸°ë¡</div>
					<div class="dat-stat-value" name="otherEmployees">0ëª</div>
				</div>
			</section>

			<section class="dat-panel" aria-label="ë¶ì ì§ì ê·¼í ëª©ë¡">
				<div class="dat-panel-head">
					<h2 class="dat-section-title">ì§ìë³ ê·¼í ëª©ë¡</h2>
					<span class="dat-count" name="attendanceCount">ì´ 0ëª</span>
				</div>
				<div class="dat-scroll">
					<table class="dat-table">
						<thead>
							<tr>
								<th>ì¬ë²</th>
								<th>ì§ìëª</th>
								<th>ê·¼ë¬´ ì¼ì</th>
								<th>ì¶ê·¼ ìê°</th>
								<th>í´ê·¼ ìê°</th>
								<th>ê·¼í ìí</th>
								<th>ìì¸</th>
							</tr>
						</thead>
						<tbody name="departmentAttendanceRows"></tbody>
					</table>
				</div>
				<div class="dat-footer">â» ë¯¸ê¸°ë¡ì ê²°ê·¼ íì ì´
					ìëëë¤. í´ê° ì¬ë¶ ë° ê·¼ë¬´ ì¼ì ê³¼ í¨ê»
					íì¸í´ì¼ í©ëë¤.</div>
			</section>
		</main>
	</div>

	<div class="dat-overlay" name="attendanceDetailOverlay" role="dialog"
		aria-modal="true" aria-labelledby="datDetailTitle">
		<div class="dat-dialog">
			<div class="dat-dialog-head">
				<h2 id="datDetailTitle">ì§ì ê·¼í ìì¸</h2>
				<button type="button" class="dat-close" name="closeAttendanceDetail"
					aria-label="ë«ê¸°">Ã</button>
			</div>
			<dl class="dat-detail" name="attendanceDetailContent"></dl>
			<div class="dat-dialog-bottom">
				<button type="button" class="dat-btn" name="closeAttendanceDetail">ë«ê¸°</button>
			</div>
		</div>
	</div>
	<script>
// ê°ë°ì© ìì. ì¤ì  êµ¬íì ë¡ê·¸ì¸ ê´ë¦¬ìì ë¶ìë¥¼ ìë²ê° íì í´ ì¡°íí´ì¼ í©ëë¤.
const departmentAttendanceDemo = [
    {empId:1, name:"ê¹ë¯¼ì¤", department:"ê°ë°í", date:"2026-11-05", clockIn:"08:56", clockOut:"--:--", status:"NORMAL", note:"ì ì ì¶ê·¼"},
    {empId:4, name:"ì´ìì°", department:"ê°ë°í", date:"2026-11-05", clockIn:"09:12", clockOut:"--:--", status:"LATE", note:"ì¶ê·¼ ìê° ì§ì°"},
    {empId:7, name:"ë°ì§í", department:"ê°ë°í", date:"2026-11-05", clockIn:"08:51", clockOut:"--:--", status:"NORMAL", note:"ì ì ì¶ê·¼"},
    {empId:9, name:"ìµì ì§", department:"ê°ë°í", date:"2026-11-05", clockIn:"08:57", clockOut:"15:30", status:"EARLY", note:"ì¡°í´ ì²ë¦¬"},
    {empId:11, name:"ì ëí", department:"ê°ë°í", date:"2026-11-05", clockIn:"--:--", clockOut:"--:--", status:"LEAVE", note:"ì¹ì¸ë í´ê°"},
    {empId:13, name:"íì§ë¯¼", department:"ê°ë°í", date:"2026-11-05", clockIn:"--:--", clockOut:"--:--", status:"UNKNOWN", note:"ê·¼í ê¸°ë¡ íì¸ íì"},
    {empId:16, name:"ì¤íë", department:"ê°ë°í", date:"2026-11-05", clockIn:"09:00", clockOut:"--:--", status:"NORMAL", note:"ì ì ì¶ê·¼"}
];
const deptStatusText = {NORMAL:"ì ì ì¶ê·¼", LATE:"ì§ê°", EARLY:"ì¡°í´", LEAVE:"í´ê°", UNKNOWN:"ë¯¸ê¸°ë¡"};
const deptStatusClass = {NORMAL:"dat-pill-normal", LATE:"dat-pill-late", EARLY:"dat-pill-early", LEAVE:"dat-pill-leave", UNKNOWN:"dat-pill-unknown"};
const getDepartmentAttendance = function() {
    const selectedDate = $("input[name='workDate']").val();
    const status = $("select[name='attendanceStatus']").val();
    const keyword = $("input[name='attendanceKeyword']").val().trim().toLowerCase();
    const rows = departmentAttendanceDemo.filter(function(item) {
        return item.date === selectedDate && (status === "ALL" || item.status === status)
            && (!keyword || item.name.toLowerCase().includes(keyword) || String(item.empId).includes(keyword));
    });
    const $tbody = $("tbody[name='departmentAttendanceRows']").empty();
    $("div[name='allEmployees']").text(rows.length + "ëª");
    $("div[name='normalEmployees']").text(rows.filter(r => r.status === "NORMAL").length + "ëª");
    $("div[name='lateEmployees']").text(rows.filter(r => r.status === "LATE" || r.status === "EARLY").length + "ëª");
    $("div[name='otherEmployees']").text(rows.filter(r => r.status === "LEAVE" || r.status === "UNKNOWN").length + "ëª");
    $("span[name='attendanceCount']").text("ì´ " + rows.length + "ëª");
    if (rows.length === 0) {
        $tbody.append($("<tr>").append($("<td>", {colspan:7, "class":"dat-empty", text:"ì¡°íë ê·¼í ë´ì­ì´ ììµëë¤."})));
        return;
    }
    rows.forEach(function(item) {
        const $tr = $("<tr>");
        $tr.append($("<td>").text(item.empId));
        $tr.append($("<td>").text(item.name));
        $tr.append($("<td>").text(item.date));
        $tr.append($("<td>").text(item.clockIn));
        $tr.append($("<td>").text(item.clockOut));
        $tr.append($("<td>").append($("<span>", {"class":"dat-pill " + deptStatusClass[item.status], text:deptStatusText[item.status]})));
        $tr.append($("<td>").append($("<button>", {type:"button", "class":"dat-btn dat-btn-small", text:"ìì¸", "data-emp-id":item.empId})));
        $tbody.append($tr);
    });
};
const showDepartmentAttendanceDetail = function(empId) {
    const selectedDate = $("input[name='workDate']").val();
    const item = departmentAttendanceDemo.find(row => row.empId === empId && row.date === selectedDate);
    if (!item) return;
    const details = [["ì¬ë²",item.empId],["ì§ìëª",item.name],["ìì ë¶ì",item.department],["ê·¼ë¬´ ì¼ì",item.date],
        ["ì¶ê·¼ ìê°",item.clockIn],["í´ê·¼ ìê°",item.clockOut],["ê·¼í ìí",deptStatusText[item.status]],["ë¹ê³ ",item.note]];
    const $content = $("dl[name='attendanceDetailContent']").empty();
    details.forEach(function(pair) { $content.append($("<dt>").text(pair[0])); $content.append($("<dd>").text(pair[1])); });
    $("div[name='attendanceDetailOverlay']").addClass("dat-open");
};
$(function() {
    getDepartmentAttendance();
    $("button[name='searchDepartmentAttendance']").on("click", getDepartmentAttendance);
    $("button[name='resetDepartmentAttendance']").on("click", function() {
        $("input[name='workDate']").val("2026-11-05");
        $("select[name='attendanceStatus']").val("ALL");
        $("input[name='attendanceKeyword']").val("");
        getDepartmentAttendance();
    });
    $("input[name='attendanceKeyword']").on("keydown", function(e) { if (e.key === "Enter") getDepartmentAttendance(); });
    $("tbody[name='departmentAttendanceRows']").on("click", "button[data-emp-id]", function() { showDepartmentAttendanceDetail(Number($(this).attr("data-emp-id"))); });
    $("button[name='closeAttendanceDetail']").on("click", function() { $("div[name='attendanceDetailOverlay']").removeClass("dat-open"); });
    $("div[name='attendanceDetailOverlay']").on("click", function(e) { if (e.target === this) $(this).removeClass("dat-open"); });
    $(document).on("keydown", function(e) { if (e.key === "Escape") $("div[name='attendanceDetailOverlay']").removeClass("dat-open"); });
});
</script>
</body>
</html>
