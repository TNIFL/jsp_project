<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.phone.dao.PhoneDao" %>
<%@ page import="com.phone.model.Phone" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가성비 비교</title>
</head>
<body>

<jsp:include page="header.jsp" />

<h2>📱 가성비 비교</h2>

<%
    PhoneDao dao = new PhoneDao();
    List<Phone> phones = dao.getAllPhones();  // DB에서 전체 리스트 불러오기
%>

<table border="1" cellspacing="0" cellpadding="5">
    <tr>
        <th>브랜드</th>
        <th>모델명</th>
        <th>연식</th>
        <th>성능 점수</th>
        <th>가격</th>
        <th>제품 보기</th>
    </tr>

<%
    for (Phone p : phones) {
        // 성능 점수 예시 계산
        double score = (p.getRam() * 2) + (p.getBattery() / 1000.0) - (p.getWeight() / 50.0);
%>

    <tr>
        <td><%= p.getBrand() %></td>
        <td><%= p.getModel() %></td>
        <td><%= p.getYearOfRelease() %></td>
        <td><%= String.format("%.2f", score) %></td>
        <td><%= p.getPrice() %> 원</td>
        <td>
            <form action="phone_detail.jsp" method="get">
                <input type="hidden" name="id" value="<%= p.getPhoneId() %>">
                <button type="submit">제품 보기</button>
            </form>
        </td>
    </tr>

<%
    }
%>
</table>

<jsp:include page="footer.jsp" />

</body>
</html>
