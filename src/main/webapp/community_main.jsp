<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.phone.dao.PostDao" %>
<%@ page import="com.phone.model.Post" %>

<%
    // 게시글 데이터 가져오기
    PostDao dao = new PostDao();
    List<Post> posts = dao.getAllPosts();
    request.setAttribute("posts", posts);

    // [로그인 체크]
    // 세션에서 로그인 아이디 가져오기
    String currentUserId = (String) session.getAttribute("userID");
    System.out.println("커뮤니티 페이지 세션 userID = " + currentUserId);
   
    
    // ★ 테스트용
    // currentUserId = "test"; 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>

<!-- 공통 CSS 연결 (헤더, 푸터 스타일 등) -->
<link href="https://getbootstrap.com/docs/5.3/dist/css/bootstrap.min.css" rel="stylesheet">     
		<link rel="stylesheet" href="1.css">

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
        text-align: center; /* 내용 가운데 정렬 */
    }
    
    /* 제목은 왼쪽 정렬 */
    table td.title-col {
        text-align: left;
    }

    table tr:hover {
        background: #f7f9ff;
    }

    /* 글쓰기 버튼 스타일 */
    .write-btn {
        display: inline-block; /* 버튼 크기 잡히도록 */
        margin-bottom: 15px;
        background: #6677ff;
        padding: 8px 15px;
        border-radius: 6px;
        color: #fff;
        text-decoration: none;
        font-weight: bold;
        cursor: pointer;
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

    <!-- [수정됨] 로그인 상태에 따라 다른 동작을 하는 글쓰기 버튼 -->
    <% if (currentUserId != null) { %>
        <!-- 1. 로그인 상태: 글쓰기 페이지로 바로 이동 -->
        <a href="write_post.jsp" class="write-btn">✏ 글쓰기</a>
    <% } else { %>
        <!-- 2. 비로그인 상태: 알림창 띄우고 로그인 페이지로 이동 -->
        <a href="javascript:alert('로그인이 필요한 서비스입니다.'); location.href='login.jsp';" class="write-btn">✏ 글쓰기</a>
    <% } %>

    <table>
        <colgroup>
            <col width="10%" />
            <col width="50%" />
            <col width="15%" />
            <col width="10%" />
            <col width="15%" />
        </colgroup>
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
                if (posts != null && posts.size() > 0) {
                    for (Post p : posts) {
            %>
                <tr>
                    <td><%= p.getPostId() %></td>
                    <td class="title-col">
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
                } else {
            %>
                <tr>
                    <td colspan="5" style="padding: 20px; color: #999;">게시글이 없습니다.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>