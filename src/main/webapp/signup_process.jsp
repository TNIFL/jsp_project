<%@ page import="com.phone.service.UserService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm p-4">
<%
    String userId = request.getParameter("id");
    String userPasswd = request.getParameter("passwd");
    String userName = request.getParameter("nickname");

    UserService userService = new UserService();
    boolean signupSuccess = userService.registerUser(userId, userPasswd, userName);

    if (signupSuccess) {
%>
        <h2>회원가입 성공!</h2>
        <p><%= userName %>님, 환영합니다!</p>
        <a href="login.jsp">로그인하러 가기</a>
<%
    } else {
%>
        <h2>회원가입 실패</h2>
        <p>이미 존재하는 아이디거나 오류가 발생했습니다.</p>
        <a href="signup.jsp">다시 시도하기</a>
<%
    }
%>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>
