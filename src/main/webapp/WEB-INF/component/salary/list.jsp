<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.hexagon.ssangwoo.domain.Salary" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>

<%!
    // 문자를 화면에 안전하게 표시
    private String text(Object value) {
        return value == null
                ? ""
                : HtmlUtils.htmlEscape(value.toString());
    }

    // 금액에 천 단위 쉼표 표시
    private String amount(BigDecimal value) {
        return value == null
                ? "-"
                : new DecimalFormat("#,##0").format(value);
    }
%>

<%
    // Controller가 전달한 급여 목록
    @SuppressWarnings("unchecked")
    List<Salary> salaries =
            (List<Salary>) request.getAttribute("salaries");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>급여 대장</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background: #f3f5f7;
        }
        .money {
            text-align: right;
        }
    </style>
</head>
<body>
    <h1>급여 대장</h1>
    <p>인사 관리자용 급여 목록입니다. 금액 단위: 원</p>

    <table>
        <thead>
            <tr>
                <th scope="col">급여 번호</th>
                <th scope="col">사원 번호</th>
                <th scope="col">지급 연월</th>
                <th scope="col">기본급</th>
                <th scope="col">수당</th>
                <th scope="col">공제액</th>
                <th scope="col">실수령액</th>
                <th scope="col">지급일</th>
            </tr>
        </thead>
        <tbody>
            <% if (salaries == null || salaries.isEmpty()) { %>
                <tr>
                    <td colspan="8">
                        등록된 급여 내역이 없습니다.
                    </td>
                </tr>
            <% } else { %>
                <% for (Salary salary : salaries) { %>
                    <tr>
                        <td><%= text(salary.getSalaryId()) %></td>
                        <td><%= text(salary.getEmpId()) %></td>
                        <td><%= text(salary.getSalaryYearMonth()) %></td>
                        <td class="money">
                            <%= amount(salary.getBaseSalary()) %>
                        </td>
                        <td class="money">
                            <%= amount(salary.getBonus()) %>
                        </td>
                        <td class="money">
                            <%= amount(salary.getDeduction()) %>
                        </td>
                        <td class="money">
                            <%= amount(salary.getNetSalary()) %>
                        </td>
                        <td>
                            <%= salary.getPaymentDate() == null
                                    ? "미정"
                                    : text(salary.getPaymentDate()) %>
                        </td>
                    </tr>
                <% } %>
            <% } %>
        </tbody>
    </table>
</body>
</html>