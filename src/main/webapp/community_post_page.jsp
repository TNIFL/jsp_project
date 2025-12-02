<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.phone.dao.PostDao" %>
<%@ page import="com.phone.dao.CommentDao" %>
<%@ page import="com.phone.model.Post" %>
<%@ page import="com.phone.model.Comment" %>
<%@ page import="java.util.*" %>

<%
    // 1. 게시글 ID 파싱
    String postIdParam = request.getParameter("postId");
    if (postIdParam == null) {
        response.sendRedirect("community_main.jsp");
        return;
    }
    int postId = Integer.parseInt(postIdParam);

    // 2. 데이터 가져오기
    PostDao dao = new PostDao();
    CommentDao cdao = new CommentDao();

    dao.increaseClick(postId);  // 조회수 증가
    Post post = dao.getPostById(postId);
    List<Comment> comments = cdao.getAllCommentsByPostId(postId);
    
    // 3. 로그인 세션 확인 (팀원이 로그인 기능 만들면 "loginUserId"라는 이름으로 세션 저장한다고 가정)
    int commentId = (int)session.getAttribute("commentId");
    String loginUserId = (String) session.getAttribute("userID");
    
    // ★ 테스트용: 로그인 기능이 아직 없다면 아래 줄 주석을 풀면 로그인 된 것처럼 보입니다.
     //loginUserId = "test"; 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= post.getTitle() %></title>
<link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">
<style>
    body { font-family: 'Noto Sans KR', sans-serif; background:#f4f4f4; margin:0; }
    
    .container {
        width: 900px;
        margin: 40px auto;
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    /* 게시글 스타일 */
    .post-header { border-bottom: 2px solid #eee; padding-bottom: 20px; margin-bottom: 20px; }
    .post-title { font-size: 28px; font-weight: bold; margin-bottom: 10px; }
    .post-meta { color: #888; font-size: 14px; display: flex; justify-content: space-between; }
    
    .post-content { 
        min-height: 200px; 
        font-size: 16px; 
        line-height: 1.6; 
        white-space: pre-wrap; /* 줄바꿈 보존 */
        margin-bottom: 50px;
    }

    /* 댓글 영역 스타일 */
    .comment-section { 
        background-color: #fafafa; 
        padding: 20px; 
        border-radius: 10px; 
        margin-top: 30px;
    }
    .comment-title { font-size: 18px; font-weight: bold; margin-bottom: 15px; border-bottom:1px solid #ddd; padding-bottom:10px;}
    
    .comment-list { margin-bottom: 20px; }
    .comment-item { 
        border-bottom: 1px solid #e0e0e0; 
        padding: 12px 0; 
        display: flex; 
        flex-direction: column;
    }
    .comment-info { font-size: 13px; color: #666; margin-bottom: 5px; }
    .comment-info b { color: #333; font-size: 14px; margin-right: 8px; }
    .comment-text { font-size: 15px; color: #333; }

    /* 댓글 입력 폼 */
    .comment-form { display: flex; gap: 10px; margin-top: 20px; }
    .comment-input { 
        flex: 1; 
        padding: 12px; 
        border: 1px solid #ccc; 
        border-radius: 5px; 
        resize: none; 
    }
    .comment-btn { 
        background: #007bff; 
        color: white; 
        border: none; 
        padding: 0 20px; 
        border-radius: 5px; 
        cursor: pointer; 
        font-weight: bold;
    }
    .comment-btn:hover { background: #0056b3; }
    
    .login-msg {
        text-align: center;
        padding: 20px;
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        color: #555;
    }
    .login-msg a { color: #007bff; text-decoration: none; font-weight: bold; }

    .btn-list {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        background: #555;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
    }
</style>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="header.jsp" />

    <div class="container">
        <!-- 게시글 영역 -->
        <div class="post-header">
            <div class="post-title"><%= post.getTitle() %></div>
            <div class="post-meta">
                <span>작성자: <%= post.getUserId() %></span>
                <span><%= post.getTimestamp() %> | 조회 <%= post.getClickCount() %></span>
            </div>
        </div>

        <div class="post-content"><%= post.getContent() %></div>

        <!-- 댓글 영역 -->
        <div class="comment-section">
            <div class="comment-title">댓글 (<%= comments.size() %>)</div>

            <div class="comment-list">
                <% if (comments != null && comments.size() > 0) { 
                    for (Comment c : comments) { %>
                        <div class="comment-item">
                            <div class="comment-info">
                                <b><%= c.getUserId() %></b> 
                                <span><%= c.getTimestamp() %></span>
                            </div>
                            <div class="comment-text"><%= c.getContent() %></div>
                        </div>
                <%  } 
                   } else { %>
                        <p style="color:#999; text-align:center; padding:20px;">등록된 댓글이 없습니다.</p>
                <% } %>
            </div>

            <!-- 댓글 입력창 (로그인 상태에 따라 다르게 보임) -->
            <% if (loginUserId != null) { %>
                <form action="writeComment" method="post" class="comment-form">
                	<input type="hidden" name="commentId" value= "<%= commentId %>">
                    <input type="hidden" name="postId" value="<%= postId %>">
                    <!-- userId는 서블릿에서 세션으로 처리하므로 여기서 hidden으로 보낼 필요 없음 -->
                    
                    <textarea name="content" class="comment-input" rows="2" placeholder="댓글을 남겨보세요." required></textarea>
                    <button type="submit" class="comment-btn">등록</button>
                </form>
            <% } else { %>
                <div class="login-msg">
                    댓글을 작성하려면 <a href="login.jsp">로그인</a>이 필요합니다.
                </div>
            <% } %>
        </div>

        <a href="community_main.jsp" class="btn-list">목록으로</a>
    </div>

    <!-- 푸터 포함 -->
    <jsp:include page="footer.jsp" />
</body>
</html>