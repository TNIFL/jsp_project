<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>

<%@ page import="java.util.*" %>
<%@ page import="com.phone.service.PhoneService" %>
<%@ page import="com.phone.model.Phone" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>제품 비교 페이지</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
    <style>
    /* 전체 배경 & 기본 폰트 */
    body {
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #f5f6fa;
        color: #333;
    }

    /* 페이지 전체를 감싸는 카드 */
    .compare-container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 24px 28px 28px;
        background-color: #ffffff;
        border-radius: 18px;
        box-shadow: 0 10px 26px rgba(0, 0, 0, 0.08);
    }

    .compare-title {
        margin: 0 0 18px;
        font-size: 24px;
        font-weight: 700;
        color: #222;
    }

    /* 상단 선택 영역 (폼) */
    .selector-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 18px;
        margin-bottom: 18px;
        padding: 12px 16px;
        border-radius: 14px;
        border: 1px solid #dde2f3;
        background: linear-gradient(135deg, #f7f8ff, #fdfdff);
        box-shadow: 0 5px 14px rgba(0, 0, 0, 0.04);
    }

    .selector-column {
        flex: 1;
    }

    .selector-column label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 13px;
        color: #444;
    }

    .selector-column select {
        width: 100%;
        padding: 7px 10px;
        font-size: 13px;
        border-radius: 999px;
        border: 1px solid #c8cfea;
        background-color: #fff;
        color: #333;
        outline: none;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.03);
        appearance: none;
        -moz-appearance: none;
        -webkit-appearance: none;
    }

    .selector-column select:hover,
    .selector-column select:focus {
        border-color: #4b6cff;
        box-shadow: 0 0 0 2px rgba(75, 108, 255, 0.18);
    }

    .selector-center {
        width: 60px;
        text-align: center;
        font-weight: 700;
        font-size: 16px;
        color: #4b4e63;
    }

    .selector-row button {
        padding: 7px 18px;
        font-size: 13px;
        border-radius: 999px;
        border: none;
        background-color: #4b6cff;
        color: #fff;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 5px 14px rgba(75, 108, 255, 0.4);
        transition: background 0.2s, transform 0.1s, box-shadow 0.2s;
    }

    .selector-row button:hover {
        background-color: #3c57e5;
        transform: translateY(-1px);
        box-shadow: 0 7px 18px rgba(75, 108, 255, 0.5);
    }

    .selector-row button:active {
        transform: translateY(0);
        box-shadow: 0 3px 9px rgba(75, 108, 255, 0.35);
    }

    /* 비교 메인 레이아웃 */
    .compare-main {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;
        margin-top: 18px;
    }

    .compare-column {
        border-radius: 14px;
        border: 1px solid #e2e5f1;
        padding: 14px 16px 16px;
        background-color: #ffffff;
        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.03);
        transition: transform 0.12s ease, box-shadow 0.12s ease, border-color 0.12s;
    }

    .compare-column:hover {
        transform: translateY(-2px);
        border-color: rgba(75, 108, 255, 0.6);
        box-shadow: 0 10px 24px rgba(75, 108, 255, 0.18);
    }

    /* 이미지 영역 */
    .image-box {
        width: 100%;
        height: 260px;
        border-radius: 12px;
        border: 1px solid #d4d7e7;
        background-color: #fafbff;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
    }

    .image-box img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }

    .placeholder-text {
        color: #888ea8;
        font-size: 13px;
        text-align: center;
    }

    /* 총점 영역 */
    .score-summary {
        margin-bottom: 8px;
    }

    .score-summary-row {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .score-summary-label {
        font-size: 13px;
        font-weight: 600;
        color: #555;
        width: 40px;
    }

    .score-bar-bg {
        flex: 1;
        height: 8px;
        background-color: #edf0fb;
        border-radius: 999px;
        overflow: hidden;
    }

    .score-bar-fill-left {
        height: 100%;
        background: linear-gradient(90deg, #4b6cff, #8c9bff);
    }

    .score-bar-fill-right {
        height: 100%;
        background: linear-gradient(90deg, #2ecc71, #7ee0a4);
    }

    /* 성능 표 제목 */
    .spec-title {
        margin: 10px 0 4px;
        font-weight: 700;
        font-size: 14px;
        color: #333;
        border-bottom: 1px solid #e1e4f0;
        padding-bottom: 4px;
    }

    .spec-title + p {
        margin: 4px 0 8px;
        font-size: 11px;
        color: #9a9fb5;
    }

    /* 스펙 표 */
    .spec-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
    }

    .spec-table th,
    .spec-table td {
        padding: 4px 6px;
        border-bottom: 1px solid #f1f2f7;
        text-align: left;
        vertical-align: middle;
    }

    .spec-table th {
        width: 110px;
        font-weight: 500;
        color: #666c8c;
    }

    /* 막대 + 승패 줄 */
    .bar-row {
        margin-top: 4px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .bar-bg {
        flex: 1;
        height: 6px;
        background-color: #edf0fb;
        border-radius: 999px;
        overflow: hidden;
    }

    .bar-fill-left {
        height: 100%;
        background: linear-gradient(90deg, #4b6cff, #8c9bff);
    }

    .bar-fill-right {
        height: 100%;
        background: linear-gradient(90deg, #2ecc71, #7ee0a4);
    }

    .result-badge {
        display: inline-block;
        padding: 1px 7px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 600;
        color: #fff;
        white-space: nowrap;
    }

    .result-win {
        background-color: #27ae60;
    }

    .result-lose {
        background-color: #e74c3c;
    }

    .result-draw {
        background-color: #95a5a6;
    }

    /* 점수 뱃지 */
    .score-badge {
        display: inline-block;
        min-width: 32px;
        text-align: center;
        padding: 4px 7px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        color: #fff;
    }

    .score-red    { background-color: #e74c3c; }
    .score-orange { background-color: #e67e22; }
    .score-green  { background-color: #27ae60; }
    .score-blue   { background-color: #2980b9; }

    /* 칼럼 하단 버튼 영역 */
    .column-footer {
        margin-top: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .detail-button {
        padding: 5px 10px;
        font-size: 12px;
        border-radius: 999px;
        border: 1px solid #c3c7dc;
        background-color: #f4f5ff;
        cursor: pointer;
        text-decoration: none;
        color: #3d4bc0;
        font-weight: 600;
        transition: background 0.2s, color 0.2s, box-shadow 0.2s, border-color 0.2s;
    }

    .detail-button:hover {
        background-color: #3d4bc0;
        color: #fff;
        border-color: #3d4bc0;
        box-shadow: 0 4px 10px rgba(61, 75, 192, 0.35);
    }

    /* 상세 패널 */
    .detail-panel {
        margin-top: 8px;
        padding: 8px 10px;
        border-radius: 10px;
        border: 1px solid #e0e2f1;
        background-color: #fafbff;
        font-size: 13px;
        display: none;
    }

    .detail-panel strong {
        display: inline-block;
        margin-bottom: 4px;
        color: #444;
    }

    /* 하단: 리스트로 돌아가기 */
    .back-list {
        margin-top: 24px;
        text-align: center;
    }

    .back-list a {
        display: inline-block;
        padding: 7px 16px;
        border-radius: 999px;
        border: 1px solid #c3c7dc;
        background-color: #f4f5ff;
        text-decoration: none;
        font-size: 13px;
        color: #3d4bc0;
        font-weight: 600;
        transition: background 0.2s, color 0.2s, box-shadow 0.2s, border-color 0.2s;
    }

    .back-list a:hover {
        background-color: #3d4bc0;
        color: #fff;
        border-color: #3d4bc0;
        box-shadow: 0 4px 10px rgba(61, 75, 192, 0.35);
    }
</style>


    <script>
        /*
         * JS : 상세 영역 열고 닫는 간단한 토글 함수
         * - id 로 찾아서 display 값을 바꿔줌
         */
        function toggleDetail(id) {
            var panel = document.getElementById(id);
            if (!panel) return;

            if (panel.style.display === 'none' || panel.style.display === '') {
                panel.style.display = 'block';
            } else {
                panel.style.display = 'none';
            }
        }
    </script>
</head>
<body>

<jsp:include page="header.jsp" />

<%
    /*
     ============================================================
       compare_page.jsp 의 역할 정리
       ----------------------------------------------------------
       - 이 페이지는 "제품 비교" 화면을 담당한다.
       - 상단에는 왼쪽/오른쪽 제품을 고를 수 있는 드롭다운이 있고,
         하단에는 선택된 두 제품의 이미지, 성능표, 점수, 상세내용이
         양쪽에 나란히 비교되는 구조.

       [이 페이지로 진입하는 경우는 크게 2가지]

       1) detail_page.jsp 에서 특정 제품을 보고 있다가
          "비교하기" 버튼을 눌러서 이동하는 경우
          → compare_page.jsp?phoneId=3 이런 식으로 넘어옴
          → 이미 보고 있던 제품의 phoneId 를 왼쪽 칸에 먼저 채워 놓고,
             오른쪽 제품만 사용자가 고르게 한다.

       2) header.jsp 의 "제품 비교" 메뉴를 눌러서 직접 온 경우
          → 아무 phoneId 도 없이 오므로
             왼쪽/오른쪽 모두 드롭다운에서 사용자가 직접 선택해야 한다.

       이 JSP 안에서 하는 일 순서
       ----------------------------------------------------------
       1. 요청 파라미터 읽기 (leftId, rightId, phoneId)
       2. PhoneService 를 통해 전체 Phone 리스트 조회
       3. 전체 리스트에서 leftId / rightId 에 해당하는 Phone 찾아서
          leftPhone / rightPhone 변수에 담음
       4. JSTL 에서 쓸 수 있게 request 에 phoneList, leftPhone, rightPhone 저장
       5. 아래 HTML 부분에서
          - 드롭다운 옵션 : phoneList 를 순회하며 모두 출력
          - 좌/우 비교 영역 : leftPhone / rightPhone 정보 출력
     ============================================================
    */

    // 한글 파라미터 처리
    request.setCharacterEncoding("UTF-8");

    // 왼쪽/오른쪽 드롭다운에서 넘어온 phone_id
    String leftParam  = request.getParameter("leftId");
    String rightParam = request.getParameter("rightId");

    // detail_page.jsp 에서 "비교하기" 버튼으로 넘어올 때 쓰는 phoneId
    String fromDetail = request.getParameter("phoneId");

    // 실제로 사용할 정수형 id 값
    int leftId  = 0;
    int rightId = 0;

    // 1) 왼쪽 제품 id 처리
    //    - 우선 leftId 파라미터를 보고
    //    - 없으면(detail에서 온 경우) phoneId 를 기본으로 사용
    if (leftParam != null && !leftParam.isEmpty()) {
        try {
            leftId = Integer.parseInt(leftParam);
        } catch (NumberFormatException e) {
            leftId = 0;    // 숫자 변환 실패 시 0 (선택 없음)
        }
    } else if (fromDetail != null && !fromDetail.isEmpty()) {
        try {
            leftId = Integer.parseInt(fromDetail);
        } catch (NumberFormatException e) {
            leftId = 0;
        }
    }

    // 2) 오른쪽 제품 id 처리
    //    - rightId 파라미터만 사용 (기본은 0 → 선택 안 됨)
    if (rightParam != null && !rightParam.isEmpty()) {
        try {
            rightId = Integer.parseInt(rightParam);
        } catch (NumberFormatException e) {
            rightId = 0;
        }
    }

    // 3) 서비스 호출해서 전체 제품 리스트 가져오기
    //    - getAllPhones() 내부에서 점수 계산까지 해 두었다고 가정
    PhoneService phoneService = new PhoneService();
    List<Phone> phoneList = phoneService.getAllPhones();

    // 왼쪽/오른쪽에 실제로 표시할 Phone 객체
    Phone leftPhone  = null;
    Phone rightPhone = null;

    if (phoneList != null) {
        // 전체 리스트를 돌면서 id 가 같은 제품을 찾음
        for (Phone p : phoneList) {
            if (p.getPhoneId() == leftId) {
                leftPhone = p;
            }
            if (p.getPhoneId() == rightId) {
                rightPhone = p;
            }
        }
    }

    // 비교용 숫자/바 그래프 계산
    //  - 총점 바
    //  - 주요 스펙(가격, 저장공간, RAM, 배터리, 디스플레이)의 막대 + 승/패
    int leftScore  = (leftPhone  != null) ? leftPhone.getScore()  : 0;
    int rightScore = (rightPhone != null) ? rightPhone.getScore() : 0;

    // 총점 바는 0~100 기준으로
    // 제품 하나만 선택되어도 그 제품의 총점 바는 나옴
    int leftScoreBar  = Math.max(0, Math.min(100, leftScore));
    int rightScoreBar = Math.max(0, Math.min(100, rightScore));

    // request 에 저장해서 EL 로 사용
    request.setAttribute("leftScoreBar", leftScoreBar);
    request.setAttribute("rightScoreBar", rightScoreBar);

    // 두 제품이 모두 선택된 경우에만 항목별 막대/승패 계산
    int priceLeftBar = 0, priceRightBar = 0;
    String priceLeftResult = "", priceRightResult = "";
    String priceLeftCss = "", priceRightCss = "";

    int storageLeftBar = 0, storageRightBar = 0;
    String storageLeftResult = "", storageRightResult = "";
    String storageLeftCss = "", storageRightCss = "";

    int ramLeftBar = 0, ramRightBar = 0;
    String ramLeftResult = "", ramRightResult = "";
    String ramLeftCss = "", ramRightCss = "";

    int batteryLeftBar = 0, batteryRightBar = 0;
    String batteryLeftResult = "", batteryRightResult = "";
    String batteryLeftCss = "", batteryRightCss = "";

    int displayLeftBar = 0, displayRightBar = 0;
    String displayLeftResult = "", displayRightResult = "";
    String displayLeftCss = "", displayRightCss = "";

    // 만약 제품을 둘 다 선택 했다면
    if (leftPhone != null && rightPhone != null) {
        // 1) 가격 : "더 싼 쪽"이 유리하다고 보고 막대/승패 계산
        int lp = leftPhone.getPrice();
        int rp = rightPhone.getPrice();
        int maxP = Math.max(lp, rp);
        int minP = Math.min(lp, rp);
		// 가격이 같지 않아야지만 유리한 제품을 고를 수 있음
        if (maxP != minP) {
            // Math.round 는 반올림 함수
            // left, right 는 좋은 쪽 안좋은 쪽이 아니라 사용자가 선택한 결과들
            // lp = 왼쪽 폰
            // rp = 오른쪽 폰
            // maxP = lp, rp 중 큰 값
            // minP = lp, rp 중 작은 값
            // ex_value =  lp : 1,200,000 / rp : 1,000,000
            
            // int best = Math.min(lp, rp);	 // 왼쪽 폰, 오른쪽 폰 중에 작은 값
            // int worst = Math.max(lp, rp); // 왼쪽 폰, 오른쪽 폰 중에 큰 값
            // 큰 값 이랑 작은 값 정하고
            // int bestBar = 100; 작은 값의 그래프는 100%(작을수록 좋음, 가격이 저렴함)
            // int worstBar = (int)Math.round(best * 100.0 / worst)
            // 위 식을 풀이하면
            // best 값에 * 100.0 하면 1,000,000 * 100.0 -> 100,000,000.0 이 될거임
            // 거기에 / worst 하면 100,000,000.0 / 1,200,000
            // 결과는 83.33333...
            // 반올림 하면 83점
            // 그럼 bestBar 는 100%, worstBar는 bestBar의 83% 가 되어서
            // 좋은 제품에 비해 83%의 가치를 가진다
            int best = Math.min(lp, rp);	// 가격이 작을수록 좋음
            int worst = Math.max(lp, rp);	// 가격이 클 수록 좋음
            // 비교대상에서 항상 좋은쪽은 100% 의 그래프를 가짐
            
            int bestBar = 100;				// 가격이 작으면 100%
            int worstBar = (int)Math.round(best * 100.0 / worst);	// 가격이 크면 작은 가격에 대비해 몇% 의 가치를 가지는지
            
            if (lp > rp) {	// 왼쪽 가격이 오른쪽 가격보다 높아서 lp 가 worstBar 를 가지고, rp가 bestBar를 가짐
            	priceLeftBar  = worstBar;
            	priceRightBar = bestBar;
            } else if(lp < rp) {		// 왼쪽 가격이 오른쪽 가격보다 낮아서 lp가 bestBar를 가지고, rp가 bestBar를 가짐
            	priceLeftBar  = bestBar;
            	priceRightBar = worstBar;
            } else {				// 왼쪽, 오른쪽의 가격이 같으면 50, 50으로 설정
            	priceLeftBar  = 50;
            	priceRightBar = 50;
            }
        }

        if (lp < rp) {
            priceLeftResult  = "승";
            priceRightResult = "패";
            // 승, 패의 css 스타일 입히기
            priceLeftCss     = "result-win";
            priceRightCss    = "result-lose";
        } else if (lp > rp) {
            priceLeftResult  = "패";
            priceRightResult = "승";
            // 승, 패의 css 스타일 입히기
            priceLeftCss     = "result-lose";
            priceRightCss    = "result-win";
        } else {
        	// 동점이면 같은 css 스타일
            priceLeftResult = priceRightResult = "동점";
            priceLeftCss = priceRightCss = "result-draw";
        }

        // 2) 저장공간 : 큰 값이 유리
        // 이것도 마찬가지로 큰 저장공간에 대비하여 작은 저장공간의 % 를 나타냄
        int ls = leftPhone.getStorage();
        int rs = rightPhone.getStorage();
        int maxS = Math.max(ls, rs);
        if (maxS > 0) {
        	// Math.round 는 반올림 함수
            storageLeftBar  = (int)Math.round(ls * 100.0 / maxS);
            storageRightBar = (int)Math.round(rs * 100.0 / maxS);
        }

        if (ls > rs) {
            storageLeftResult  = "승";
            storageRightResult = "패";
            storageLeftCss     = "result-win";
            storageRightCss    = "result-lose";
        } else if (ls < rs) {
            storageLeftResult  = "패";
            storageRightResult = "승";
            storageLeftCss     = "result-lose";
            storageRightCss    = "result-win";
        } else {
            storageLeftResult = storageRightResult = "동점";
            storageLeftCss = storageRightCss = "result-draw";
        }

        // 3) RAM : 큰 값이 유리
        // 이것도 마찬가지로 큰 메모리에 대비하여 작은 메모리의 % 를 나타냄
        int lr = leftPhone.getRam();
        int rr = rightPhone.getRam();
        int maxR = Math.max(lr, rr);
        if (maxR > 0) {
        	// Math.round 는 반올림 함수
            ramLeftBar  = (int)Math.round(lr * 100.0 / maxR);
            ramRightBar = (int)Math.round(rr * 100.0 / maxR);
        }

        if (lr > rr) {
            ramLeftResult  = "승";
            ramRightResult = "패";
            ramLeftCss     = "result-win";
            ramRightCss    = "result-lose";
        } else if (lr < rr) {
            ramLeftResult  = "패";
            ramRightResult = "승";
            ramLeftCss     = "result-lose";
            ramRightCss    = "result-win";
        } else {
            ramLeftResult = ramRightResult = "동점";
            ramLeftCss = ramRightCss = "result-draw";
        }

        // 4) 배터리 : 큰 값이 유리
        // 이것도 마찬가지로 큰 배터리에 대비하여 작은 배터리의 % 를 나타냄
        int lb = leftPhone.getBattery();
        int rb = rightPhone.getBattery();
        int maxB = Math.max(lb, rb);
        if (maxB > 0) {
        	// Math.round 는 반올림 함수
            batteryLeftBar  = (int)Math.round(lb * 100.0 / maxB);
            batteryRightBar = (int)Math.round(rb * 100.0 / maxB);
        }

        if (lb > rb) {
            batteryLeftResult  = "승";
            batteryRightResult = "패";
            batteryLeftCss     = "result-win";
            batteryRightCss    = "result-lose";
        } else if (lb < rb) {
            batteryLeftResult  = "패";
            batteryRightResult = "승";
            batteryLeftCss     = "result-lose";
            batteryRightCss    = "result-win";
        } else {
            batteryLeftResult = batteryRightResult = "동점";
            batteryLeftCss = batteryRightCss = "result-draw";
        }

        // 5) 디스플레이 크기 : 큰 값이 유리함
        // 이것도 마찬가지로 큰 디스플레이에 대비하여 작은 디스플레이의 % 를 나타냄
        double ld = leftPhone.getDisplayInch();
        double rd = rightPhone.getDisplayInch();
        double maxD = Math.max(ld, rd);
        if (maxD > 0) {
        	// Math.round 는 반올림 함수
            displayLeftBar  = (int)Math.round(ld * 100.0 / maxD);
            displayRightBar = (int)Math.round(rd * 100.0 / maxD);
        }

        if (ld > rd) {
            displayLeftResult  = "승";
            displayRightResult = "패";
            displayLeftCss     = "result-win";
            displayRightCss    = "result-lose";
        } else if (ld < rd) {
            displayLeftResult  = "패";
            displayRightResult = "승";
            displayLeftCss     = "result-lose";
            displayRightCss    = "result-win";
        } else {
            displayLeftResult = displayRightResult = "동점";
            displayLeftCss = displayRightCss = "result-draw";
        }
    }

    // 계산 결과를 request 에 넣어 EL 로 사용
    // 아래의 ________Bar 는 계산 한 후에 그래프를 100%, 100%에 대비한 % 를 
    // css에 style="width:${________Bar}%;" 를 입혀 그래프의 길이를 표현함
    // 아래의 ________Result 는 계산 한 후에 승 / 패 를 표현함
    // 아래의 ________Css 는 계산 한 후에 승 / 패 를 표현하는데, 색깔을 입혀줌
    request.setAttribute("priceLeftBar", priceLeftBar);
    request.setAttribute("priceRightBar", priceRightBar);
    request.setAttribute("priceLeftResult", priceLeftResult);
    request.setAttribute("priceRightResult", priceRightResult);
    request.setAttribute("priceLeftCss", priceLeftCss);
    request.setAttribute("priceRightCss", priceRightCss);

    request.setAttribute("storageLeftBar", storageLeftBar);
    request.setAttribute("storageRightBar", storageRightBar);
    request.setAttribute("storageLeftResult", storageLeftResult);
    request.setAttribute("storageRightResult", storageRightResult);
    request.setAttribute("storageLeftCss", storageLeftCss);
    request.setAttribute("storageRightCss", storageRightCss);

    request.setAttribute("ramLeftBar", ramLeftBar);
    request.setAttribute("ramRightBar", ramRightBar);
    request.setAttribute("ramLeftResult", ramLeftResult);
    request.setAttribute("ramRightResult", ramRightResult);
    request.setAttribute("ramLeftCss", ramLeftCss);
    request.setAttribute("ramRightCss", ramRightCss);

    request.setAttribute("batteryLeftBar", batteryLeftBar);
    request.setAttribute("batteryRightBar", batteryRightBar);
    request.setAttribute("batteryLeftResult", batteryLeftResult);
    request.setAttribute("batteryRightResult", batteryRightResult);
    request.setAttribute("batteryLeftCss", batteryLeftCss);
    request.setAttribute("batteryRightCss", batteryRightCss);

    request.setAttribute("displayLeftBar", displayLeftBar);
    request.setAttribute("displayRightBar", displayRightBar);
    request.setAttribute("displayLeftResult", displayLeftResult);
    request.setAttribute("displayRightResult", displayRightResult);
    request.setAttribute("displayLeftCss", displayLeftCss);
    request.setAttribute("displayRightCss", displayRightCss);

    // JSTL에서 사용할 수 있도록 request 영역에 원래 값도 저장
    request.setAttribute("phoneList",  phoneList);
    request.setAttribute("leftPhone",  leftPhone);
    request.setAttribute("rightPhone", rightPhone);
%>

<div class="compare-container">
    <h1 class="compare-title">제품 비교 페이지입니다.</h1>

    <!-- 제품 선택 드롭다운 영역
         - 왼쪽 제품 / 오른쪽 제품을 선택하는 폼 -->
    <form method="get" action="compare_page.jsp" class="selector-row">
        <!-- 왼쪽 드롭다운 -->
        <div class="selector-column">
            <label>왼쪽 제품 선택</label>
            <select name="leftId">
                <option value="">제품을 선택하세요</option>
                <c:forEach var="p" items="${phoneList}">
                    <option value="${p.phoneId}"
                        <c:if test="${not empty leftPhone and p.phoneId == leftPhone.phoneId}">selected</c:if>>
                        ${p.brand} ${p.model} (${p.yearOfRelease})
                        - <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>원
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- 가운데 VS 표시 -->
        <div class="selector-center">
            VS
        </div>

        <!-- 오른쪽 드롭다운 -->
        <div class="selector-column">
            <label>오른쪽 제품 선택</label>
            <select name="rightId">
                <option value="">제품을 선택하세요</option>
                <c:forEach var="p" items="${phoneList}">
                    <option value="${p.phoneId}"
                        <c:if test="${not empty rightPhone and p.phoneId == rightPhone.phoneId}">selected</c:if>>
                        ${p.brand} ${p.model} (${p.yearOfRelease})
                        - <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>원
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- 비교하기 버튼 (폼 submit) -->
        <button type="submit">비교하기</button>
    </form>

    <!-- 실제 비교 레이아웃
         - 왼쪽/오른쪽 두 칼럼으로 나눠서
           이미지, "총점 + 바", 성능표, 항목별 바, 점수, 상세내용 -->
    <div class="compare-main">
        <!-- 왼쪽 칼럼 -->
        <div class="compare-column">
            <!-- 제품 이미지 영역 -->
            <div class="image-box">
                <c:choose>
                    <c:when test="${not empty leftPhone}">
                        <img src="${pageContext.request.contextPath}/images/${empty leftPhone.imagePath ? 'default.jpg' : leftPhone.imagePath}"
                             alt="${leftPhone.model}">
                    </c:when>
                    <c:otherwise>
                        <span class="placeholder-text">
                            왼쪽 제품을 선택하면 이미지가 표시됩니다.
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 이미지 바로 아래 : 총점 + 바 그래프 -->
            <c:if test="${not empty leftPhone}">
                <div class="score-summary">
                    <div class="score-summary-row">
                        <span class="score-summary-label">총점</span>
                        <div class="score-bar-bg">
                            <!-- style width는 스크립틀릿에서 계산한 값 사용 -->
                            <div class="score-bar-fill-left"
                                 style="width:${leftScoreBar}%;"></div>
                        </div>

                        <!-- 색깔 점수 뱃지 (리스트와 동일 규칙) -->
                        <c:set var="lscore" value="${leftPhone.score}" />
                        <c:choose>
                            <c:when test="${lscore <= 50}">
                                <span class="score-badge score-red">${lscore}</span>
                            </c:when>
                            <c:when test="${lscore <= 70}">
                                <span class="score-badge score-orange">${lscore}</span>
                            </c:when>
                            <c:when test="${lscore <= 90}">
                                <span class="score-badge score-green">${lscore}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="score-badge score-blue">${lscore}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

            <!-- 제품 성능 표 타이틀 -->
            <div class="spec-title">제품 성능 표</div>
			<p>※ 아래 그래프는 좋은 쪽에 대비하여 그려집니다.</p>
            <!-- 실제 스펙 정보 표 -->
            <c:if test="${not empty leftPhone}">
                <table class="spec-table">
                    <tr>
                        <th>브랜드</th>
                        <td>${leftPhone.brand}</td>
                    </tr>
                    <tr>
                        <th>모델명</th>
                        <td>${leftPhone.model}</td>
                    </tr>
                    <tr>
                        <th>출시연도</th>
                        <td>${leftPhone.yearOfRelease}</td>
                    </tr>
                    <!-- 가격 : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>가격</th>
                        <td>
                            <fmt:formatNumber value="${leftPhone.price}" type="number" groupingUsed="true"/> 원
                            <c:if test="${not empty rightPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-left"
                                             style="width:${priceLeftBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${priceLeftCss}">
                                        ${priceLeftResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 저장공간 : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>저장공간</th>
                        <td>
                            ${leftPhone.storage}GB
                            <c:if test="${not empty rightPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-left"
                                             style="width:${storageLeftBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${storageLeftCss}">
                                        ${storageLeftResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- RAM : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>RAM</th>
                        <td>
                            ${leftPhone.ram}GB
                            <c:if test="${not empty rightPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-left"
                                             style="width:${ramLeftBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${ramLeftCss}">
                                        ${ramLeftResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 배터리 : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>배터리</th>
                        <td>
                            ${leftPhone.battery}mAh
                            <c:if test="${not empty rightPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-left"
                                             style="width:${batteryLeftBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${batteryLeftCss}">
                                        ${batteryLeftResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 디스플레이 : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>디스플레이</th>
                        <td>
                            ${leftPhone.displayInch}" / ${leftPhone.displayInfo}
                            <c:if test="${not empty rightPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-left"
                                             style="width:${displayLeftBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${displayLeftCss}">
                                        ${displayLeftResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>무게</th>
                        <td>${leftPhone.weight}g</td>
                    </tr>
                    <tr>
                        <th>프로세서</th>
                        <td>${leftPhone.processor}</td>
                    </tr>
                </table>

                <!-- 점수 뱃지 + 버튼들 (총점 바 위에 이미 점수 표시했지만 유지) -->
                <div class="column-footer">
                    <c:set var="lscoreFooter" value="${leftPhone.score}" />
                    <c:choose>
                        <c:when test="${lscoreFooter <= 50}">
                            <span class="score-badge score-red">${lscoreFooter}</span>
                        </c:when>
                        <c:when test="${lscoreFooter <= 70}">
                            <span class="score-badge score-orange">${lscoreFooter}</span>
                        </c:when>
                        <c:when test="${lscoreFooter <= 90}">
                            <span class="score-badge score-green">${lscoreFooter}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="score-badge score-blue">${lscoreFooter}</span>
                        </c:otherwise>
                    </c:choose>

                    <!-- 아래 상세 내용 토글 버튼 -->
                    <button type="button"
                            class="detail-button"
                            onclick="toggleDetail('leftDetail')">
                        제품 상세
                    </button>

                    <!-- detail_page.jsp 로 직접 이동하는 버튼 -->
                    <a href="detail_page.jsp?phoneId=${leftPhone.phoneId}"
                       class="detail-button">
                        상세 페이지 이동
                    </a>
                </div>

                <!-- "제품 상세 버튼 누를 시 상세내용 노출" 박스 -->
                <div id="leftDetail" class="detail-panel">
                    <strong>상세 설명</strong><br/>
                    <c:out value="${leftPhone.detail_description}" default="상세 설명이 없습니다."/>
                </div>
            </c:if>

            <!-- 왼쪽 제품이 선택되지 않았을 때 안내 문구 -->
            <c:if test="${empty leftPhone}">
                <p class="placeholder-text">왼쪽 비교 제품을 선택해 주세요.</p>
            </c:if>
        </div>

        <!-- 오른쪽 칼럼 -->
        <div class="compare-column">
            <!-- 제품 이미지 영역 -->
            <div class="image-box">
                <c:choose>
                    <c:when test="${not empty rightPhone}">
                        <img src="${pageContext.request.contextPath}/images/${empty rightPhone.imagePath ? 'default.jpg' : rightPhone.imagePath}"
                             alt="${rightPhone.model}">
                    </c:when>
                    <c:otherwise>
                        <span class="placeholder-text">
                            오른쪽 제품을 선택하면 이미지가 표시됩니다.
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 이미지 아래 : 총점 + 바 그래프 -->
            <c:if test="${not empty rightPhone}">
                <div class="score-summary">
                    <div class="score-summary-row">
                        <span class="score-summary-label">총점</span>
                        <div class="score-bar-bg">
                            <div class="score-bar-fill-right"
                                 style="width:${rightScoreBar}%;"></div>
                        </div>

                        <c:set var="rscore" value="${rightPhone.score}" />
                        <c:choose>
                            <c:when test="${rscore <= 50}">
                                <span class="score-badge score-red">${rscore}</span>
                            </c:when>
                            <c:when test="${rscore <= 70}">
                                <span class="score-badge score-orange">${rscore}</span>
                            </c:when>
                            <c:when test="${rscore <= 90}">
                                <span class="score-badge score-green">${rscore}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="score-badge score-blue">${rscore}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

            <div class="spec-title">제품 성능 표</div>
			<p>※ 아래 그래프는 좋은 쪽에 대비하여 그려집니다.</p>
            <c:if test="${not empty rightPhone}">
                <table class="spec-table">
                    <tr>
                        <th>브랜드</th>
                        <td>${rightPhone.brand}</td>
                    </tr>
                    <tr>
                        <th>모델명</th>
                        <td>${rightPhone.model}</td>
                    </tr>
                    <tr>
                        <th>출시연도</th>
                        <td>${rightPhone.yearOfRelease}</td>
                    </tr>
                    <!-- 가격 : 숫자 + 바 + 승패 -->
                    <tr>
                        <th>가격</th>
                        <td>
                            <fmt:formatNumber value="${rightPhone.price}" type="number" groupingUsed="true"/> 원
                            <c:if test="${not empty leftPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-right"
                                             style="width:${priceRightBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${priceRightCss}">
                                        ${priceRightResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 저장공간 -->
                    <tr>
                        <th>저장공간</th>
                        <td>
                            ${rightPhone.storage}GB
                            <c:if test="${not empty leftPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-right"
                                             style="width:${storageRightBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${storageRightCss}">
                                        ${storageRightResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- RAM -->
                    <tr>
                        <th>RAM</th>
                        <td>
                            ${rightPhone.ram}GB
                            <c:if test="${not empty leftPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-right"
                                             style="width:${ramRightBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${ramRightCss}">
                                        ${ramRightResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 배터리 -->
                    <tr>
                        <th>배터리</th>
                        <td>
                            ${rightPhone.battery}mAh
                            <c:if test="${not empty leftPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-right"
                                             style="width:${batteryRightBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${batteryRightCss}">
                                        ${batteryRightResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <!-- 디스플레이 -->
                    <tr>
                        <th>디스플레이</th>
                        <td>
                            ${rightPhone.displayInch}" / ${rightPhone.displayInfo}
                            <c:if test="${not empty leftPhone}">
                                <div class="bar-row">
                                    <div class="bar-bg">
                                        <div class="bar-fill-right"
                                             style="width:${displayRightBar}%;"></div>
                                    </div>
                                    <span class="result-badge ${displayRightCss}">
                                        ${displayRightResult}
                                    </span>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>무게</th>
                        <td>${rightPhone.weight}g</td>
                    </tr>
                    <tr>
                        <th>프로세서</th>
                        <td>${rightPhone.processor}</td>
                    </tr>
                </table>

                <div class="column-footer">
                    <c:set var="rscoreFooter" value="${rightPhone.score}" />
                    <c:choose>
                        <c:when test="${rscoreFooter <= 50}">
                            <span class="score-badge score-red">${rscoreFooter}</span>
                        </c:when>
                        <c:when test="${rscoreFooter <= 70}">
                            <span class="score-badge score-orange">${rscoreFooter}</span>
                        </c:when>
                        <c:when test="${rscoreFooter <= 90}">
                            <span class="score-badge score-green">${rscoreFooter}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="score-badge score-blue">${rscoreFooter}</span>
                        </c:otherwise>
                    </c:choose>

                    <button type="button" class="detail-button" onclick="toggleDetail('rightDetail')">
                        제품 상세
                    </button>

                    <a href="detail_page.jsp?phoneId=${rightPhone.phoneId}" class="detail-button">
                        상세 페이지 이동
                    </a>
                </div>

                <div id="rightDetail" class="detail-panel">
                    <strong>상세 설명</strong><br/>
                    <c:out value="${rightPhone.detail_description}" default="상세 설명이 없습니다."/>
                </div>
            </c:if>

            <c:if test="${empty rightPhone}">
                <p class="placeholder-text">오른쪽 비교 제품을 선택해 주세요.</p>
            </c:if>
        </div>
    </div>

    <!-- 맨 아래 : 제품 리스트로 돌아가는 링크 -->
    <div class="back-list">
        <a href="product_list_page.jsp">제품 리스트 보러가기</a>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
