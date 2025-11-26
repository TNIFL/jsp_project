<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.phone.service.PhoneService" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 상세 페이지</title>

    <style>
    	/* 알아보기 쉽게만 스타일링 했음 */
    	/* 맘대로 고치셔요 */
        body {
            font-family: Arial, sans-serif;
            font-size: 14px;
        }
        .detail-wrapper {
            max-width: 960px;
            margin: 20px auto;
            border: 1px solid #ddd;
            padding: 16px 24px;
            background-color: #fafafa;
        }
        .detail-header {
            margin-bottom: 16px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }
        .detail-header h1 {
            margin: 0 0 4px 0;
            font-size: 20px;
        }

        /* 상단 레이아웃: 왼쪽 이미지, 오른쪽 요약 박스 */
        .top-section {
            display: flex;
            gap: 24px;
            margin-bottom: 16px;
        }
        .detail-image {
            flex: 0 0 280px;
            text-align: center;
            border: 1px solid #ddd;
            padding: 8px;
            background-color: #fff;
        }
        .detail-image img {
            width: 260px;
            height: 260px;
            object-fit: cover;
        }
        .summary-box {
            flex: 1;
            border: 1px solid #ddd;
            background-color: #fff;
        }
        .summary-title {
            border-bottom: 1px solid #ddd;
            padding: 8px 12px;
            font-weight: bold;
        }
        .summary-spec {
            padding: 8px 12px;
        }
        .summary-spec table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        .summary-spec th,
        .summary-spec td {
            border: 1px solid #eee;
            padding: 6px 8px;
            text-align: left;
        }
        .summary-spec th {
            width: 120px;
            background-color: #f7f7f7;
        }

        /* 중간 버튼 영역 (제품 상세 / 비교하기) */
        .middle-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 12px 0;
        }

        .btn {
            display: inline-block;
            padding: 6px 14px;
            font-size: 13px;
            border: 1px solid #555;
            background-color: #e0e0ff;
            text-decoration: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #d0d0ff;
        }

        /* 상세 내용 박스 (토글) */
        .detail-box {
            border: 1px solid #ddd;
            background-color: #fff;
            padding: 12px 14px;
            margin-bottom: 16px;
            display: none; /* 버튼 눌렀을 때 보여주기 */
        }
        .detail-box p {
            margin: 3px 0;
        }
        .label {
            font-weight: bold;
        }

        /* 맨 아래 리스트로 돌아가기 버튼 */
        .bottom-section {
            text-align: center;
            margin-top: 8px;
        }
    </style>

    <script>
        function toggleDetailBox() {
            var box = document.getElementById("detailBox");
            if (!box) return;
            if (box.style.display === "none" || box.style.display === "") {
                box.style.display = "block";
            } else {
                box.style.display = "none";
            }
        }
    </script>
</head>
<body>
<%
    // 제품 상세 페이지용 phoneId 파라미터 처리
    String param = request.getParameter("phoneId");
    int phoneId = 0;
	
    // param이 빈 값이 아닐 때
    if (param != null && !param.isEmpty()) {
        try {
        	// phoneId 에 param 을 정수로 변환 후 저장
            phoneId = Integer.parseInt(param);
        } catch (NumberFormatException e) {
            phoneId = 0;
            e.printStackTrace();
        }
    }
	
    PhoneService phoneService = new PhoneService();
    // 한개의 핸드폰을 가져옴(phoneId로 조회하여)
    request.setAttribute("phone", phoneService.getPhoneById(phoneId));
%>

<jsp:include page="header.jsp" />

<div class="detail-wrapper">
    <div class="detail-header">
        <h1>제품 상세 페이지</h1>
        <p>선택한 제품 ID: <strong><%= phoneId %></strong></p>
    </div>
	<!-- c:choose, c:when, c:otherwise 는 
		 if / else if / else 와 동일 -->
	<!-- test가 비어있지 않을 때 -->
    <c:choose>
        <c:when test="${not empty phone}">
            <!-- 상단: 이미지 + 요약 성능 표 -->
            <div class="top-section">
                <!-- 왼쪽: 제품 이미지 -->
                <div class="detail-image">
                	<!-- db에 저장된 이미지파일의 경로를 가져옴 만약 없다면 default.jpg 로 설정 -->
                    <img src="${pageContext.request.contextPath}/images/${empty phone.imagePath ? 'default.jpg' : phone.imagePath}"
                         alt="${phone.model}">
                </div>

                <!-- 오른쪽: 제품 명/연식 + 주요 성능 표 -->
                <div class="summary-box">
                    <div class="summary-title">
                        ${phone.brand} ${phone.model} (${phone.yearOfRelease})
                    </div>
                    <div class="summary-spec">
                        <table>
                            <tr>
                                <th>가격</th>
                                <td>
                                	<!-- fmt:formatNumber 는 숫자를 천 단위로 , 를 찍어줌
                    					 10000 -> 10,000 -->
                                    <fmt:formatNumber value="${phone.price}" type="number" groupingUsed="true"/> 원
                                </td>
                            </tr>
                            <tr>
                                <th>저장공간 / RAM</th>
                                <td>${phone.storage}GB / ${phone.ram}GB</td>
                            </tr>
                            <tr>
                                <th>디스플레이</th>
                                <td>${phone.displayInch}인치, ${phone.displayInfo}</td>
                            </tr>
                            <tr>
                                <th>카메라</th>
                                <td>${phone.cameraInfo}</td>
                            </tr>
                            <tr>
                                <th>배터리</th>
                                <td>${phone.battery}mAh</td>
                            </tr>
                            <tr>
                                <th>프로세서</th>
                                <td>${phone.processor}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 중간: 제품 상세 / 비교하기 버튼들 -->
            <div class="middle-section">
                <button type="button" class="btn" onclick="toggleDetailBox()">제품 상세</button>

                <!-- 비교하기 버튼: compare_page.jsp는 나중에 구현할 페이지 이름에 맞춰서 수정 -->
                <button type="button" class="btn"
                        onclick="location.href='compare_page.jsp?phoneId=${phone.phoneId}'">
                    비교하기
                </button>
            </div>

            <!-- 제품 상세 버튼 클릭 시 열리는 상세 내용 박스 -->
            <div id="detailBox" class="detail-box">
                <p><span class="label">브랜드:</span> ${phone.brand}</p>
                <p><span class="label">모델명:</span> ${phone.model}</p>
                <p><span class="label">출시연도:</span> ${phone.yearOfRelease}</p>
                <p><span class="label">가격 (원):</span>
                	<!-- fmt:formatNumber 는 숫자를 천 단위로 , 를 찍어줌
                    	 10000 -> 10,000 -->
                    <fmt:formatNumber value="${phone.price}" type="number" groupingUsed="true"/>
                </p>
                <p><span class="label">저장공간 (GB):</span> ${phone.storage}</p>
                <p><span class="label">RAM (GB):</span> ${phone.ram}</p>
                <p><span class="label">배터리 (mAh):</span> ${phone.battery}</p>
                <p><span class="label">화면 크기 (인치):</span> ${phone.displayInch}</p>
                <p><span class="label">무게 (g):</span> ${phone.weight}</p>
                <p><span class="label">디스플레이 정보:</span> ${phone.displayInfo}</p>
                <p><span class="label">카메라 정보:</span> ${phone.cameraInfo}</p>
                <p><span class="label">연결성:</span> ${phone.connectivity}</p>
                <p><span class="label">특수 기능:</span> ${phone.specialFeatures}</p>
                <p><span class="label">크기:</span> ${phone.size}</p>
                <p><span class="label">상세 설명:</span> ${phone.detail_description}</p>
            </div>

            <!-- 하단: 제품 리스트로 돌아가기 -->
            <div class="bottom-section">
                <button type="button" class="btn"
                        onclick="location.href='product_list_page.jsp'">
                    제품 리스트 보러가기
                </button>
            </div>
        </c:when>

        <c:otherwise>
            <p>해당 제품을 찾을 수 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
