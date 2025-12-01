<%@ page import="com.phone.service.UserService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
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
    request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

    String userId = request.getParameter("id");
    String userPasswd = request.getParameter("passwd");

    if (userId == null || userPasswd == null || userId.isEmpty() || userPasswd.isEmpty()) {
%>
        <h2>입력 오류</h2>
        <p>아이디와 비밀번호를 모두 입력해주세요.</p>
        <a href="login.jsp">돌아가기</a>
<%
    } else {
        UserService userService = new UserService();
        boolean loginSuccess = userService.loginUser(userId, userPasswd);

        if (loginSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("userID", userId);
            // 비밀번호는 보안상 저장하지 않는 것이 좋습니다

%>
            <h2>로그인 성공!</h2>
            <p>환영합니다, <%= userId %>님.</p>
            <a href="main.jsp" class="btn btn-primary mt-3">메인 페이지로 이동</a>
<%
        } else {
%>
            <h2>로그인 실패</h2>
            <p>아이디 또는 비밀번호가 올바르지 않습니다.</p>
            <a href="login.jsp" class="btn btn-danger mt-3">다시 로그인</a>
<%
        }
    }
%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
