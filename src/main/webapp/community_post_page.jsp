<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.phone.dao.PostDao" %>
<%@ page import="com.phone.dao.CommentDao" %>
<%@ page import="com.phone.model.Post" %>
<%@ page import="com.phone.model.Comment" %>
<%@ page import="java.util.*" %>

<%
    int postId = Integer.parseInt(request.getParameter("postId"));
    PostDao dao = new PostDao();
    CommentDao cdao = new CommentDao();

    dao.increaseClick(postId);  // 조회수 증가
    Post post = dao.getPostById(postId);
    List<Comment> comments = cdao.getAllCommentsByPostId(postId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= post.getTitle() %></title>

<style>
    body { font-family: 'Noto Sans KR', sans-serif; background:#f4f4f4; }

    .post-wrapper {
        width: 900px;
        margin: 30px auto;
        background: #fff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 1px 5px rgba(0,0,0,0.15);
    }

    .post-title { font-size: 24px; font-weight: bold; }
    .post-info { color:#777; margin-bottom:20px; }
    .post-content { white-space: pre-line; font-size:16px; margin-bottom: 30px; }

    .comment-section { margin-top: 30px; }
    .comment { padding: 10px; border-bottom: 1px solid #eee; }
    .comment-writer { font-weight: bold; }
    .comment-date { color:#888; font-size: 12px; }

    .back-btn {
        display:inline-block;
        margin-top:20px;
        background:#6677ff;
        padding:8px 15px;
        border-radius:6px;
        color:#fff;
        text-decoration:none;
    }
</style>

</head>
<body>
<jsp:include page="header.jsp" />
<div class="post-wrapper">

    <div class="post-title"><%= post.getTitle() %></div>
    <div class="post-info">
        작성자: <b><%= post.getUserId() %></b> |
        조회수: <%= post.getClickCount() %> |
        날짜: <%= post.getTimestamp() %>
    </div>

    <div class="post-content"><%= post.getContent() %></div>

    <!-- 댓글 영역 -->
    <div class="comment-section">
        <h3>💬 댓글</h3>

        <%
            if (comments != null) {
                for (Comment c : comments) {
        %>
            <div class="comment">
                <span class="comment-writer"><%= c.getUserId() %></span>  
                <span class="comment-date">(<%= c.getTimestamp() %>)</span>
                <div><%= c.getContent() %></div>
            </div>
        <%
                }
            }
        %>

        <form action="write_comment.jsp" method="post">
            <input type="hidden" name="postId" value="<%= postId %>">

            <textarea name="content" rows="3" style="width:100%;" placeholder="댓글을 입력하세요"></textarea>
            <br>
            <button type="submit">댓글 작성</button>
        </form>
    </div>

    <a href="community_main.jsp" class="back-btn">← 목록으로</a>

</div>
<jsp:include page="footer.jsp" />
</body>
</html>