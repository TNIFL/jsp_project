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

    
    <!-- 헤더 영역 -->
    <!-- header.jsp 내용이 여기에 들어갑니다 -->
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
							<p><input type="submit" value ="가입">
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
