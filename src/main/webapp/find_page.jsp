<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>

<%@ page import="com.phone.service.PhoneService" %>
<%@ page import="com.phone.model.Phone" %>
<%@ page import="java.util.*" %>

<%
    PhoneService service = new PhoneService();
    request.setAttribute("phones", service.getAllPhones());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가성비 비교</title>

<!-- ★ 페이지 내부에서만 적용되는 간단한 꾸미기 -->
<style>
    /* 전체 영역 정렬 */
    .wrapper {
        width: 900px;
        margin: 30px auto;
    }

    h2 {
        margin-bottom: 15px;
        text-align: center;
        font-size: 26px;
    }

    /* 표 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    }

    th {
        background: #6677ff;
        color: white;
        padding: 12px;
        font-weight: bold;
    }

    td {
        padding: 10px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    tr:hover {
        background: #f4f6ff;
    }

    .detail-btn {
        display: inline-block;
        padding: 6px 12px;
        background: #6677ff;
        color: white;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
    }

    .detail-btn:hover {
        background: #5565ee;
    }
</style>

</head>

<body>

<jsp:include page="header.jsp" />

<div class="wrapper">

    <h2>📱 가성비 찾기</h2>

    <table>
        <thead>
            <tr>
                <th>브랜드</th>
                <th>모델명</th>
                <th>연식</th>
                <th>최종 성능</th>
                <th>가격</th>
                <th>제품 보기</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="p" items="${phones}">
                <tr>
                    <td>${p.brand}</td>
                    <td>${p.model}</td>
                    <td>${p.yearOfRelease}</td>

                    <td>
                        <%
                            com.phone.model.Phone phoneObj =
                                (com.phone.model.Phone) pageContext.findAttribute("p");

                            double score = (phoneObj.getRam() * 2)
                                         + (phoneObj.getBattery() / 1000.0)
                                         - (phoneObj.getWeight() / 50.0);

                            out.print(String.format("%.2f", score));
                        %>
                    </td>

                    <td>
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> 원
                    </td>

                    <td>
                        <a class="detail-btn" href="detail_page.jsp?id=${p.phoneId}">
                            상세보기
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>
