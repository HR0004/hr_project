<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>휴가 현황</title>

<!-- 수업에서 사용한 Bootstrap 3 + jQuery -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
/* 휴가 현황 전용 CSS: 다른 화면에 영향이 없도록 leave- 접두어 사용 */
.leave-dashboard, .leave-dashboard * {
	box-sizing: border-box;
}

.leave-dashboard {
	width: 100%;
    max-width: 1490px;
    margin: 0 auto;
    padding: 20px 50px 40px;
}

.leave-dashboard h2, .leave-dashboard h3, .leave-dashboard p {
	margin: 0;
}

/* 제목 */
.leave-heading {
	font-size: 20px;
	font-weight: 700;
	line-height: 1.5;
}

.leave-caption {
	margin-top: 6px !important;
	font-size: 13px;
	color: #7c8aa2;
}

/* 공통 카드 */
.leave-card {
	margin-top: 22px;
	border: 1px solid #dfe6ef;
	background: #fff;
}

.leave-card-head {
	min-height: 60px;
	padding: 20px 33px;
	border-bottom: 1px solid #dfe6ef;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.leave-card-title {
	font-size: 16px;
	font-weight: 700;
}

.leave-card-count {
	font-size: 13px;
	color: #748198;
}

/* 나의 휴가 현황: 네 개의 숫자 카드 */
.leave-summary-grid {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 18px;
	padding: 19px 33px 22px;
}

.leave-summary-item {
	min-height: 91px;
	border: 1px solid #dfe6ef;
	padding: 15px 21px;
}

.leave-summary-label {
	font-size: 12px;
	color: #78879d;
}

.leave-summary-bottom {
	display: flex;
	align-items: baseline;
	gap: 24px;
	margin-top: 10px;
}

.leave-summary-value {
	font-size: 25px;
	font-weight: 700;
	line-height: 1.2;
	white-space: nowrap;
}

.leave-summary-sub {
	color: #8490a5;
	font-size: 12px;
	white-space: nowrap;
}

/* 휴가 사용 내역 표 */
.leave-history-card {
	margin-top: 23px;
}

.leave-table-scroll {
	overflow-x: auto;
}

.leave-table {
	width: 100%;
	min-width: 760px;
	border-collapse: collapse;
	font-size: 13px;
}

.leave-table th {
	background: #f4f6f9;
	font-size: 13px;
	font-weight: 700;
	padding: 17px 33px;
	text-align: left;
	border-bottom: 1px solid #dfe6ef;
}

.leave-table td {
	padding: 23px 33px;
	border-bottom: 1px solid #dfe6ef;
	height: 68px;
	vertical-align: middle;
}

.leave-table th:nth-child(1), .leave-table td:nth-child(1) {
	width: 14%;
}

.leave-table th:nth-child(2), .leave-table td:nth-child(2) {
	width: 17%;
}

.leave-table th:nth-child(3), .leave-table td:nth-child(3) {
	width: 24%;
}

.leave-table th:nth-child(4), .leave-table td:nth-child(4) {
	width: 15%;
}

.leave-table th:nth-child(5), .leave-table td:nth-child(5) {
	width: 30%;
}

.leave-empty {
	text-align: center !important;
	color: #78879d;
}

.leave-note {
	margin: 52px 33px 43px !important;
	font-size: 12px;
	color: #7d8ba0;
}

/* 하단 버튼 */
.leave-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 35px;
}

.leave-button {
	min-width: 172px;
	height: 45px;
	padding: 0 18px;
	border: 1px solid #dfe6ef;
	background: #fff;
	color: #293449;
	font-size: 13px;
	cursor: pointer;
}

.leave-button-primary {
	background: #111a2f;
	border-color: #111a2f;
	color: #fff;
}

.leave-button:hover {
	background: #f6f8fb;
}

.leave-button-primary:hover {
	background: #26334d;
}

@media ( max-width : 980px) {
	.leave-summary-grid {
		grid-template-columns: repeat(2, minmax(0, 1fr));
	}
	.leave-dashboard {
		padding: 20px 28px 35px;
	}
}

@media ( max-width : 600px) {
	.leave-dashboard {
		padding: 18px 14px 30px;
	}
	.leave-card-head {
		padding: 17px;
	}
	.leave-summary-grid {
		gap: 10px;
		padding: 14px;
	}
	.leave-summary-item {
		padding: 13px;
	}
	.leave-summary-value {
		font-size: 21px;
	}
	.leave-summary-bottom {
		display: block;
	}
	.leave-summary-sub {
		display: block;
		margin-top: 8px;
		white-space: normal;
	}
	.leave-actions {
		justify-content: stretch;
	}
	.leave-button {
		flex: 1;
		min-width: 0;
	}
	.leave-note {
		margin: 30px 17px !important;
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


<script type="text/javascript">

    // 나의 휴가 잔액 조회
    const getLeaveBalance = async () => {

        try {

            const response = await fetch(
                "${pageContext.request.contextPath}/api/leave/my/balance",
                {
                    method: "GET"
                }
            );

            if (!response.ok) {
                throw new Error("휴가 현황 조회 실패: " + response.status);
            }

            const result = await response.json();

            console.log("휴가 현황 조회 결과", result);

            if (result == null) {

                $("div[name='totalDays']").text("-");
                $("div[name='usedDays']").text("-");
                $("div[name='remainingDays']").text("-");

                return;
            }

            $("div[name='totalDays']").text(result.totalDays + "일");
            $("div[name='usedDays']").text(result.usedDays + "일");
            $("div[name='remainingDays']").text(result.remainingDays + "일");

        } catch (error) {

            console.error("휴가 현황 조회 오류", error);

        }
    };


    // 로그인한 사원의 실제 휴가 사용 내역 조회
    const getMyUsedLeave = async () => {

        const tbody = $("tbody[name='leaveHistoryRows']");
        const count = $("div[name='leaveHistoryCount']");

        tbody.empty();
        count.text("조회 중");

        try {

            const response = await fetch(
                "${pageContext.request.contextPath}/api/leave/my/used",
                {
                    method: "GET"
                }
            );

            if (!response.ok) {
                throw new Error("휴가 사용 내역 조회 실패: " + response.status);
            }

            const records = await response.json();

            console.log("휴가 사용 내역 조회 결과", records);

            if (!Array.isArray(records)) {
                throw new Error("휴가 사용 내역 응답 형식 오류");
            }

            tbody.empty();

            count.text("총 " + records.length + "건");

            // 휴가 사용 내역이 없는 경우
            if (records.length === 0) {

                const tr = $("<tr>");

                $("<td>")
                    .attr("colspan", 5)
                    .addClass("leave-empty")
                    .text("사용한 휴가 내역이 없습니다.")
                    .appendTo(tr);

                tbody.append(tr);

                return;
            }

            // 휴가 사용 내역을 한 건씩 출력
            records.forEach(function(row) {

                const startDate = row.startDate || "-";
                const endDate = row.endDate || "-";

                const period = startDate === endDate
                    ? startDate
                    : startDate + " ~ " + endDate;

                const leaveType = row.leaveType || "휴가";

                const days = row.days != null
                    ? row.days + "일"
                    : "-";

                const status = row.status === "APPROVED"
                    ? "사용 완료"
                    : row.status || "-";

                const tr = $("<tr>");

                $("<td>").text(startDate).appendTo(tr);
                $("<td>").text(leaveType).appendTo(tr);
                $("<td>").text(period).appendTo(tr);
                $("<td>").text(days).appendTo(tr);
                $("<td>").text(status).appendTo(tr);

                tbody.append(tr);

            });

        } catch (error) {

            console.error("휴가 사용 내역 조회 오류", error);

            tbody.empty();
            count.text("조회 실패");

            const tr = $("<tr>");

            $("<td>")
                .attr("colspan", 5)
                .addClass("leave-empty")
                .text("휴가 사용 내역을 불러오지 못했습니다.")
                .appendTo(tr);

            tbody.append(tr);

        }
    };


    // 페이지 로딩 완료
    $(function() {

        // 휴가 현황 조회
        getLeaveBalance();

        // 실제 휴가 사용 내역 조회
        getMyUsedLeave();

        // 휴가 신청 내역 페이지 이동
        $("button[name='leaveHistoryButton']").on("click", function() {

            window.location.href =
                "${pageContext.request.contextPath}/leave/history";

        });

        // 휴가 신청 페이지 이동
        $("button[name='leaveApplyButton']").on("click", function() {

            window.location.href =
                "${pageContext.request.contextPath}/leave/apply";

        });

    });

</script>

</head>
<body>
	<div class="page-wrapper">
		
		<%@ include file="../common/sidebar.jspf"%>

		<!-- 공통 헤더/사이드바 제외. 휴가 현황 본문만 작성 -->

		<div class="main-content main-area">
		
			<%@ include file="../common/header.jspf"%>
			
			
			<section class="leave-dashboard">
				<header>
					<h2 class="leave-heading">휴가 현황</h2>
					<p class="leave-caption">부여된 휴가와 사용 및 잔여 일수를 확인할 수 있습니다.</p>
				</header>

				<!-- 1. 나의 휴가 현황 -->
				<section class="leave-card">
					<div class="leave-card-head">
						<h3 class="leave-card-title">나의 휴가 현황</h3>
					</div>

					<div class="leave-summary-grid">
						<div class="leave-summary-item">
							<div class="leave-summary-label">총 부여 일수</div>
							<div class="leave-summary-bottom">
								<div class="leave-summary-value" name="totalDays">-</div>
							</div>
						</div>

						<div class="leave-summary-item">
							<div class="leave-summary-label">사용 일수</div>
							<div class="leave-summary-bottom">
								<div class="leave-summary-value" name="usedDays">-</div>
							</div>
						</div>

						<div class="leave-summary-item">
							<div class="leave-summary-label">잔여 일수</div>
							<div class="leave-summary-bottom">
								<div class="leave-summary-value" name="remainingDays">-</div>
							</div>
						</div>


					</div>
				</section>

				<!-- 2. 휴가 사용 내역 -->
				<section class="leave-card leave-history-card">
					<div class="leave-card-head">
						<h3 class="leave-card-title">휴가 사용 내역</h3>
						<div class="leave-card-count" name="leaveHistoryCount">조회 중</div>
					</div>

					<div class="leave-table-scroll">
						<table class="leave-table">
							<thead>
								<tr>
									<th>사용일</th>
									<th>휴가 종류</th>
									<th>사용 기간</th>
									<th>사용 일수</th>
									<th>처리 상태</th>
								</tr>
							</thead>
							<!-- 현재는 화면 설계의 예시 데이터 4건 -->

							<tbody name="leaveHistoryRows">
								<tr>
									<td colspan="5" class="leave-empty">휴가 사용 내역을 불러오는 중입니다.</td>
								</tr>
							</tbody>

						</table>
					</div>

					<p class="leave-note">※ 휴가 일수는 회사 휴가 정책에 따라 산정됩니다.</p>
				</section>

				<!-- 3. 화면 이동 버튼 (기능은 나중에 연결) -->
				<div class="leave-actions">

					<button type="button" class="leave-button"
						name="leaveHistoryButton">휴가 신청 내역</button>

					<button type="button" class="leave-button leave-button-primary"
						name="leaveApplyButton">휴가 신청</button>


				</div>
			</section>
		</div>

	</div>
</body>
</html>
