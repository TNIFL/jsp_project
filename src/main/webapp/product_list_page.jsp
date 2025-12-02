<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>

<%@ page import="java.util.*" %>
<%@ page import="com.phone.model.Phone" %>
<%@ page import="com.phone.service.PhoneService" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 리스트</title>
<link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
    <style>
    	<style>
    /* 전체 배경 & 기본 폰트 */
    body {
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #f5f6fa;
        color: #333;
    }

    /* 메인 컨테이너 */
    .list-container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 24px 28px;
        background-color: #ffffff;
        border-radius: 16px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
    }

    .list-title {
        margin: 0 0 18px;
        font-size: 24px;
        font-weight: 700;
        color: #222;
    }

    /* 필터 박스 */
    .filter-box {
        margin-bottom: 18px;
        padding: 14px 16px;
        border-radius: 12px;
        border: 1px solid #e0e4f0;
        background: linear-gradient(135deg, #f7f8ff, #fdfdff);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.03);
    }

    .filter-box form {
        display: flex;
        flex-wrap: wrap;
        gap: 10px 16px;
        align-items: center;
    }

    .filter-box label {
        font-size: 13px;
        color: #555;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .filter-box select {
        font-size: 13px;
        padding: 6px 10px;
        border-radius: 999px;
        border: 1px solid #ccd1ea;
        background-color: #fff;
        color: #333;
        outline: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.03);
        appearance: none;
        -moz-appearance: none;
        -webkit-appearance: none;
    }

    .filter-box select:focus,
    .filter-box select:hover {
        border-color: rgba(75, 108, 255, 0.9);
        box-shadow: 0 0 0 2px rgba(75, 108, 255, 0.15);
    }

    .filter-box button {
        margin-left: auto;
        padding: 7px 16px;
        border-radius: 999px;
        border: none;
        background-color: #4b6cff;
        color: #fff;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(75, 108, 255, 0.3);
        transition: background 0.2s, transform 0.1s, box-shadow 0.2s;
    }

    .filter-box button:hover {
        background-color: #3a57e0;
        transform: translateY(-1px);
        box-shadow: 0 6px 14px rgba(75, 108, 255, 0.36);
    }

    .filter-box button:active {
        transform: translateY(0);
        box-shadow: 0 3px 8px rgba(75, 108, 255, 0.3);
    }

    /* 리스트 헤더 (열 제목) */
    .list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 14px;
        margin-bottom: 6px;
        border-radius: 10px;
        background: #f0f3ff;
        border: 1px solid #d7ddff;
        font-weight: 600;
        color: #445;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .header-image-placeholder {
        width: 70px;
        height: 1px;
    }

    .header-text,
    .phone-text {
        display: grid;
        grid-template-columns: 80px 140px 60px 80px 120px;
        column-gap: 6px;
        align-items: center;
        font-size: 13px;
    }

    .header-text span {
        text-align: left;
    }

    .header-right {
        font-size: 13px;
        text-align: center;
        width: 110px;
    }

    /* 개별 제품 카드 */
    .phone-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 14px;
        margin-bottom: 8px;
        background-color: #ffffff;
        border-radius: 12px;
        border: 1px solid #e3e6f0;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.03);
        transition: transform 0.12s ease, box-shadow 0.12s ease, border-color 0.12s;
    }

    .phone-item:hover {
        transform: translateY(-2px);
        border-color: rgba(75, 108, 255, 0.6);
        box-shadow: 0 8px 18px rgba(75, 108, 255, 0.15);
    }

    .phone-left {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .phone-image {
        width: 70px;
        height: 70px;
        object-fit: cover;
        border-radius: 10px;
        border: 1px solid #d0d5e5;
        background-color: #fafafa;
    }

    .phone-text span {
        font-size: 13px;
        color: #444;
    }

    .phone-text span:nth-child(2) {
        font-weight: 600; /* 모델명 강조 */
    }

    .phone-right {
        text-align: center;
        width: 110px;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 6px;
    }

    .phone-right a {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 999px;
        border: none;
        background-color: #f3f4ff;
        color: #3d4bc0;
        font-size: 12px;
        font-weight: 600;
        text-decoration: none;
        transition: background 0.2s, color 0.2s, box-shadow 0.2s;
    }

    .phone-right a:hover {
        background-color: #3d4bc0;
        color: #fff;
        box-shadow: 0 4px 10px rgba(61, 75, 192, 0.35);
    }

    /* 점수 뱃지 색상 */
    .score-badge {
        display: inline-block;
        min-width: 36px;
        text-align: center;
        padding: 4px 8px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        color: #fff;
    }

    .score-red    { background-color: #e74c3c; }
    .score-orange { background-color: #e67e22; }
    .score-green  { background-color: #27ae60; }
    .score-blue   { background-color: #2980b9; }

    /* 페이지네이션 */
    .pagination {
        text-align: center;
        margin-top: 18px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
    }

    .pagination a,
    .pagination span {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        min-width: 30px;
        height: 30px;
        padding: 0 8px;
        border-radius: 999px;
        border: 1px solid #d0d4eb;
        background-color: #fff;
        color: #555;
        font-size: 13px;
        text-decoration: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.03);
        transition: background 0.2s, color 0.2s, box-shadow 0.2s, border-color 0.2s;
    }

    .pagination a:hover {
        background-color: #f0f3ff;
        border-color: #4b6cff;
        color: #333;
        box-shadow: 0 3px 8px rgba(75, 108, 255, 0.25);
    }

    .pagination .current {
        background-color: #4b6cff;
        border-color: #4b6cff;
        color: #fff;
        font-weight: 700;
        box-shadow: 0 4px 10px rgba(75, 108, 255, 0.36);
    }
</style>

    </style>
</head>
<body>

<%
    // 필터 파라미터
    String brandFilter = request.getParameter("brand");
    String yearFilter = request.getParameter("year");
    String priceRange = request.getParameter("priceRange");

    // null 처리
    // 에러방지
    if (brandFilter == null) brandFilter = "";
    if (yearFilter == null) yearFilter = "";
    if (priceRange == null) priceRange = "";

    // 페이징 파라미터
    // 한 페이지에 보여줄 항목의 수
    int pageSize = 7;
    // 현재 페이지 번호
    String pageParam = request.getParameter("page");
    // 시작은 1페이지
    int currentPage = 1;
    // 페이지 파라미터가 있으면 파싱
    if (pageParam != null && pageParam.length() > 0) {
        try {
        	// 공백 제거 후 파싱
            currentPage = Integer.parseInt(pageParam.trim());
        } catch (NumberFormatException e) {
        	// 파싱 실패 시 1페이지로 기본 설정
            currentPage = 1;
        }
    }

    // 전체 리스트 가져오기
    PhoneService service = new PhoneService();
    List<Phone> allPhones = service.getAllPhones();

    // 필터링
    // 조건에 맞는 폰만 걸러내기
    // 필터 조건이 비어있으면 모두 통과시킴
    // 필터링 된 결과를 담을 리스트
    List<Phone> filteredPhones = new ArrayList<Phone>();
	
    // 전체 폰 리스트 순회
    if (allPhones != null) {
        for (Phone p : allPhones) {
        	// 각 필터 조건 검사
            boolean match = true;
			
        	// 브랜드 필터 검사
            if (brandFilter.length() > 0) {
            	// 브랜드 필터가 설정되어 있으면 검사
            	// 대소문자 구분 없이 비교
            	// 브랜드가 다르면 매치 실패
            	// null 체크 포함
                if (p.getBrand() == null || !p.getBrand().equalsIgnoreCase(brandFilter)) {
                    match = false;
                }
            }
			
        	// 연식 필터 검사
        	// 연식 필터가 설정되어있으면 검사
            if (match && yearFilter.length() > 0) {
                try {
                	// 연식을 문자열로 받아왔으니 정수로 파싱
                    int yearValue = Integer.parseInt(yearFilter);
                	// 연식이 다르면 파싱 실패
                    if (p.getYearOfRelease() != yearValue) {
                        match = false;
                    }
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        	
		    // 가격대 필터 검사
		    // 가격대 필터가 설정되어있으면 검사
            if (match && priceRange.length() > 0) {
                int price = p.getPrice();
			    // 가격대 범위에 맞지 않으면 매치 실패
			    // 각 가격대 조건에 따라 검사
			    // select name="priceRange" 의 option value 형식은
			    // UNDER_600, 600_800, 800_1000, 1000_1300, OVER_1300
			    // 각각의 값들과 비교시켜 범위를 검사
			    // 만약 범위에 맞지 않으면 match 를 false 로 설정해 제외시킴
                if ("UNDER_600".equals(priceRange)) {
                    if (price > 600000) match = false;
                } else if ("600_800".equals(priceRange)) {
                    if (price <= 600000 || price > 800000) match = false;
                } else if ("800_1000".equals(priceRange)) {
                    if (price <= 800000 || price > 1000000) match = false;
                } else if ("1000_1300".equals(priceRange)) {
                    if (price <= 1000000 || price > 1300000) match = false;
                } else if ("OVER_1300".equals(priceRange)) {
                    if (price <= 1300000) match = false;
                }
            }
			// 위의 모든 필터를 통과했을 시 리스트에 추가
            if (match) {
                filteredPhones.add(p);
            }
        }
    }

    // 페이징 계산
    // 전체 항목 수 (필터링 된 후의 개수)
    int totalCount = filteredPhones.size();
    // 전체 페이지의 기본값을 1로 두어야 totalCount 0일 때 오류 방지
    int totalPages = 1;
    // totalCount 가 0보다 클 때만 페이지 수 계산
    // 만약 totalCount = 13, pageSize = 7 이면 총 페이지수는 2(13/7 = 1.xxx 반올림)
    if (totalCount > 0) {
    	// 정수끼리 나누면 13/7 = 1 이 되어버리므로
    	// double 형으로 나눈 후 Math.ceil로 올림 처리
    	// 다시 int 형으로 형변환
    	// 나머지가 있으면 한 페이지 더 생기게 함
        totalPages = (int)Math.ceil(totalCount / (double)pageSize);
    }
    // 현재 페이지 보정
    // 1보다 작으면 1로, 총 페이지 수보다 크면 총 페이지 수로 결정
    if (currentPage < 1) currentPage = 1;
    // 만약 총 페이지가 3인데 현재 페이지가 4면 총 페이지인 3으로 맞춤
    if (currentPage > totalPages) currentPage = totalPages;
	
    // 현재 페이지에서 몇번째 인덱스부터 가져올지 계산
    // 리스트 인덱스는 0 부터 시작이니
    // (현재페이지 - 1) * 페이지크기
    // 1페이지 -> 0 * 7 = 0 (0번째 인덱스부터)
    // 2페이지 -> 1 * 7 = 7 (7번째 인덱스부터)
    // 3페이지 -> 2 * 7 = 14 (14번째 인덱스부터)
    int startIndex = (currentPage - 1) * pageSize;
    // 현재 페이지에서 몇번째 인덱스까지 가져올지 계산
    // 시작 인덱스 + 페이지 크기
    // endIndex 는 subList에서 포함되지 않는 끝 인덱스
    // startIndex + pageSize 로 계산 후
    // 나중에 totalCount 를 넘기면 totalCount 로 잘라준다
    int endIndex = startIndex + pageSize;
    
    // 만약 totalCount = 10, pageSize = 7, currentPage = 2라면
    // startIndex = 7, endIndex = 14 이지만
    // 실제로 표현할 인덱스는 0~9 까지만 있으므로
    // endIndex를 totalCount(10) 으로 맞춤
    if (endIndex > totalCount) {
        endIndex = totalCount;
    }
	
    // 화면에 보여줄 현재 페이지용 리스트
    // 데이터가 없는 경우를 위해 비어있는 리스트로 시작
    List<Phone> pageList = new ArrayList<Phone>();
    // totalCount > 0 : 필터링 결과가 1개 이상 있을 때만
    // startIndex < endIndex : 유효한 범위일 때만 subList를 사용
    // 만약 totalCount == 0 이거나 startIndex == endIndex 라면
    // 보여줄게 없으니 빈 리스트를 유지
    if (totalCount > 0 && startIndex < endIndex) {
    	// subList(startIndex, endIndex)는 startIndex 부터 endIndex 전 까지
    	// 만약 startIndex = 0, endxIndex = 7 이면
    	// 0 ~ 6 의 값만
    	// filteredPhones 리스트에서 startIndex ~ (endIndex - 1) 까지만 잘라서 pageList에 저장
        pageList = filteredPhones.subList(startIndex, endIndex);
    }

    request.setAttribute("phones", pageList); 			// 현재 페이지에 보여줄 제품 목록
    request.setAttribute("currentPage", currentPage);	// 현재 페이지 번호
    request.setAttribute("totalPages", totalPages);		// 전체 페이지 수
%>

<jsp:include page="header.jsp" />

<div class="list-container">
    <h1 class="list-title">제품 리스트 페이지</h1>

    <!-- 필터 영역 -->
    <div class="filter-box">
        <form method="get" action="product_list_page.jsp">
            <label>
                브랜드:
                <select name="brand">
                    <option value="">전체</option>
                    <option value="Samsung" <c:if test="${param.brand == 'Samsung'}">selected</c:if>>삼성</option>
                    <option value="Apple"   <c:if test="${param.brand == 'Apple'}">selected</c:if>>애플</option>
                    <option value="Xiaomi"  <c:if test="${param.brand == 'Xiaomi'}">selected</c:if>>샤오미</option>
                    <option value="Google"  <c:if test="${param.brand == 'Google'}">selected</c:if>>구글</option>
                    <option value="OnePlus" <c:if test="${param.brand == 'OnePlus'}">selected</c:if>>원플러스</option>
                    <option value="Sony"    <c:if test="${param.brand == 'Sony'}">selected</c:if>>소니</option>
                    <option value="Nothing" <c:if test="${param.brand == 'Nothing'}">selected</c:if>>낫싱</option>
                    <option value="Oppo"    <c:if test="${param.brand == 'Oppo'}">selected</c:if>>오포</option>
                    <option value="ASUS"    <c:if test="${param.brand == 'ASUS'}">selected</c:if>>ASUS</option>
                    <option value="Vivo"    <c:if test="${param.brand == 'Vivo'}">selected</c:if>>비보</option>
                </select>
            </label>

            <label>
                연식:
                <select name="year">
                    <option value="">전체</option>
                    <option value="2025" <c:if test="${param.year == '2025'}">selected</c:if>>2025</option>
                    <option value="2024" <c:if test="${param.year == '2024'}">selected</c:if>>2024</option>
                    <option value="2023" <c:if test="${param.year == '2023'}">selected</c:if>>2023</option>
                </select>
            </label>

            <label>
                가격대:
                <select name="priceRange">
                    <option value="">전체</option>
                    <option value="UNDER_600"  <c:if test="${param.priceRange == 'UNDER_600'}">selected</c:if>>60만 원 이하</option>
                    <option value="600_800"    <c:if test="${param.priceRange == '600_800'}">selected</c:if>>60만 ~ 80만 원</option>
                    <option value="800_1000"   <c:if test="${param.priceRange == '800_1000'}">selected</c:if>>80만 ~ 100만 원</option>
                    <option value="1000_1300"  <c:if test="${param.priceRange == '1000_1300'}">selected</c:if>>100만 ~ 130만 원</option>
                    <option value="OVER_1300"  <c:if test="${param.priceRange == 'OVER_1300'}">selected</c:if>>130만 원 이상</option>
                </select>
            </label>

            <button type="submit">검색</button>
        </form>
    </div>

    <div class="list-header">
        <div class="header-left">
            <div class="header-image-placeholder"></div>
            <div class="header-text">
                <span>브랜드</span>
                <span>모델명</span>
                <span>연식</span>
                <span>저장공간</span>
                <span>출시 가격</span>
            </div>
        </div>
        <div class="header-right">
            점수 / 상세
        </div>
    </div>

    <!-- 실제 제품 리스트 -->
    <!-- 스크립틀릿에서 가져온 phone 객체의 필드를 p 라는 이름으로 조회 -->
    <!-- 여기서
    	 c: 는 조건, 반복, 변수 설정등의 제어문
    	 fmt: 는 숫자, 날짜의 형식변환 -->
   	<!-- for 반복문 -->
    <c:forEach var="p" items="${phones}">
        <div class="phone-item">
            <div class="phone-left">
            	<!-- 제품 이미지 가져오기 만약 제품 이미지의 경로가 없으면 default.jpg 로 가져온다 -->
                <img src="${pageContext.request.contextPath}/images/${empty p.imagePath ? 'default.jpg' : p.imagePath}"
                     alt="${p.model}" class="phone-image">
				<!-- ${ex} 표현은 jsp 에서 java 의 값을 출력하거나 비교할 때 사용
					 getter 메서드를 자동 호출 (${p.brand} -> p.getBrand()) -->
                <div class="phone-text">
                    <span>${p.brand}</span>
                    <span>${p.model}</span>
                    <span>${p.yearOfRelease}</span>
                    <span>${p.storage}GB</span>
                    <!-- fmt:formatNumber 는 숫자를 천 단위로 , 를 찍어줌
                    		 10000 -> 10,000 -->
                    <span>
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> 원
                    </span>
                </div>
            </div>

            <div class="phone-right">
            	<!-- c:set 은 변수를 선언하고 값 저장함
            		 p.score 값을 jsp 변수 score에 저장하여 조건문에 사용 -->
                <c:set var="score" value="${p.score}" />
                <!-- c:choose, c:when, c:otherwise 는 
                	 if / else if / else 와 동일 -->
                <c:choose>
                    <c:when test="${score <= 50}">
                        <span class="score-badge score-red">${score}</span>
                    </c:when>
                    <c:when test="${score <= 70}">
                        <span class="score-badge score-orange">${score}</span>
                    </c:when>
                    <c:when test="${score <= 90}">
                        <span class="score-badge score-green">${score}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="score-badge score-blue">${score}</span>
                    </c:otherwise>
                </c:choose>

                <a href="detail_page.jsp?phoneId=${p.phoneId}">제품 보기</a>
            </div>
        </div>
    </c:forEach>

    <div class="pagination">
        <c:forEach var="pnum" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${pnum == currentPage}">
                    <span class="current">${pnum}</span>
                </c:when>
                <c:otherwise>
                    <a href="product_list_page.jsp?page=${pnum}&brand=${param.brand}&year=${param.year}&priceRange=${param.priceRange}">
                        ${pnum}
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>
