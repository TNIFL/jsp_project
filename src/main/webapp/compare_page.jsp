<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가성비 비교</title>
</head>
<body>
<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	<h2>📱 가성비 비교</h2>
	
	<table border="1" cellspacing="0" cellpadding="5">
	<tr>
		<th>브랜드</th>
		<th>모델명</th>
		<th>연식</th>
		<th>최종 성능</th>
		<th>가격</th>
		<th>제품 보기</th>
	</tr>
	<!-- JSTL 반복문 -->
    <c:forEach var="p" items="${phones}">
        <tr>
            <td>${p.brand}</td>
            <td>${p.model}</td>
            <td>${p.year}</td>
            <td>${p.performance}</td>
            <td>${p.price}</td>
            <td>
                <form action="detail_page.jsp" method="get" style="margin:0;">
                    <input type="hidden" name="id" value="${p.id}">
                    <input type="submit" value="제품 보기">
                </form>
            </td>
        </tr>
    </c:forEach>

	</table>
	
	<div style="margin-top: 20px;">
    <button>1</button>
    <button>2</button>
    <button>3</button>
    <button>4</button>
    <button>5</button>
</div>

    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />
</body>
</html>