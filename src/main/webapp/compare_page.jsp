<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	<h1> 제품 비교 페이지입니다.</h1>
	<!-- compare_page.jsp 는
		 detail_page.jsp 에서 특정 제품을 보다가 비교하기 버튼을 눌러 넘어 올 경우와
		 header.jsp 에서 제품 비교 버튼을 눌러 넘어온 경우가 존재
		 
		 detail_page.jsp 에서 특정 제품을 보다가 비교하기 버튼을 눌러 넘어 온 경우
		  - 이미 보고있던 제품의 phoneId 를 그대로 가져와 왼쪽에 먼저 띄운 후
		    오른쪽의 비교 제품을 선택해야함
		    
		  - 오른쪽의 비교 제품만 선택
		    
		 header.jsp 에서 제품 비교 버튼을 눌러 넘어온 경우
		  - 어떤 phoneId 값도 넘어오지 않았기 때문에
		    왼쪽, 오른쪽 두 영역의 비교 제품을 선택해야함
		    
		  - 왼쪽, 오른쪽의 비교 제품들을 선택해야함
	-->

    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />
</body>
</html>