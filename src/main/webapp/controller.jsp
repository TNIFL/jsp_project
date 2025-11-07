<!-- controller 는 사용자의 요청을 받아 어떤 서비스 로직을 실행하고, 그 결과를 알맞은 JSP(View)에 전달하는 중간 제어자 입니다. -->
<!-- 이 controller 의 용도는 header.jsp 에서 사용자의 입력을 받고 그에 맞는 행위를 전달하는 역할입니다. -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.phone.service.PhoneService" %>
<%@ page import="com.phone.model.Phone" %>

<%
	//여기서 service 호출 후 결과를 jsp 에 전달
	// 동작과정
	// 1. 요청 파라미터(action) 확인
	// 2. action 에 따라 알맞은 서비스 로직 호출
	// 3. 서비스는 필요한 데이터를 Dao에서 가져옴
	// 4. 데이터를 성공적으로 가져오면 jsp 로 포워딩
	
    // 한글 처리
    request.setCharacterEncoding("UTF-8");

    // 요청 파라미터
    String action = request.getParameter("action");
    if (action == null) action = "list";

    PhoneService phoneService = new PhoneService();
    if ("mainpage".equals(action)) {
    	pageContext.forward("mainpage.jsp");
    } else if ("list".equals(action)) {
        pageContext.forward("product_list_page.jsp");
    } else if ("compare".equals(action)) {
    	pageContext.forward("compare_page.jsp");
    } else if ("login".equals(action)) {
        pageContext.forward("login.jsp");
    } else if ("signup".equals(action)) {
        pageContext.forward("signup.jsp");
    } else if ("community".equals(action)) {
        pageContext.forward("community_main.jsp");
    } else {
        // 기본 페이지로 이동
        pageContext.forward("mainpage.jsp");
    }
    
%>
