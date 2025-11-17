<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.phone.service.UserService" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userId = request.getParameter("id");
	    String userPasswd = request.getParameter("passwd");
        // 여기서 UserService.java 불러와서
        // 사용자가 입력한 값 이랑 DB에 있는 값이 일치한지 확인 후 세션에 저장
	    UserService userService = new UserService();
       
        boolean loginSuccess = userService.loginUser(userId, userPasswd);
        // true 면 세션에 사용자 로그인 정보 저장
        if (loginSuccess) {
        	
        }
	%>
	<p>아이디: <%= userId %></p>
	<p>비밀번호: <%= userPasswd %></p>
</body>
</html>