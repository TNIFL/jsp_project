<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>

    <!-- 메뉴 영역 -->
    <!-- menu.jsp 내용이 여기에 들어갑니다 -->

    <div>
        <p>BookMarket</p>
        <h1>로그인</h1>
    </div>

    <form action="login_process.jsp" method="post">
        <p>아이디: <input type="text" name="id"></p>
        <p>비밀번호: <input type="password" name="passwd"></p>
        <p><input type="submit" value="로그인"></p>
    </form>

    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->

</body>
</html>