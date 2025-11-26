<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인</title>
</head>
<body>
<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	<h1>메인 페이지입니다.</h1>
    <div>
        <h1>제품 비교 사이트</h1>
        <p>전자 제품을 비교하는 사이트입니다.</p>
    </div>
    
    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />
</body>
</html>


<!-- 

각자 역할 (11/05)
장성우 : 커뮤니티(유동관 서브), 가성비 찾기 제작
유동관 : base 제작, 로직구현, 제품 리스트, 제품 상세페이지, 제품 비교
이한솔 : 디자인 구현, 로직구현, 메인페이지, 로그인, 로그아웃, 회원가입

 -->