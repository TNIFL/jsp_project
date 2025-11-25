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
        <div class="p-5 mb-4 bg-light rounded-3 text-center shadow-sm">
            <h1 class="display-5 fw-bold">제품 비교 사이트</h1>
            <p class="fs-4">전자 제품을 쉽고 빠르게 비교할 수 있는 플랫폼입니다.</p>
            <a href="compare.jsp" class="btn btn-primary btn-lg mt-3">제품 비교 시작하기</a>
        </div>
    </div>

   
    <div class="container py-5">
        <h2 class="mb-4 text-center">🎉 12월 이벤트 정보 🎉</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <img src="images/test-taker.png" class="card-img-top" alt="수험생 할인">
                    <div class="card-body text-center">
                        <h5 class="card-title">수험생 할인</h5>
                        <p class="card-text">수험표 제출 시 특별 할인 혜택을 드립니다.</p>
                        <a href="event_exam.jsp" class="btn btn-outline-primary">자세히 보기</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <img src="images/Existing_device.png" class="card-img-top" alt="기존 기기 할인">
                    <div class="card-body text-center">
                        <h5 class="card-title">기존 기기 할인</h5>
                        <p class="card-text">사용하던 기기를 반납하면 추가 할인!</p>
                        <a href="event_device.jsp" class="btn btn-outline-primary">자세히 보기</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <img src="images/christmas.png" class="card-img-top" alt="크리스마스 할인">
                    <div class="card-body text-center">
                        <h5 class="card-title">크리스마스 이벤트</h5>
                        <p class="card-text">12/22 ~ 12/26 크리스마스 특별 할인!</p>
                        <a href="event_christmas.jsp" class="btn btn-outline-primary">자세히 보기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>