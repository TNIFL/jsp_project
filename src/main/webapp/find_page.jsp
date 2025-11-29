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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가성비 비교</title>
<!-- 팀원 공통 CSS 연결 -->
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
    
    /* 점수 강조 */
    .score-badge {
        font-weight: bold;
        color: #d63031;
    }
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<!-- 팀원 CSS의 container 클래스 적용 -->
<div class="container wrapper">

    <h2>📱 가성비 찾기</h2>

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
                <th>가성비 점수</th>
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

                    <!-- 
                        ★ 핵심 수정: 자바 코드(<% %>) 제거하고 EL로 바로 계산 
                        점수 공식: (RAM * 2) + (배터리 / 1000) - (무게 / 50)
                    -->
                    <td>
                        <span class="score-badge">
                            <fmt:formatNumber 
                                value="${(p.ram * 2) + (p.battery / 1000) - (p.weight / 50)}" 
                                pattern="#.00" />점
                        </span>
                    </td>

                    <td>
                        <fmt:formatNumber value="${p.price}" type="number" />원
                    </td>

                    <td>
                        <!-- Phone.java의 getPhoneId() 호출 -->
                        <a class="detail-btn" href="detail_page.jsp?id=${p.phoneId}">
                            보기
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>