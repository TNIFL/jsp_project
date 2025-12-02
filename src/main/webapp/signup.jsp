<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 가입</title>
    <link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
    <link rel="stylesheet" href="1.css">
</head>
<body>

    <!-- 헤더 영역 -->
    <jsp:include page="header.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow-sm p-4">
                    <form action="signup_process.jsp" method="post">
                        <div class="mb-3">
                            <label for="id" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="id" name="id" required>
                        </div>

                        <div class="mb-3">
                            <label for="nickname" class="form-label">닉네임</label>
                            <input type="text" class="form-control" id="nickname" name="nickname" required>
                        </div>

                        <div class="mb-3">
                            <label for="passwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="passwd" name="passwd" required>
                        </div>

                        <div class="mb-3">
                            <label for="passwd2" class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-control" id="passwd2" name="passwd2" required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">가입</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 푸터 영역 -->
    <jsp:include page="footer.jsp" />

    <!-- 비밀번호 확인 스크립트 -->
    <script>
        document.querySelector("form").addEventListener("submit", function(e) {
            const pw = document.getElementById("passwd").value;
            const pw2 = document.getElementById("passwd2").value;
            if (pw !== pw2) {
                alert("비밀번호가 일치하지 않습니다.");
                e.preventDefault(); // 폼 제출 막기
            }
        });
    </script>

</body>
</html>
