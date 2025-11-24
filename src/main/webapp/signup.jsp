<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="menu.css">
</head>
<body>

<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	<div>
        <p>BookMarket</p>
        <h1>회원 가입</h1>
    </div>

    <form action="join_process.jsp" method="post">
        <p>아이디: <input type="text" name="id"></p>
        <p>비밀번호: <input type="password" name="passwd"></p>
        <p><input type="submit" value="가입"></p>
    </form>

    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />

</body>
</html>
