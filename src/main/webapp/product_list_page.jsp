<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<jsp:useBean id="phone" class="com.phone.model.Phone" scope="request" />
<%@ page import="java.util.*" %>
<%@ page import="com.phone.model.Phone" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//제품 리스트 페이지
//리스트에 보여줄 것
//- 브랜드, 모델명, 연식, 최종성능, 가격
//- 제품 상세보기 버튼(링크)
// jstl 사용해 데이터 노출
	java.util.List<String> items = java.util.Arrays.asList("A", "B", "C");
    request.setAttribute("items", items);
%>
<jsp:include page="header.jsp" />
<h1>제품 리스트 페이지입니다.</h1>
	<div class="main-section">
		<div class="list-section">
			<div class="product-item">
			    <table border="1">
			    	<tr>
			    	    <th>브랜드</th>
                		<th>모델명</th>
                		<th>연식</th>
                		<th>최종성능</th>
                		<th>가격</th>
                		<th>상세보기</th>
			    	</tr>
			    </table>
			</div>
		</div>
	</div>
	<h3>JSTL 리스트 출력 예제</h3>
	<c:forEach var="x" items="${items}">
	    <li>${x}</li>
	</c:forEach>
<jsp:include page="footer.jsp" />
</body>
</html>