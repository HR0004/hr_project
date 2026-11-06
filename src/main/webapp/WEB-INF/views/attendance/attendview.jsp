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

</body>
</html>