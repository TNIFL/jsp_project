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

    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
	 <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <input type="text" class="form-control" id="id" name="id" required>
            </div>

            <div class="mb-3">
                <label for="passwd" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="passwd" name="passwd" required>
            </div>

            <div class="mb-3">
                <label for="passwd2" class="form-label">비밀번호 확인</label>
                <input type="password" class="form-control" id="passwd2" name="passwd2" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="010-1234-5678">
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label class="form-label">성별</label><br>
                <input type="radio" name="gender" value="M"> 남성
                <input type="radio" name="gender" value="F"> 여성
            </div>

            <div class="mb-3">
                <label for="birth" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="birth" name="birth">
            </div>

            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" id="agree" required>
                <label class="form-check-label" for="agree">이용약관 및 개인정보 처리방침에 동의합니다.</label>
            </div>

            <button type="submit" class="btn btn-primary">가입</button>
        </form>
    </div>

    <!-- 푸터 영역 -->
    <!-- footer.jsp 내용이 여기에 들어갑니다 -->
<jsp:include page="footer.jsp" />

</body>
</html>
