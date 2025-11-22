<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.phone.dao.PostDao" %>
<%@ page import="com.phone.model.Post" %>

<%
    PostDao dao = new PostDao();
    List<Post> posts = dao.getAllPosts();  // 최종적으로 DB에서 불러오는 메서드
    request.setAttribute("posts", posts);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #f4f4f4;
    }

    .wrapper {
        width: 900px;
        margin: 30px auto;
        background: #fff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 1px 5px rgba(0,0,0,0.15);
    }

    h2 {
        margin-bottom: 15px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

    table th {
        background: #dfe4ff;
        padding: 10px;
        border-bottom: 2px solid #888;
    }

    table td {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    table tr:hover {
        background: #f7f9ff;
    }

    .write-btn {
        margin-bottom: 15px;
        background: #6677ff;
        padding: 8px 15px;
        border-radius: 6px;
        color: #fff;
        text-decoration: none;
        font-weight: bold;
    }

    .write-btn:hover {
        background: #5565ee;
    }

    .title-link {
        color: #333;
        text-decoration: none;
    }

    .title-link:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>
<jsp:include page="header.jsp" />
<div class="wrapper">
    <h2>📢 커뮤니티</h2>

    <a href="write_post.jsp" class="write-btn">✏ 글쓰기</a>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th>
            </tr>
        </thead>

        <tbody>
            <%
                if (posts != null) {
                    for (Post p : posts) {
            %>
                <tr>
                    <td><%= p.getPostId() %></td>
                    <td>
                        <a class="title-link" href="community_post_page.jsp?postId=<%= p.getPostId() %>">
                            <%= p.getTitle() %>
                        </a>
                    </td>
                    <td><%= p.getUserId() %></td>
                    <td><%= p.getClickCount() %></td>
                    <td><%= p.getTimestamp() %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>