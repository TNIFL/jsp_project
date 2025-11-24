<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>메인</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
</head>
<body>
<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	    <div class="container py-5">
        
<div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
                <h1>제품 비교 사이트</h1>
                <p class="col-md-8 fs-4">전자 제품을 비교하는 사이트 입니다.</p>
            </div>
        </div>
    </div>
    <h1 class ="margin-590">12월 이벤트 정보</h1>
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<img class ="margin-40"src="images/test-taker.png" alt="수험생 할인" width="400" height="150">
		<img class ="margin-20" src="images/Existing_device.png" alt="기존 기기 할인" width="400" height="150">
		<img class ="margin-20" src="images/christmas.png" alt="크리스머스 할인" width="400" height="150">
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>