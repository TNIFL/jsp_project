<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
</head>
<body>
<jsp:include page="header.jsp" />

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	 <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm p-4">
                    <h2 class="text-center mb-4">로그인</h2>

                    <form action="loginProcess.jsp" method="post">
                        <div class="mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="id" name="id" required>
                        </div>

                        <div class="mb-3">
                            <label for="passwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="passwd" name="passwd" required>
                        </div>

                        <div class="form-check mb-3">
                            <input type="checkbox" class="form-check-input" id="remember">
                            <label class="form-check-label" for="remember">아이디 저장</label>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary">로그인</button>
                        </div>

                        <div class="text-center">
                            <a href="signup.jsp" class="me-3">회원가입</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />
</body>
</html>