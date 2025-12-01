<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>

<%@ page import="com.phone.service.PhoneService" %>
<%@ page import="com.phone.model.Phone" %>
<%@ page import="java.util.*" %>

<%
    // 1. 서비스 호출하여 목록 가져오기
    PhoneService service = new PhoneService();
    List<Phone> list = service.getAllPhones();
    
    // 2. request 영역에 담기 (JSTL에서 쓰기 위함)
    request.setAttribute("phones", list);
    
    int pageSize = 7;
    int currentPage = 1;
    String pageParam = request.getParameter("page");
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
    String priceRange = request.getParameter("priceRange");
    
    // 빈 filteredPhones 리스트를 만들어서 가격 필터링 한 결과를 노출시킨다
    List<Phone> filteredPhones = new ArrayList<Phone>();
    
    if (list != null) {
    	for (Phone p : list) {
			boolean match = true;
			
			 if (priceRange != null && !priceRange.isEmpty()) {
	            if (p.getPrice() == 0) {
	                match = false;
	            }
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
    		if (match) {
    			filteredPhones.add(p);
    		}
    		// **정렬 추가: score 내림차순**
            Collections.sort(filteredPhones, new Comparator<Phone>() {
                @Override
                public int compare(Phone p1, Phone p2) {
                    // score가 int라고 가정
                    return Integer.compare(p2.getScore(), p1.getScore());
                }
            });
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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가성비 비교</title>
<!-- 팀원 공통 CSS 연결 -->
<link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
<style>
    /* 팀원 CSS(.container)와 내 스타일(.wrapper) 합치기 */
    .wrapper {
        margin: 40px auto;
        width: 100%;
        max-width: 1000px; /* 테이블이 넓으니 폭을 좀 넓게 */
    }

    h2 {
        margin-bottom: 20px;
        text-align: center;
        font-size: 28px;
        color: #333;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
        background: white;
        border-radius: 8px;
        overflow: hidden; /* 둥근 모서리 적용 */
        box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    th {
        background: rgba(102, 102, 255, 0.9); /* 팀원 메뉴 색상과 비슷하게 */
        color: white;
        padding: 15px;
        font-weight: bold;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid #eee;
        text-align: center;
        color: #555;
    }

    tr:hover {
        background: #f8f9fa; /* 마우스 올렸을 때 살짝 회색 */
    }

    /* 상세보기 버튼 */
    .detail-btn {
        display: inline-block;
        padding: 6px 14px;
        background: #4a90e2;
        color: white;
        border-radius: 20px;
        text-decoration: none;
        font-size: 13px;
        font-weight: bold;
        transition: background 0.2s;
    }

    .detail-btn:hover {
        background: #357abd;
    }
    
    .score-badge {
       display: inline-block;
       min-width: 32px;
       text-align: center;
       padding: 4px 6px;
       margin-bottom: 4px;
       border-radius: 4px;
       font-size: 12px;
       font-weight: bold;
       color: #fff;
   }
    .score-red    { background-color: #e74c3c; }
    .score-orange { background-color: #e67e22; }
    .score-green  { background-color: #27ae60; }
    .score-blue   { background-color: #2980b9; }
	    /* 페이지네이션 영역 */
	.pagination {
	    margin: 20px auto 0;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    gap: 6px;
	    font-size: 14px;
	}
	
	/* 각 페이지 번호 공통 스타일 */
	.pagination a,
	.pagination span {
	    display: inline-flex;
	    justify-content: center;
	    align-items: center;
	    min-width: 32px;
	    height: 32px;
	    padding: 0 10px;
	    border-radius: 16px;
	    border: 1px solid #ddd;
	    background-color: #fff;
	    color: #555;
	    text-decoration: none;
	    box-shadow: 0 0 4px rgba(0,0,0,0.04);
	    transition: background-color 0.2s, color 0.2s, box-shadow 0.2s, border-color 0.2s;
	}
	
	/* 마우스 올렸을 때 */
	.pagination a:hover {
	    background-color: #f0f4ff;
	    border-color: rgba(102, 102, 255, 0.7);
	    color: #333;
	    box-shadow: 0 0 6px rgba(102,102,255,0.25);
	}
	
	/* 현재 페이지 */
	.pagination .current {
	    background: rgba(102, 102, 255, 0.9);
	    border-color: rgba(102, 102, 255, 0.9);
	    color: #fff;
	    font-weight: bold;
	    box-shadow: 0 0 6px rgba(102,102,255,0.35);
	}
	
	/* 페이지네이션 영역 전체를 살짝 위와 분리 */
	.pagination-wrapper {
	    margin-top: 16px;
	    text-align: center;
	}
	/* 필터 영역(제목 + 셀렉트 + 버튼) */
	.filter-bar {
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	    gap: 12px;
	    margin-bottom: 16px;
	}
	
	/* 제목은 왼쪽 정렬 느낌으로 살짝 여유 */
	.filter-title {
	    margin: 0;
	    font-size: 22px;
	    font-weight: 600;
	    color: #333;
	}
	
	/* 셀렉트 + 버튼 묶음 오른쪽 정렬 */
	.filter-controls {
	    display: flex;
	    align-items: center;
	    gap: 8px;
	}
	
	/* 가격 셀렉트 공통 스타일 */
	.filter-select {
	    min-width: 180px;
	    padding: 8px 12px;
	    border-radius: 999px;
	    border: 1px solid #ddd;
	    background-color: #fff;
	    font-size: 14px;
	    color: #555;
	    outline: none;
	    box-shadow: 0 0 4px rgba(0,0,0,0.03);
	    appearance: none;              /* 기본 화살표 숨기기(브라우저별) */
	    -moz-appearance: none;
	    -webkit-appearance: none;
	    position: relative;
	}
	
	/* 셀렉트 hover/focus 효과 */
	.filter-select:hover,
	.filter-select:focus {
	    border-color: rgba(102, 102, 255, 0.9);
	    box-shadow: 0 0 6px rgba(102,102,255,0.25);
	}
	
	/* 검색 버튼 (페이지 전체 톤과 맞춤) */
	.filter-button {
	    padding: 8px 18px;
	    border-radius: 999px;
	    border: none;
	    background: rgba(102, 102, 255, 0.9);
	    color: #fff;
	    font-size: 14px;
	    font-weight: 600;
	    cursor: pointer;
	    box-shadow: 0 0 6px rgba(0,0,0,0.08);
	    transition: background 0.2s, box-shadow 0.2s, transform 0.1s;
	}
	
	.filter-button:hover {
	    background: #4a5aff;
	    box-shadow: 0 3px 8px rgba(0,0,0,0.12);
	    transform: translateY(-1px);
	}
	
	.filter-button:active {
	    transform: translateY(0);
	    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
	}
		
	    
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<!-- 팀원 CSS의 container 클래스 적용 -->
<div class="container wrapper">
	<form action="find_page.jsp" method="get">
	    <div class="filter-bar">
	        <h2 class="filter-title">📱 가성비 찾기</h2>
	        <div class="filter-controls">
				<select name="priceRange" class="filter-select">
			        <option value="">전체</option>
			        <option value="UNDER_600"  <c:if test="${param.priceRange == 'UNDER_600'}">selected</c:if>>60만 원 이하</option>
			        <option value="600_800"    <c:if test="${param.priceRange == '600_800'}">selected</c:if>>60만 ~ 80만 원</option>
			        <option value="800_1000"   <c:if test="${param.priceRange == '800_1000'}">selected</c:if>>80만 ~ 100만 원</option>
			        <option value="1000_1300"  <c:if test="${param.priceRange == '1000_1300'}">selected</c:if>>100만 ~ 130만 원</option>
			        <option value="OVER_1300"  <c:if test="${param.priceRange == 'OVER_1300'}">selected</c:if>>130만 원 이상</option>
			    </select>
			    <button type="submit" class="filter-button">검색</button>
	        </div>
	    </div>
	</form>

    <table>
        <colgroup>
            <col width="15%" /> <!-- 브랜드 -->
            <col width="20%" /> <!-- 모델명 -->
            <col width="10%" /> <!-- 연식 -->
            <col width="10%" /> <!-- RAM -->
            <col width="15%" /> <!-- 점수 -->
            <col width="15%" /> <!-- 가격 -->
            <col width="15%" /> <!-- 버튼 -->
        </colgroup>
        <thead>
            <tr>
                <th>브랜드</th>
                <th>모델명</th>
                <th>연식</th>
                <th>RAM</th>
                <th>가성비 점수 ↓</th>
                <th>가격</th>
                <th>상세보기</th>
            </tr>
        </thead>

        <tbody>
            <!-- 데이터가 없을 경우 처리 -->
            <c:if test="${empty phones}">
                <tr>
                    <td colspan="7" style="padding: 30px;">
                        등록된 휴대폰 정보가 없습니다.<br>
                        (DB 데이터를 확인해주세요)
                    </td>
                </tr>
            </c:if>

            <!-- 데이터 반복 출력 -->
            <c:forEach var="p" items="${phones}">
                <tr>
                    <!-- Phone.java의 getBrand() 호출 -->
                    <td>${p.brand}</td>
                    
                    <!-- Phone.java의 getModel() 호출 -->
                    <td>${p.model}</td>
                    
                    <!-- Phone.java의 getYearOfRelease() 호출 -->
                    <td>${p.yearOfRelease}년</td>
                    
                    <td>${p.ram} GB</td>
                    <td>
                        <span class="score-badge">
                            <c:set var="score" value="${p.score}" />
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
                        </span>
                    </td>

                    <td>
                        <fmt:formatNumber value="${p.price}" type="number" />원
                    </td>

                    <td>
                        <!-- Phone.java의 getPhoneId() 호출 -->
                        <a class="detail-btn" href="detail_page.jsp?phoneId=${p.phoneId}">
                            제품 보기
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination-wrapper">
        <div class="pagination">
            <c:forEach var="pnum" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${pnum == currentPage}">
                        <span class="current">${pnum}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="find_page.jsp?page=${pnum}&priceRange=${param.priceRange}">
                            ${pnum}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>


</div>

<jsp:include page="footer.jsp" />

</body>
</html>