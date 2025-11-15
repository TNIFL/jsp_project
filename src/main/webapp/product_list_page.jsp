<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<jsp:useBean id="phone" class="com.phone.model.Phone" scope="request" />
<%@ page import="java.util.*" %>
<%@ page import="com.phone.model.Phone" %>
<%@ page import="com.phone.service.PhoneService" %>
   
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

	PhoneService service = new PhoneService();
	request.setAttribute("phones", service.getAllPhones());

%>
<jsp:include page="header.jsp" />
<h1>제품 리스트 페이지입니다.</h1>
	<div class="main-section">
    <div class="list-section">
        <div class="product-item">
             <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>브랜드</th>
                        <th>모델명</th>
                        <th>출시연도</th>
                        <th>가격 (원)</th>
                        <th>저장공간 (GB)</th>
                        <th>RAM (GB)</th>
                        <th>배터리 (mAh)</th>
                        <th>화면 크기 (인치)</th>
                        <th>무게 (g)</th>
                        <th>프로세서</th>
                        <th>디스플레이 정보</th>
                        <th>카메라 정보</th>
                        <th>연결성</th>
                        <th>특수 기능</th>
                        <th>크기</th>
                        <th>상세보기</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${phones}">
                        <tr>
                            <td>${p.phoneId}</td>
                            <td>${p.brand}</td>
                            <td>${p.model}</td>
                            <td>${p.yearOfRelease}</td>
                            <td>
                                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>
                            </td>
                            <td>${p.storage}</td>
                            <td>${p.ram}</td>
                            <td>${p.battery}</td>
                            <td>${p.displayInch}</td>
                            <td>${p.weight}</td>
                            <td>${p.processor}</td>
                            <td>${p.displayInfo}</td>
                            <td>${p.cameraInfo}</td>
                            <td>${p.connectivity}</td>
                            <td>${p.specialFeatures}</td>
                            <td>${p.size}</td>
                            <td>
                                <!-- 나중에 상세 페이지 만들면 링크 연결 -->
                                <a href="controller.jsp?action=detail&phoneId=${p.phoneId}">
                                    상세보기
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>