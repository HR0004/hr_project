<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.hexagon.hrproject.domain.Salary" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>

<%!
    private String text(Object value) {
        return value == null ? "" : HtmlUtils.htmlEscape(value.toString());
    }

    private String amount(BigDecimal value) {
        return value == null ? "-" : new DecimalFormat("#,##0").format(value);
    }
%>

<%
    Salary salary = (Salary) request.getAttribute("salary");
    // Controller를 거치지 않고 이 뷰를 호출한 경우에도 빈 내역을 표시하지 않는다.
    if (salary == null) {
        response.sendError(404);
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>급여 상세</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; padding: 30px 16px; font-family: sans-serif; background: #f5f6f8; color: #202833; }
        main { max-width: 760px; margin: 0 auto; padding: 28px; background: #fff; border-radius: 12px; }
        h1 { margin-top: 0; }
        .description { color: #536173; line-height: 1.6; }
        dl { margin: 24px 0; }
        .field { display: grid; grid-template-columns: 140px minmax(0, 1fr); gap: 16px; padding: 16px 0; border-bottom: 1px solid #e1e5ea; }
        dt { font-weight: bold; }
        dd { margin: 0; overflow-wrap: anywhere; }
        .money { text-align: right; font-variant-numeric: tabular-nums; }
        .net { padding: 18px 12px; background: #eef3fb; }
        .net dt, .net dd { color: #194380; font-weight: bold; }
        nav { display: flex; flex-wrap: wrap; gap: 12px; }
        a { display: inline-block; padding: 10px 16px; border: 1px solid #2457a7; border-radius: 6px; color: #2457a7; text-decoration: none; }
        .primary { background: #2457a7; color: #fff; }
        a:hover { text-decoration: underline; }
        a:focus-visible { outline: 3px solid #2457a7; outline-offset: 3px; }
        @media (max-width: 480px) {
            main { padding: 20px 16px; }
            .field { grid-template-columns: 100px minmax(0, 1fr); gap: 10px; }
        }
    </style>
</head>
<body>
    <main>
        <h1>급여 상세</h1>
        <p class="description">저장된 급여 내역입니다. 금액 단위: 원</p>
        <dl>
            <div class="field"><dt>급여 번호</dt><dd><%= text(salary.getSalaryId()) %></dd></div>
            <div class="field"><dt>사원 번호</dt><dd><%= text(salary.getEmpId()) %></dd></div>
            <div class="field"><dt>지급 연월</dt><dd><%= text(salary.getSalaryYearMonth()) %></dd></div>
            <div class="field"><dt>기본급</dt><dd class="money"><%= amount(salary.getBaseSalary()) %></dd></div>
            <div class="field"><dt>수당</dt><dd class="money"><%= amount(salary.getBonus()) %></dd></div>
            <div class="field"><dt>공제액</dt><dd class="money"><%= amount(salary.getDeduction()) %></dd></div>
            <div class="field net"><dt>실수령액</dt><dd class="money"><%= amount(salary.getNetSalary()) %></dd></div>
            <div class="field"><dt>지급일</dt><dd><%= salary.getPaymentDate() == null ? "미정" : text(salary.getPaymentDate()) %></dd></div>
        </dl>
        <nav aria-label="급여 화면 이동">
            <a class="primary" href="<%= text(request.getContextPath()) %>/salary/list">목록으로</a>
            <a href="<%= text(request.getContextPath()) %>/salary/create">급여 등록</a>
        </nav>
    </main>
</body>
</html>
