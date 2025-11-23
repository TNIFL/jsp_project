<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // 필수: 현재 보고 있는 게시글 번호
    String postId = request.getParameter("postId");
%>

<h3>💬 댓글 작성</h3>

<form action="write_comment_process.jsp" method="post">

    <!-- ▼ 추후 로그인 기능 구현되면 자동으로 세션에서 userId 가져옴 -->
    <!-- String userId = (String) session.getAttribute("loginUserId"); -->
    <!-- <input type="hidden" name="userId" value="<%= userId %>"> -->

    <!-- ▼ 지금은 로그인 없음 → 직접 입력 (로그인 생기면 이 input 삭제해야 함) -->
    <label>작성자 ID(임시):</label>
    <input type="text" name="userId" required>
    <br><br>

    <input type="hidden" name="postId" value="<%= postId %>">

    <label>내용:</label><br>
    <textarea name="content" rows="5" cols="50" required></textarea>
    <br><br>

    <button type="submit">댓글 등록</button>
</form>
