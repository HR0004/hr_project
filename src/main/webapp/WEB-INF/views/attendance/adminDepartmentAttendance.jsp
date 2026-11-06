<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>부서 근태 현황</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style>

/* 부서 근태 화면 전용 스타일. 사이드바는 프로젝트 공통 레이아웃에서 추가합니다. */
.dat-content-area {
	width: 100%;
	min-width: 0;
	background: #fff;
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

	<%@ include file="../common/sidebar.jspf"%>

	<div class="main-content main-area">
		<%@ include file="../common/header.jspf"%>

		<div class="dat-content-area">

			<main class="dat-page">

				<header class="dat-header">

					<div>

						<h1 class="dat-title">부서 근태 현황</h1>

						<p class="dat-subtitle">같은 부서 직원의 일별 출퇴근 및 근태 상태를 확인합니다.</p>

					</div>


				</header>

				<section class="dat-panel dat-filter" aria-label="부서 근태 조회 조건">


					<div class="dat-field">
						<label for="datDepartment">조회 부서</label> <select
							id="datDepartment" name="departmentId">
							<option value="">부서 목록 불러오는 중...</option>
						</select>
					</div>


					<div class="dat-field">

						<label for="datWorkDate">근무 일자</label><input id="datWorkDate"
							name="workDate" type="date" value="2026-11-05">

					</div>

					<div class="dat-field">

						<label for="datStatus">근태 상태</label> <select id="datStatus"
							name="attendanceStatus"><option value="ALL">전체</option>

							<option value="NORMAL">정상 출근</option>

							<option value="LATE">지각</option>

							<option value="EARLY">조퇴</option>

							<option value="LEAVE">휴가</option>

							<option value="UNKNOWN">미기록</option></select>

					</div>

					<div class="dat-field dat-grow">

						<label for="datKeyword">직원 검색</label><input id="datKeyword"
							name="attendanceKeyword" type="search" placeholder="이름 또는 사번">

					</div>

					<div class="dat-btn-row">

						<button type="button" class="dat-btn dat-btn-primary"
							name="searchDepartmentAttendance">근태 조회</button>

						<button type="button" class="dat-btn"
							name="resetDepartmentAttendance">초기화</button>

					</div>

				</section>

				<section class="dat-stats" aria-label="부서 근태 요약">

					<div class="dat-stat">

						<div class="dat-stat-label">조회 직원</div>

						<div class="dat-stat-value" name="allEmployees">0명</div>

					</div>

					<div class="dat-stat">

						<div class="dat-stat-label">정상 출근</div>

						<div class="dat-stat-value" name="normalEmployees">0명</div>

					</div>

					<div class="dat-stat">

						<div class="dat-stat-label">지각 · 조퇴</div>

						<div class="dat-stat-value" name="lateEmployees">0명</div>

					</div>

					<div class="dat-stat">

						<div class="dat-stat-label">휴가 · 미기록</div>

						<div class="dat-stat-value" name="otherEmployees">0명</div>

					</div>

				</section>

				<section class="dat-panel" aria-label="부서 직원 근태 목록">

					<div class="dat-panel-head">

						<h2 class="dat-section-title">부서별 근태 목록</h2>

						<span class="dat-count" name="attendanceCount">총 0명</span>

					</div>

					<div class="dat-scroll">

						<table class="dat-table">

							<thead>

								<tr>

									<th>사번</th>

									<th>직원명</th>

									<th>근무 일자</th>

									<th>출근 시간</th>

									<th>퇴근 시간</th>

									<th>근태 상태</th>

									<th>상세</th>

								</tr>

							</thead>

							<tbody name="departmentAttendanceRows"></tbody>

						</table>

					</div>

					<div class="dat-footer">※ 미기록은 결근 확정이 아닙니다. 휴가 여부 및 근무 일정과 함께

						확인해야 합니다.</div>

				</section>

			</main>

		</div>
	</div>

	<div class="dat-overlay" name="attendanceDetailOverlay" role="dialog"
		aria-modal="true" aria-labelledby="datDetailTitle">

		<div class="dat-dialog">

			<div class="dat-dialog-head">

				<h2 id="datDetailTitle">직원 근태 상세</h2>

				<button type="button" class="dat-close" name="closeAttendanceDetail"
					aria-label="닫기">×</button>

			</div>

			<dl class="dat-detail" name="attendanceDetailContent"></dl>

			<div class="dat-dialog-bottom">

				<button type="button" class="dat-btn" name="closeAttendanceDetail">닫기</button>

			</div>

		</div>

	</div>

	<script>

	/* DB에 등록된 부서 목록 조회 */
	
/* DB에 등록된 부서 목록을 SelectBox에 표시 */
async function loadDepartments() {

    const select = $("#datDepartment");

    try {
        const response = await fetch(
            "${pageContext.request.contextPath}/api/departments",
            { method: "GET" }
        );

        if (!response.ok) {
            throw new Error("부서 목록 조회 실패: " + response.status);
        }

        const result = await response.json();

        console.log("부서 목록 API 응답:", result);

        // API가 배열 또는 data/content에 배열을 반환하는 경우 처리
        const departments = Array.isArray(result)
            ? result
            : (Array.isArray(result.data)
                ? result.data
                : (Array.isArray(result.content) ? result.content : []));

        select.empty();

        select.append(
            $("<option>").val("").text("전체 부서")
        );

        departments.forEach(function(dept) {

            // 부서 DTO의 필드 이름
            const id = dept.departmentId;
            const name = dept.departmentName;

            if (id == null || !name) {
                return;
            }

            select.append(
                $("<option>")
                    .val(id)
                    .text(name)
            );
        });

    } catch (error) {

        console.error("부서 조회 오류:", error);

        select.empty().append(
            $("<option>")
                .val("")
                .text("부서 조회 실패")
        );
    }
}


// 개발용 예시. 실제 구현은 로그인 관리자의 부서를 서버가 판정해 조회해야 합니다.

let departmentAttendanceRows = [];

const deptStatusText = {NORMAL:"정상 출근", LATE:"지각", EARLY:"조퇴", LEAVE:"휴가", UNKNOWN:"미기록"};

const deptStatusClass = {NORMAL:"dat-pill-normal", LATE:"dat-pill-late", EARLY:"dat-pill-early", LEAVE:"dat-pill-leave", UNKNOWN:"dat-pill-unknown"};


const getDepartmentAttendance = async function() {

    // 1. 사용자가 선택한 조회 조건
    const departmentId = $("#datDepartment").val();
    const selectedDate = $("input[name='workDate']").val();
    const status = $("select[name='attendanceStatus']").val();
    const keyword = $("input[name='attendanceKeyword']")
        .val().trim().toLowerCase();

    const $tbody = $("tbody[name='departmentAttendanceRows']");
    $tbody.empty();

    try {

        // 2. DB 조회 API에 부서 ID와 날짜 전달
        const params = new URLSearchParams();

        if (departmentId) {
            params.set("departmentId", departmentId);
        }

        params.set("workDate", selectedDate);

        const response = await fetch(
            "${pageContext.request.contextPath}/api/attendance/department?"
            + params.toString()
        );

        if (!response.ok) {
            throw new Error("근태 조회 실패: " + response.status);
        }

        // 3. 서버에서 받은 실제 근태 데이터
        const data = await response.json();

        if (!Array.isArray(data)) {
            throw new Error("근태 데이터 형식이 올바르지 않습니다.");
        }

        departmentAttendanceRows = data;
		

     // 부서 ID를 실제 부서 이름으로 변환
     departmentAttendanceRows.forEach(function(item) {

         const option = $("#datDepartment option").filter(
             function() {
                 return this.value === String(item.departmentId);
             }
         ).first();

         item.department = option.length
             ? option.text()
             : "부서 정보 없음";
     });

        // 4. 상태와 직원 이름/사번 필터
        const rows = departmentAttendanceRows.filter(function(item) {

            return (status === "ALL" || item.status === status)
                && (
                    !keyword ||
                    String(item.name).toLowerCase().includes(keyword) ||
                    String(item.empId).includes(keyword)
                );
        });

        // 5. 상단 통계 갱신
        $("div[name='allEmployees']").text(rows.length + "명");

        $("div[name='normalEmployees']").text(
            rows.filter(r => r.status === "NORMAL").length + "명"
        );

        $("div[name='lateEmployees']").text(
            rows.filter(r =>
                r.status === "LATE" || r.status === "EARLY"
            ).length + "명"
        );

        $("div[name='otherEmployees']").text(
            rows.filter(r =>
                r.status === "LEAVE" || r.status === "UNKNOWN"
            ).length + "명"
        );

        $("span[name='attendanceCount']").text(
            "총 " + rows.length + "명"
        );

        // 6. 조회된 데이터가 없는 경우
        if (rows.length === 0) {
            $tbody.append(
                $("<tr>").append(
                    $("<td>", {
                        colspan: 7,
                        "class": "dat-empty",
                        text: "조회된 근태 내역이 없습니다."
                    })
                )
            );
            return;
        }

        // 7. 실제 DB 데이터로 테이블 생성
        rows.forEach(function(item) {

            const $tr = $("<tr>");

            $tr.append($("<td>").text(item.empId));
            $tr.append($("<td>").text(item.name));
            $tr.append($("<td>").text(item.date));
            $tr.append($("<td>").text(item.clockIn || "--:--"));
            $tr.append($("<td>").text(item.clockOut || "--:--"));

            $tr.append(
                $("<td>").append(
                    $("<span>", {
                        "class": "dat-pill " +
                            (deptStatusClass[item.status] || "dat-pill-unknown"),
                        text: deptStatusText[item.status] || "미기록"
                    })
                )
            );

            $tr.append(
                $("<td>").append(
                    $("<button>", {
                        type: "button",
                        "class": "dat-btn dat-btn-small",
                        text: "상세",
                        "data-emp-id": item.empId
                    })
                )
            );

            $tbody.append($tr);
        });

    } catch (error) {

        console.error("부서 근태 조회 오류:", error);

        departmentAttendanceRows = [];

        $("div[name='allEmployees']").text("0명");
        $("div[name='normalEmployees']").text("0명");
        $("div[name='lateEmployees']").text("0명");
        $("div[name='otherEmployees']").text("0명");
        $("span[name='attendanceCount']").text("총 0명");

        $tbody.append(
            $("<tr>").append(
                $("<td>", {
                    colspan: 7,
                    "class": "dat-empty",
                    text: "근태 정보를 불러오지 못했습니다."
                })
            )
        );
    }
};


const showDepartmentAttendanceDetail = function(empId) {

    const selectedDate = $("input[name='workDate']").val();

    const item = departmentAttendanceRows.find(
    	    row => Number(row.empId) === Number(empId)
    	);

    if (!item) return;

    const details = [["사번",item.empId],["직원명",item.name],["소속 부서",item.department],["근무 일자",item.date],

        ["출근 시간",item.clockIn],["퇴근 시간",item.clockOut],["근태 상태",deptStatusText[item.status]],["비고",item.note]];

    const $content = $("dl[name='attendanceDetailContent']").empty();

    details.forEach(function(pair) { $content.append($("<dt>").text(pair[0])); $content.append($("<dd>").text(pair[1])); });

    $("div[name='attendanceDetailOverlay']").addClass("dat-open");

};

$(function() {
	
	loadDepartments().then(function() {
	    getDepartmentAttendance();
	});

    $("button[name='searchDepartmentAttendance']").on("click", getDepartmentAttendance);

    $("button[name='resetDepartmentAttendance']").on("click", function() {
		
    	$("#datDepartment").val("");
    	
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
