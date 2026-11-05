
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HRMS - 사원 마이페이지</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employeehome.css">
</head>

<body class="employee-home-page">

<div class="employee-home-layout">

    <!-- 사원 전용 사이드바 -->
    <aside class="employee-home-sidebar">

        <div class="employee-home-logo">▦ HRMS Employee</div>

        <div class="employee-home-sidebar-title">
            인사관리 시스템
        </div>

        <nav class="employee-home-menu">

            <a href="${pageContext.request.contextPath}/employee/home"
               class="employee-home-menu-item active">
                01 내 정보
            </a>

            <span class="employee-home-menu-item">02 근태 관리</span>
            <span class="employee-home-menu-item">03 휴가 관리</span>
            <span class="employee-home-menu-item">04 급여 조회</span>

        </nav>
    </aside>

    <!-- 메인 영역 -->
    <div class="employee-home-main">

        <!-- 헤더 -->
        <header class="employee-home-header">
            <div class="employee-home-user" id="loginUser">
                로그인 사용자
            </div>
        </header>

        <main class="employee-home-content">

            <!-- 페이지 제목 -->
            <div class="employee-home-heading">
                <h1>마이페이지</h1>
                <p>내 인사 정보와 근무 현황을 확인할 수 있습니다.</p>
            </div>

            <!-- 상단 요약 카드 -->
            <section class="employee-home-summary">

                <div class="employee-home-summary-card">
                    <p>재직 상태</p>
                    <h2 id="summaryStatus">-</h2>
                </div>

                <div class="employee-home-summary-card">
                    <p>소속 부서</p>
                    <h2 id="summaryDept">-</h2>
                </div>

                <div class="employee-home-summary-card">
                    <p>직급</p>
                    <h2 id="summaryJob">-</h2>
                </div>

                <div class="employee-home-summary-card">
                    <p>입사일</p>
                    <h2 id="summaryHiredate">-</h2>
                </div>

            </section>

            <!-- 중간 영역 -->
            <section class="employee-home-middle">

                <!-- 내 기본 정보 -->
                <div class="employee-home-card">

                    <div class="employee-home-card-heading">

                        <h3>내 기본 정보</h3>

                        <button type="button"
                                class="employee-home-edit-btn"
                                id="editRequestBtn"
                                onclick="location.href='${pageContext.request.contextPath}/employee/myedit'">
                            정보 수정 요청
                        </button>

                    </div>

                    <div class="employee-home-info-grid">

                        <div class="employee-home-info-item">
                            <label>사번</label>
                            <span id="myEmpId">-</span>
                        </div>

                        <div class="employee-home-info-item">
                            <label>성명</label>
                            <span id="myName">-</span>
                        </div>

                        <div class="employee-home-info-item">
                            <label>이메일</label>
                            <span id="myEmail">-</span>
                        </div>

                        <div class="employee-home-info-item">
                            <label>연락처</label>
                            <span id="myPhone">-</span>
                        </div>

                        <div class="employee-home-info-item">
                            <label>부서</label>
                            <span id="myDept">-</span>
                        </div>

                        <div class="employee-home-info-item">
                            <label>직급</label>
                            <span id="myJob">-</span>
                        </div>

                    </div>

                </div>

                <!-- 바로가기 -->
                <div class="employee-home-card">

                    <h3>바로가기</h3>

                    <div class="employee-home-shortcut">
                        <strong>출퇴근 기록 조회</strong>
                        <p>일자별 출근 및 퇴근 기록</p>
                        <span>›</span>
                    </div>

                    <div class="employee-home-shortcut">
                        <strong>휴가 신청 / 내역</strong>
                        <p>휴가 신청 및 승인 상태</p>
                        <span>›</span>
                    </div>

                    <div class="employee-home-shortcut">
                        <strong>급여 명세 조회</strong>
                        <p>월별 급여 내역 확인</p>
                        <span>›</span>
                    </div>

                </div>

            </section>

            <!-- 하단 영역 -->
            <section class="employee-home-bottom">

                <!-- 최근 근태 내역 -->
                <div class="employee-home-card">

                    <h3>최근 근태 내역</h3>

                    <div class="employee-home-table-head">
                        <span>근무 일자</span>
                        <span>출근</span>
                        <span>퇴근</span>
                        <span>상태</span>
                    </div>

                    <div class="employee-home-empty"
                         id="recentAttendance">
                        근태 정보를 불러오기 전입니다.
                    </div>

                    <div class="employee-home-bottom-link">
                        근태 기록 전체 보기
                    </div>

                </div>

                <!-- 최근 휴가 신청 -->
                <div class="employee-home-card">

                    <h3>최근 휴가 신청</h3>

                    <div class="employee-home-table-head leave">
                        <span>휴가 유형</span>
                        <span>기간</span>
                        <span>승인 상태</span>
                    </div>

                    <div class="employee-home-empty"
                         id="recentLeave">
                        휴가 정보를 불러오기 전입니다.
                    </div>

                    <div class="employee-home-bottom-link">
                        휴가 신청 내역 보기
                    </div>

                </div>

            </section>

            <!-- 하단 안내 -->
            <p class="employee-home-footer">
                ※ 근태·휴가 기록은 해당 기능 연동 후 표시됩니다.
            </p>

        </main>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
    // 로그인한 사원 정보 조회
    const loadMyInfo = async () => {

        try {
            const response = await fetch(
                "${pageContext.request.contextPath}/api/employees/me"
            );

            if (!response.ok) {
                throw new Error("내 정보 조회 실패: " + response.status);
            }

            const emp = await response.json();

            // 상단 사용자
            $("#loginUser").text(emp.ename + " 사원");

            // 재직 상태
            const status = {
                ACTIVE: "재직",
                LEAVE: "휴직",
                RETIRED: "퇴직"
            }[emp.status] ?? "-";

            // 요약 카드
            $("#summaryStatus").text(status);
            $("#summaryDept").text(
                emp.department?.departmentName ?? "-"
            );
            $("#summaryJob").text(
                emp.job?.jobName ?? "-"
            );

            const hiredate = emp.hiredate
                ? new Date(emp.hiredate).toLocaleDateString("ko-KR")
                : "-";

            $("#summaryHiredate").text(hiredate);

            // 내 기본 정보
            $("#myEmpId").text(emp.empId ?? "-");
            $("#myName").text(emp.ename ?? "-");
            $("#myEmail").text(emp.email ?? "-");
            $("#myPhone").text(emp.phone ?? "-");
            $("#myDept").text(
                emp.department?.departmentName ?? "-"
            );
            $("#myJob").text(
                emp.job?.jobName ?? "-"
            );

        } catch (error) {
            console.error("마이페이지 조회 오류:", error);
        }
    };

    // 페이지 로딩 시 로그인 사원 정보 조회
    document.addEventListener("DOMContentLoaded", loadMyInfo);
</script>

</body>
</html>
