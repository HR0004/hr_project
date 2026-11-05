<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.hexagon.hrproject.domain.Salary" %>
<%@ page import="org.springframework.web.util.HtmlUtils" %>
<%@ page import="java.net.URLEncoder" %>

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
    String filterMonth = (String) request.getAttribute("salaryYearMonth");
    String employeeKeyword = (String) request.getAttribute("employeeKeyword");
    if (filterMonth == null) filterMonth = "";
    if (employeeKeyword == null) employeeKeyword = "";
    boolean searchApplied = !filterMonth.isEmpty() || !employeeKeyword.isEmpty();
    boolean invalidMonth = !filterMonth.isEmpty()
            && !filterMonth.matches("[0-9]{4}-(0[1-9]|1[0-2])");
    Object searchError = request.getAttribute("salarySearchError");
    String searchQuery = "";
    if (!filterMonth.isEmpty())
        searchQuery = "?salaryYearMonth=" + URLEncoder.encode(filterMonth, "UTF-8");
    if (!employeeKeyword.isEmpty())
        searchQuery += (searchQuery.isEmpty() ? "?" : "&")
                + "employeeKeyword=" + URLEncoder.encode(employeeKeyword, "UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>급여 대장</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            white-space: nowrap;
        }
        th {
            background: #f3f5f7;
        }
        .money {
            text-align: right;
            font-variant-numeric: tabular-nums;
        }
        .employee-name {
            min-width: 100px;
            white-space: normal;
            overflow-wrap: anywhere;
        }
        .salary-actions {
            display: flex;
            justify-content: flex-end;
            margin: 20px 0 12px;
        }
        .create-link {
            display: inline-block;
            padding: 10px 16px;
            border-radius: 6px;
            background: #2457a7;
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        .create-link:hover {
            background: #194380;
        }
        .create-link:focus-visible, .table-scroll:focus-visible {
            outline: 3px solid #2457a7;
            outline-offset: 3px;
        }
        .table-scroll {
            overflow-x: auto;
        }
        .salary-search {
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end;
            gap: 12px;
            padding: 16px;
            background: #f3f5f7;
            border-radius: 8px;
        }
        .search-field { display: flex; flex-direction: column; gap: 6px; }
        .search-field label { font-weight: bold; }
        .search-field input {
            box-sizing: border-box;
            max-width: 100%;
            padding: 10px;
            border: 1px solid #8a96a3;
            border-radius: 4px;
            font: inherit;
        }
        .search-field input[aria-invalid="true"] { border: 2px solid #b42318; }
        .search-actions { display: flex; align-items: center; gap: 12px; }
        .search-actions button { padding: 10px 16px; font: inherit; cursor: pointer; }
        .search-actions a { color: #194380; padding: 10px 0; }
        .search-error { padding: 12px; border: 1px solid #b42318; color: #8a1c13; background: #fff4f2; }
        .result-count { color: #536173; }
        @media (max-width: 600px) {
            body {
                margin: 16px;
            }
            .search-field, .search-field input { width: 100%; }
        }
    </style>
</head>
<body>
    <h1>급여 대장</h1>
    <p>인사 관리자용 급여 목록입니다. 금액 단위: 원</p>
    <p>급여 번호를 누르면 상세 내역을 볼 수 있습니다.</p>

    <form class="salary-search" role="search" aria-label="급여 검색" method="get"
          action="<%= text(request.getContextPath()) %>/salary/list">
        <div class="search-field">
            <label for="filterMonth">지급 연월</label>
            <input id="filterMonth" name="salaryYearMonth" type="<%= invalidMonth ? "text" : "month" %>"
                   placeholder="yyyy-MM" value="<%= text(filterMonth) %>" aria-invalid="<%= invalidMonth %>">
        </div>
        <div class="search-field">
            <label for="employeeKeyword">사원 이름·번호</label>
            <input id="employeeKeyword" name="employeeKeyword" type="text" maxlength="50"
                   placeholder="이름 일부 또는 사원 번호" value="<%= text(employeeKeyword) %>"
                   aria-invalid="<%= employeeKeyword.length() > 50 %>">
        </div>
        <div class="search-actions">
            <button type="submit">조회</button>
            <a id="resetSearch" href="<%= text(request.getContextPath()) %>/salary/list">초기화</a>
        </div>
    </form>
    <% if (searchError != null) { %>
    <p class="search-error" role="alert"><%= text(searchError) %></p>
    <% } else { %>
    <p class="result-count"><%= searchApplied ? "검색 결과" : "전체" %>: <%= salaries == null ? 0 : salaries.size() %>건</p>
    <% } %>

    <nav class="salary-actions" aria-label="급여 작업">
        <a class="create-link"
           href="${pageContext.request.contextPath}/salary/create">급여 등록</a>
    </nav>

    <div class="table-scroll" role="region" aria-label="급여 목록" tabindex="0">
    <table>
        <thead>
            <tr>
                <th scope="col">급여 번호</th>
                <th scope="col">사원 번호</th>
                <th scope="col">사원 이름</th>
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
                    <td colspan="9">
                        <%= searchError != null ? "검색 조건을 수정하고 다시 조회하세요."
                                : searchApplied ? "검색 조건에 맞는 급여 내역이 없습니다."
                                : "등록된 급여 내역이 없습니다." %>
                    </td>
                </tr>
            <% } else { %>
                <% for (Salary salary : salaries) { %>
                    <tr>
                        <td>
                            <a href="<%= text(request.getContextPath()) %>/salary/detail/<%= text(salary.getSalaryId()) %><%= text(searchQuery) %>"
                               aria-label="급여 <%= text(salary.getSalaryId()) %>번 상세 보기"><%= text(salary.getSalaryId()) %></a>
                        </td>
                        <td><%= text(salary.getEmpId()) %></td>
                        <td class="employee-name"><%= text(salary.getEmployeeName() == null
                                || salary.getEmployeeName().trim().isEmpty()
                                ? "이름 미등록" : salary.getEmployeeName()) %></td>
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
    </div>
</body>
</html>
