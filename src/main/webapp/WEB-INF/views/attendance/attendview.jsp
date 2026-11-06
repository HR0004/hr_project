<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내 근태 현황</title>

<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/static/css/attendview.css">

<script type="text/javascript">
    const contextPath = "${pageContext.request.contextPath}";

    let attendanceList = [];
    let listLoaded = false;

    function todayKorea() {
        return new Date(
            Date.now() + 9 * 60 * 60 * 1000
        ).toISOString().substring(0, 10);
    }

    function displayDate(raw) {
        const iso = String(raw || '').substring(0, 10);

        if (!/^\d{4}-\d{2}-\d{2}$/.test(iso)) {
            return '-';
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>

/* 근태 본문 전용 스타일: 다른 JSP에 영향을 주지 않도록 att- 접두어 사용 */
.att-dashboard {
	width: 100%;
	font-family: "Pretendard", "Malgun Gothic", Arial, sans-serif;
	color: #10192e;
	box-sizing: border-box;
	max-width: 1490px;
	padding: 24px 32px 30px;
	margin: 0 auto;
	background: #fff
}

.att-dashboard *, .att-dashboard *::before, .att-dashboard *::after {
	box-sizing: border-box
}

.att-dashboard h2, .att-dashboard h3, .att-dashboard h4, .att-dashboard p
	{
	margin: 0
}

.att-heading {
	font-size: 20px;
	font-weight: 750;
	line-height: 1.4;
	letter-spacing: -.6px
}

.att-caption {
	font-size: 13px;
	color: #7e8ba0;
	margin-top: 8px !important
}

.att-today-card {
	border: 1px solid #dfe6ef;
	border-radius: 9px;
	padding: 26px 31px 33px;
	margin-top: 27px;
	min-height: 258px
}

.att-card-title {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 23px !important
}

.att-today-grid {
	display: grid;
	grid-template-columns: 1.05fr 1.4fr 2.1fr;
	gap: 0
}

.att-today-col {
	padding: 5px 37px;
	min-height: 197px;
	border-left: 1px solid #e3e9f1
}

.att-today-col:first-child {
	border-left: 0;
	padding-left: 0
}

.att-today-col:last-child {
	padding-right: 0
}

.att-label {
	color: #7e8ba0;
	font-size: 13px;
	margin: 0 0 11px !important
}

.att-value {
	font-size: 16px;
	font-weight: 500
}

.att-mt {
	margin-top: 30px
}

.att-status-badge {
	display: inline-flex;
	align-items: center;
	gap: 9px;
	padding: 9px 16px;
	min-width: 106px;
	border-radius: 24px;
	background: #dcfce7;
	font-size: 12px;
	color: #176d3c
}

.att-dot {
	width: 9px;
	height: 9px;
	border-radius: 50%;
	background: #19a757;
	display: inline-block;
	flex: none
}

.att-time-grid {
	display: flex;
	gap: 90px;
	margin-top: 18px
}

.att-time-grid>div {
	min-width: 96px
}

.att-time {
	font-weight: 700;
	font-size: 17px;
	color: #111a2b;
	margin-top: 10px
}

.att-checkin-controls {
	display: flex;
	align-items: flex-start;
	gap: 40px
}

.att-network {
	flex: 1;
	min-width: 190px
}

.att-network-box {
	display: flex;
	align-items: center;
	gap: 8px;
	border: 1px solid #b0edc5;
	background: #ebfcf1;
	color: #177341;
	padding: 12px 14px;
	border-radius: 6px;
	font-size: 13px;
	min-height: 44px;
	white-space: nowrap
}

.att-network-box.att-pending {
	background: #f3f6fa;
	border-color: #e0e7ef;
	color: #56657b
}

.att-network-box.att-pending .att-dot {
	background: #9aa6b5
}

.att-help {
	font-size: 12px;
	color: #8190a5;
	margin-top: 12px !important
}

.att-button-pair {
	display: flex;
	gap: 12px;
	padding-top: 28px
}

.att-post {
	display: inline;
	margin: 0
}

.att-button {
	font-family: inherit;
	cursor: pointer;
	border-radius: 6px;
	min-width: 130px;
	height: 54px;
	border: 1px solid #d5deea;
	font-size: 14px;
	font-weight: 650;
	background: white;
	color: #42526b
}

.att-button-primary {
	color: #fff;
	background: #111a2f;
	border-color: #111a2f
}

.att-button:disabled {
	cursor: not-allowed;
	opacity: .65
}

.att-section {
	margin-top: 30px
}

.att-records-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	margin-bottom: 21px
}

.att-filter {
	display: flex;
	align-items: center;
	gap: 12px;
	flex-wrap: wrap
}

.att-filter-btn {
	height: 44px;
	border: 1px solid #dfe6ef;
	background: #fff;
	border-radius: 6px;
	padding: 0 25px;
	font-family: inherit;
	font-size: 13px;
	color: #52627b;
	cursor: pointer
}

.att-filter-btn.att-dark {
	background: #111a2f;
	color: #fff;
	border-color: #111a2f;
	min-width: 190px;
	font-weight: 650
}

.att-month-input {
	height: 44px;
	min-width: 208px;
	border: 1px solid #dfe6ef;
	border-radius: 6px;
	font: inherit;
	color: #52627b;
	font-size: 13px;
	padding: 0 14px;
	background: white
}

.att-table-wrap {
	width: 100%;
	overflow-x: auto
}

.att-table {
	width: 100%;
	min-width: 800px;
	border-collapse: separate;
	border-spacing: 0;
	table-layout: fixed;
	font-size: 13px
}

.att-table th {
	text-align: left;
	color: #1e293b;
	font-weight: 700;
	background: #f0f3f7;
	padding: 19px 28px;
	border-bottom: 1px solid #e4eaf1
}

.att-table th:first-child {
	border-radius: 6px 0 0 6px
}

.att-table th:last-child {
	border-radius: 0 6px 6px 0
}

.att-table td {
	padding: 21px 28px;
	border-top: 1px solid #e3eaf3;
	border-bottom: 1px solid #e3eaf3;
	background: #fff;
	color: #1c293d
}

.att-table td:first-child {
	border-left: 1px solid #e3eaf3;
	border-radius: 5px 0 0 5px
}

.att-table td:last-child {
	border-right: 1px solid #e3eaf3;
	border-radius: 0 5px 5px 0
}

.att-table .att-emphasis {
	color: #d65f18
}

.att-footer-note {
	font-size: 12px;
	color: #8491a5;
	margin-top: 20px !important
}

.att-empty {
	text-align: center !important;
	color: #7b8aa0 !important;
	padding: 30px !important
}

.att-dialog-overlay[hidden], .att-dashboard [hidden] {
	display: none !important
}

.att-dialog-overlay {
	position: fixed;
	inset: 0;
	background: rgba(10, 19, 38, .44);
	z-index: 1000;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 16px
}

.att-dialog {
	background: white;
	border-radius: 12px;
	max-width: 470px;
	width: 100%;
	padding: 27px;
	box-shadow: 0 15px 60px rgba(10, 20, 40, .2)
}

.att-dialog-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px
}

.att-dialog h3 {
	font-size: 19px
}

.att-close {
	font-size: 24px;
	background: none;
	border: 0;
	cursor: pointer;
	color: #66758c
}

.att-summary-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 10px
}

.att-summary-item {
	padding: 16px;
	background: #f4f7fb;
	border-radius: 7px
}

.att-summary-item b {
	font-size: 22px;
	display: block;
	margin-top: 6px
}

@media ( max-width :1050px) {
	.att-today-grid {
		grid-template-columns: 1fr 1fr
	}
	.att-today-col:last-child {
		grid-column: 1/-1;
		border-left: 0;
		border-top: 1px solid #e5eaf1;
		padding: 22px 0 0;
		margin-top: 20px;
		min-height: auto
	}
	.att-records-header {
		align-items: flex-start;
		flex-direction: column
	}
	.att-today-col:nth-child(2) {
		padding-right: 0
	}
}

@media ( max-width :600px) {
	.att-dashboard {
		padding: 20px 14px
	}
	.att-today-card {
		padding: 20px 16px
	}
	.att-today-grid {
		grid-template-columns: 1fr
	}
	.att-today-col {
		border: 0 !important;
		border-top: 1px solid #e5eaf1 !important;
		grid-column: auto !important;
		padding: 20px 0 !important;
		min-height: 0;
		margin: 0 !important
	}
	.att-today-col:first-child {
		border-top: 0 !important;
		padding-top: 0 !important
	}
	.att-checkin-controls {
		flex-direction: column;
		gap: 0
	}
	.att-button-pair {
		padding-top: 14px
	}
	.att-time-grid {
		gap: 45px
	}
	.att-filter {
		width: 100%
	}
	.att-filter>* {
		flex: 1;
		min-width: 130px
	}
}

/* 교실에서 배우던 Bootstrap3 + jQuery 구조를 유지하는 추가 스타일 */
body {
	margin: 0;
	background: #fff;
}

.att-dashboard .att-table {
	margin-bottom: 0;
}

.att-dashboard .att-status-badge {
	font-weight: 500;
}

.att-dashboard .att-reload-hint {
	color: #8a97a9;
	font-size: 12px;
	margin-top: 10px;
}

.att-dashboard .att-failure {
	color: #bb3e35;
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

<script type="text/javascript">
        // 실제 프로젝트의 Context Path: /HR_PROJECT 또는 빈 문자열
        const contextPath = "${pageContext.request.contextPath}";
        let attendanceList = [];
        let listLoaded = false;

        // 날짜/시간/상태 출력용 함수
        function todayKorea() {
            return new Date(Date.now() + 9 * 60 * 60 * 1000).toISOString().substring(0, 10);
        }

        const dayIndex = new Date(
            iso + 'T00:00:00Z'
        ).getUTCDay();

        const days = ['일', '월', '화', '수', '목', '금', '토'];

        return iso + ' (' + days[dayIndex] + ')';
    }

    function displayTime(raw) {
        if (!raw) {
            return '--:--';
        }

        const match = String(raw).match(/\b(\d{2}):(\d{2})\b/);

        return match ? match[1] + ':' + match[2] : '--:--';
    }

    // 화면 표시용 임시 근무시간 계산
    function displayDuration(clockIn, clockOut) {
        const start = displayTime(clockIn);
        const end = displayTime(clockOut);

        if (start === '--:--' || end === '--:--') {
            return '-';
        }

        const a = start.split(':').map(Number);
        const b = end.split(':').map(Number);

        let mins = (b[0] * 60 + b[1]) - (a[0] * 60 + a[1]);

        if (mins < 0) {
            mins += 24 * 60;
        }

        return Math.floor(mins / 60) + '시간 ' +
            String(mins % 60).padStart(2, '0') + '분';
    }

    function statusText(status) {
        const key = String(status || '').toUpperCase();

        if (key === 'NORMAL' ||
            key === 'PRESENT' ||
            key === 'ON_TIME') {
            return '정상 근무';
        }

        if (key === 'LATE') {
            return '지각';
        }

        if (key === 'EARLY_LEAVE' || key === 'EARLY') {
            return '조퇴';
        }

        if (key === 'ABSENT') {
            return '결근';
        }

        return String(status || '미확인');
    }

    function remarkText(row) {
        if (row.remark || row.note) {
            return String(row.remark || row.note);
        }

        const s = statusText(row.status);

        if (s === '지각') {
            return '출근 지각';
        }

        if (s === '조퇴') {
            return '조기 퇴근';
        }

        return '-';
    }

    function getAttendanceList() {
        $('#att-message')
            .text('근태 기록을 조회하고 있습니다.')
            .removeClass('att-failure');

        $('#att-rows').empty();

        const task = Array.isArray(window.ATTENDANCE_DEMO)
            ? Promise.resolve(window.ATTENDANCE_DEMO)
            : fetch(contextPath + '/api/attendance/my', {
                method: 'GET'
            }).then(response => {
                if (!response.ok) {
                    throw new Error(
                        '근태 기록 조회 실패 (HTTP ' +
                        response.status + ')'
                    );
                }

                return response.json();
            });

        task.then(res => {
            if (!Array.isArray(res)) {
                throw new Error('서버 응답이 목록 형태가 아닙니다.');
            }

            attendanceList = res;
            listLoaded = true;

            displayList();

            $('#att-message').text(
                'DB 조회 완료 · 총 ' + attendanceList.length + '건'
            );
        }).catch(error => {
            console.error('근태 기록 조회 에러:', error);

            attendanceList = [];
            listLoaded = false;
        			$("span[name='attendanceStatus']").text("출근 전");
        	    	$("div[name='clockIn']").text("--:--");
        	    	$("div[name='clockOut']").text("--:--");
        	    	
        	    	setAttendanceButtons(null);

            $('#att-rows').empty();

            $('<tr>').append(
                $('<td>', {
                    colspan: 6,
                    class: 'att-empty'
                }).text(
                    '목록 조회에 실패했습니다. 서버/API 상태를 확인하세요.'
                )
            ).appendTo('#att-rows');

            $('#att-message')
                .addClass('att-failure')
                .text(error.message);
        });
    }

    const getTodayAttendance = async () => {
        const today = todayKorea();

        $("div[name='workDate']").text(displayDate(today));

        try {
            const response = await fetch(
                contextPath + "/api/attendance/my",
                { method: "GET" }
            );

            if (!response.ok) {
                throw new Error("근태 조회 실패: " + response.status);
            }

            const records = await response.json();
        		} else {
        			$("span[name='attendanceStatus']").text("출근 전");
        		}
				
        		setAttendanceButtons(record);
        		
        		} catch (error) {

        			console.error("오늘 근태 조회 오류", error);
        	}
        };
        

     // 출근·퇴근 버튼 상태 제어
     const setAttendanceButtons = (record) => {

         const checkedIn = !!(record && record.clockIn);
         const checkedOut = !!(record && record.clockOut);

         $("button[name='clockInButton']")
             .prop("disabled", checkedIn);

         $("button[name='clockOutButton']")
             .prop("disabled", !checkedIn || checkedOut);
     };

     // 요청 진행 중 버튼 비활성화
     const disableAttendanceButtons = () => {

         $("button[name='clockInButton']").prop("disabled", true);
         $("button[name='clockOutButton']").prop("disabled", true);
     };

     // 출근 및 퇴근 요청
     const submitAttendance = async (action) => {

         disableAttendanceButtons();

         try {

             const response = await fetch(
                 "${pageContext.request.contextPath}/api/attendance/" + action,
                 {
                     method: "POST"
                 }
             );

             const message = await response.text();

             if (!response.ok) {
                 throw new Error(message || "출퇴근 등록 실패");
             }

             alert(message);

         } catch (error) {

             alert(error.message);

         } finally {

             await getTodayAttendance();
             getAttendanceList();

         }
     };


            console.log("DB 조회 결과", records);

            const record = records.find(
                row => String(row.workDate || "")
                    .substring(0, 10) === today
            );

            if (!record) {
                $("span[name='attendanceStatus']").text("출근 전");
                $("div[name='clockIn']").text("--:--");
                $("div[name='clockOut']").text("--:--");
                return;
            }

            $("div[name='clockIn']").text(
                displayTime(record.clockIn)
            );

            $("div[name='clockOut']").text(
                displayTime(record.clockOut)
            );

            if (record.clockOut) {
                $("span[name='attendanceStatus']").text("퇴근 완료");
            } else if (record.clockIn) {
                $("span[name='attendanceStatus']").text("근무 중");
            } else {
                $("span[name='attendanceStatus']").text("출근 전");
            }
        } catch (error) {
            console.error("오늘 근태 조회 오류", error);
        }
    };

    function filteredList() {
        const month = $('#att-month').val();

        return attendanceList.filter(
            row => String(row.workDate || '')
                .substring(0, 7) === month
        );
    }

    function displayList() {
        const list = filteredList();
        const tbody = $('#att-rows');

        tbody.empty();

        if (list.length === 0) {
            $('<tr>').append(
                $('<td>', {
                    colspan: 6,
                    class: 'att-empty'
                }).text('선택한 기간의 근태 기록이 없습니다.')
            ).appendTo(tbody);

            return;
        }

        for (let i = 0; i < list.length; i++) {
            const row = list[i];
            const status = statusText(row.status);
            const tr = $('<tr>');

            $('<td>').text(
                displayDate(row.workDate)
            ).appendTo(tr);

            $('<td>').text(
                displayTime(row.clockIn)
            ).appendTo(tr);

            $('<td>').text(
                displayTime(row.clockOut)
            ).appendTo(tr);

            $('<td>').text(
                displayDuration(row.clockIn, row.clockOut)
            ).appendTo(tr);

            $('<td>').text(status).toggleClass(
                'att-emphasis',
                status === '지각' ||
                status === '조퇴' ||
                status === '결근'
            ).appendTo(tr);

            $('<td>').text(remarkText(row)).appendTo(tr);

            tbody.append(tr);
        }
    }

    function showMonthlyDetail() {
        if (!listLoaded) {
            return;
        }

        const list = filteredList();

        const count = value => list.filter(
            row => statusText(row.status) === value
        ).length;

        $('#att-dialog-month').text(
            $('#att-month').val() + ' 근태 요약'
        );

        $('#att-count-total').text(list.length + '건');
        $('#att-count-normal').text(count('정상 근무') + '건');
        $('#att-count-late').text(count('지각') + '건');
        $('#att-count-early').text(count('조퇴') + '건');

        $('#att-dialog-overlay').prop('hidden', false);
    }

    $(function () {
        $('#att-month').val(
            todayKorea().substring(0, 7)
        );

        getTodayAttendance();
        getAttendanceList();

        $('#att-search').click(function () {
            if (listLoaded) {
                displayList();
            }
        });

        $('#att-dialog-close').click(function () {
            $('#att-dialog-overlay').prop('hidden', true);
        });

        $('#att-dialog-overlay').click(function (event) {
            if (event.target === this) {
                $(this).prop('hidden', true);
            }
            $("button[name='moveMonthlyView']").on("click", function() {
				window.location.href = contextPath + "/attendance/monthly";
			});
            

            $("button[name='clockInButton']").on("click", function() {

                submitAttendance("clock-in");

            });

            $("button[name='clockOutButton']").on("click", function() {

                submitAttendance("clock-out");

            });

            
        });

        $(document).keydown(function (event) {
            if (event.key === 'Escape') {
                $('#att-dialog-overlay').prop('hidden', true);
            }
        });

        $("button[name='moveMonthlyView']").on("click", function () {
            window.location.href =
                contextPath + "/attendance/monthly";
        });
    });
</script>
</head>

<body>

<div class="page-wrapper">

    <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

    <div class="main-content main-area hrms-page">

        <section class="att-dashboard" id="att-dashboard">

            <header class="top-nav-bar">
                <div class="page-title-area">
                    <h2 class="att-heading">내 근태 현황</h2>
                    <p class="att-caption">
                        출근 및 퇴근을 등록하고 나의 근태 기록을 확인할 수 있습니다.
                    </p>
                </div>

                <%@ include file="/WEB-INF/views/common/header.jspf" %>
            </header>

            <section class="att-today-card">
                <h3 class="att-card-title">오늘의 출퇴근</h3>

                <div class="att-today-grid">

                    <div class="att-today-col">
                        <p class="att-label">근무 일자</p>
                        <div class="att-value" name="workDate">-</div>

                        <div class="att-mt">
                            <p class="att-label">기준 근무시간</p>
                            <div class="att-value">09:00 - 18:00</div>
                        </div>
                    </div>

                    <div class="att-today-col">
                        <p class="att-label">현재 상태</p>

                        <span class="att-status-badge">
                            <span class="att-dot"></span>
                            <span name="attendanceStatus">출근 전</span>
                        </span>

                        <div class="att-time-grid">
                            <div>
                                <p class="att-label">출근 시간</p>
                                <div class="att-time" name="clockIn">
                                    --:--
                                </div>
                            </div>

                            <div>
                                <p class="att-label">퇴근 시간</p>
                                <div class="att-time" name="clockOut">
                                    --:--
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="att-today-col">
                        <div class="att-checkin-controls">
                            <div>
                                <div class="att-button-pair">
                                    <button type="button"
                                            class="att-button att-button-primary"
                                            disabled>
                                        출근하기
                                    </button>

                                    <button type="button"
                                            class="att-button"
                                            disabled>
                                        퇴근하기
                                    </button>
                                </div>

                                <p class="att-help">
                                    출퇴근 등록 API 연결 후 사용할 수 있습니다.
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </section>

            <section class="att-section">

                <div class="att-records-header">
                    <div>
                        <h2 class="att-heading">나의 근태 기록</h2>
                        <p class="att-caption">
                            최근 근태 기록을 확인할 수 있습니다.
                        </p>

                        <p id="att-message"
                           class="att-reload-hint"
                           aria-live="polite"></p>
                    </div>

                    <div class="att-filter">
                        <button type="button"
                                class="att-filter-btn att-dark"
                                name="moveMonthlyView">
                            월별 상세 조회
                        </button>

                        <input type="month"
                               class="att-month-input"
                               id="att-month"
                               aria-label="조회할 연월">

                        <button type="button"
                                class="att-filter-btn"
                                id="att-search">
                            기간 조회
                        </button>
                    </div>
                </div>

                <div class="att-table-wrap">
                    <table class="att-table">
                        <thead>
                            <tr>
                                <th>근무 일자</th>
                                <th>출근 시간</th>
                                <th>퇴근 시간</th>
                                <th>근무 시간</th>
                                <th>상태</th>
                                <th>비고</th>
                            </tr>
                        </thead>

                        <tbody id="att-rows">
                            <tr>
                                <td class="att-empty" colspan="6">
                                    근태 기록을 불러오는 중입니다.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <p class="att-footer-note">
                    ※ 근무 시간은 화면에서 계산한 임시 값입니다.
                    휴게시간 공제 등 실제 근태 규칙은 Service에서 처리해야 합니다.
                </p>
            </section>

            <div class="att-dialog-overlay"
                 id="att-dialog-overlay"
                 hidden>

                <div class="att-dialog"
                     role="dialog"
                     aria-modal="true"
                     aria-labelledby="att-dialog-title">

                    <div class="att-dialog-top">
                        <h3 id="att-dialog-title">월별 상세 조회</h3>

                        <button type="button"
                                class="att-close"
                                id="att-dialog-close"
                                aria-label="닫기">
                            ×
                        </button>
                    </div>

                    <p class="att-caption"
                       id="att-dialog-month"
                       style="margin-bottom: 18px !important;"></p>

                    <div class="att-summary-grid">
                        <div class="att-summary-item">
                            조회된 근무 기록
                            <b id="att-count-total">0건</b>
                        </div>

                        <div class="att-summary-item">
                            정상 근무
                            <b id="att-count-normal">0건</b>
                        </div>

                        <div class="att-summary-item">
                            지각
                            <b id="att-count-late">0건</b>
                        </div>

                        <div class="att-summary-item">
                            조퇴
                            <b id="att-count-early">0건</b>
                        </div>
                    </div>

                    <p class="att-footer-note">
                        현재 조회된 목록을 기준으로 집계합니다.
                    </p>
                </div>
            </div>

        </section>
    </div>
</div>

	<div class="page-wrapper">
		<%@ include file="../common/sidebar.jspf"%>
		<div class="main-content main-area">

			<%@ include file="../common/header.jspf"%>
			<section class="att-dashboard" id="att-dashboard">
				<header>
					<h2 class="att-heading">내 근태 현황</h2>
					<p class="att-caption">출근 및 퇴근을 등록하고 나의 근태 기록을 확인할 수 있습니다.</p>
				</header>

				<!-- 위에 꺼 -->


				<section class="att-today-card">
					<h3 class="att-card-title">오늘의 출퇴근</h3>
					<div class="att-today-grid">


						<div class="att-today-col">

							<p class="att-label">근무 일자</p>
							<div class="att-value" name="workDate">-</div>

							<div class="att-mt">
								<p class="att-label">기준 근무시간</p>
								<div class="att-value">09:00 - 18:00</div>
							</div>

						</div>

						<!-- 나누기 -->

						<div class="att-today-col">


							<p class="att-label">현재 상태</p>


							<span class="att-status-badge"> <span class="att-dot"></span>
								<span name="attendanceStatus">출근 전</span>
							</span>

							<div class="att-time-grid">

								<div>
									<p class="att-label">출근 시간</p>
									<div class="att-time" name="clockIn">--:--</div>
								</div>

								<div>
									<p class="att-label">퇴근 시간</p>
									<div class="att-time" name="clockOut">--:--</div>
								</div>
							</div>
						</div>

						<!--  나누고  -->

						<div class="att-today-col">

							<div class="att-checkin-controls">

								<div>
									<div class="att-button-pair">

										<button type="button" class="att-button att-button-primary"
											name="clockInButton" disabled>출근하기</button>

										<button type="button" class="att-button" name="clockOutButton"
											disabled>퇴근하기</button>

									</div>
									<p class="att-help">출퇴근 등록 API 연결 후 사용할 수 있습니다.</p>
								</div>
							</div>
						</div>
					</div>
				</section>



				<!-- 아래 꺼 -->
				<section class="att-section">
					<div class="att-records-header">
						<div>
							<h2 class="att-heading">나의 근태 기록</h2>
							<p class="att-caption">최근 근태 기록을 확인할 수 있습니다.</p>
							<p id="att-message" class="att-reload-hint" aria-live="polite"></p>
						</div>
						<div class="att-filter">

							<button type="button" class="att-filter-btn att-dark"
								name="moveMonthlyView">월별 상세 조회</button>

							<input type="month" class="att-month-input" id="att-month"
								aria-label="조회할 연월">

							<button type="button" class="att-filter-btn" id="att-search">기간
								조회</button>
						</div>
					</div>
					<div class="att-table-wrap">
						<table class="att-table">
							<thead>
								<tr>
									<th>근무 일자</th>
									<th>출근 시간</th>
									<th>퇴근 시간</th>
									<th>근무 시간</th>
									<th>상태</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody id="att-rows">
								<tr>
									<td class="att-empty" colspan="6">근태 기록을 불러오는 중입니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p class="att-footer-note">※ 근무 시간은 화면에서 계산한 임시 값입니다. 휴게시간 공제 등
						실제 근태 규칙은 Service에서 처리해야 합니다.</p>
				</section>

				<!-- 팝업창 -->
				<div class="att-dialog-overlay" id="att-dialog-overlay" hidden>
					<div class="att-dialog" role="dialog" aria-modal="true"
						aria-labelledby="att-dialog-title">
						<div class="att-dialog-top">
							<h3 id="att-dialog-title">월별 상세 조회</h3>
							<button type="button" class="att-close" id="att-dialog-close"
								aria-label="닫기">×</button>
						</div>
						<p class="att-caption" id="att-dialog-month"
							style="margin-bottom: 18px !important"></p>
						<div class="att-summary-grid">
							<div class="att-summary-item">
								조회된 근무 기록<b id="att-count-total">0건</b>
							</div>
							<div class="att-summary-item">
								정상 근무<b id="att-count-normal">0건</b>
							</div>
							<div class="att-summary-item">
								지각<b id="att-count-late">0건</b>
							</div>
							<div class="att-summary-item">
								조퇴<b id="att-count-early">0건</b>
							</div>
						</div>
						<p class="att-footer-note">현재 조회된 목록을 기준으로 집계합니다.</p>
					</div>
				</div>

				<!-- 월별 팝업 창 -->
			</section>

		</div>
	</div>
	<!-- 헤더/사이드바 없이 근태 페이지 내용물만 표시 -->
</body>
</html>