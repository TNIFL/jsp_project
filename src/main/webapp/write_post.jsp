<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // [보안 체크] 로그인하지 않은 사용자가 주소창에 URL을 직접 쳐서 들어오는 것을 방지
    String loginUserId = (String) session.getAttribute("loginUserId");

    // ★ 테스트용
    // loginUserId = "test"; 

    if (loginUserId == null) {
        // 로그인이 안 되어 있다면 로그인 페이지로 강제 이동
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<!-- 1. 팀원 공통 CSS 연결 -->
<link rel="stylesheet" href="1.css">

<!-- 2. 폰트 (팀원 CSS에 없다면 유지) -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

<style>
    /* 팀원 CSS(1.css)에 body 스타일이 있다면 아래 body 블록은 지워도 됩니다. */
    /* 충돌 방지를 위해 필요한 부분만 남겨두셔도 좋습니다. */
    
    /* 중앙 컨테이너 (팀원 .container 클래스와 섞어 쓰기 위해 유지) */
    .write-container {
        width: 100%;
        max-width: 800px;
        margin: 60px auto;
        background-color: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .page-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
        color: #1a1a1a;
        text-align: center;
        border-bottom: 2px solid #ececec;
        padding-bottom: 20px;
    }

    .form-group { margin-bottom: 25px; }

    .form-label {
        display: block;
        font-weight: 600;
        margin-bottom: 10px;
        color: #555;
        font-size: 15px;
    }

    .form-input, .form-textarea {
        width: 100%;
        padding: 14px 15px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        transition: all 0.3s ease;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #fff;
    }

    .form-input:focus, .form-textarea:focus {
        outline: none;
        border-color: #4a90e2;
        box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
    }

    .form-textarea {
        resize: vertical;
        min-height: 350px;
        line-height: 1.6;
    }

    .btn-group {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 40px;
    }

    .btn {
        padding: 12px 28px;
        font-size: 16px;
        font-weight: 600;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.2s;
        text-decoration: none; /* a 태그일 경우 밑줄 제거 */
        display: inline-block;
    }

    .btn-cancel {
        background-color: #e9ecef;
        color: #495057;
    }
    .btn-cancel:hover { background-color: #dee2e6; }

    .btn-submit {
        background-color: #4a90e2;
        color: white;
    }
    .btn-submit:hover { background-color: #357abd; }
</style>
</head>
<body>

    <!-- 헤더 포함 -->
    <jsp:include page="header.jsp" />

    <!-- 팀원의 .container 스타일과 내 .write-container 스타일을 합침 -->
    <div class="write-container container">
        <h2 class="page-title">📝 새 게시글 작성</h2>

        <form action="writePost" method="post"> 
            
            <!-- 작성자 ID 입력칸 삭제됨 (세션에서 처리) -->
            <!-- 대신 현재 로그인한 사람을 보여주기만 하고 싶다면 아래 코드를 사용 (전송은 안 됨) -->
            <div class="form-group">
                <label class="form-label">작성자</label>
                <input type="text" class="form-input" value="<%= loginUserId %>" readonly style="background-color:#f9f9f9; color:#666;">
            </div>

            <div class="form-group">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-input" placeholder="제목을 입력해 주세요" required>
            </div>

            <div class="form-group">
                <label for="content" class="form-label">내용</label>
                <textarea id="content" name="content" class="form-textarea" placeholder="내용을 자유롭게 작성해 주세요." required></textarea>
            </div>

            <div class="btn-group">
                <a href="community_main.jsp" class="btn btn-cancel">취소</a>
                <button type="submit" class="btn btn-submit">등록 완료</button>
            </div>
        </form>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="footer.jsp" />

</body>
</html>