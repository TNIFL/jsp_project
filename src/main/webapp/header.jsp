<%@ page contentType="text/html; charset=utf-8" %>
<%
    // 세션에서 로그인한 사용자 아이디 가져오기
    String userId = (String) session.getAttribute("userID");
%>

<div class="menu">
  <ul>
    <li class="margin-1"><a href="mainpage.jsp">홈</a></li>
    <li class="margin-1"><a href="product_list_page.jsp">제품 리스트</a></li>
    <li class="margin-1"><a href="compare_page.jsp">제품 비교</a></li>
    <li class="margin-1"><a href="find_page.jsp">가성비 찾기</a></li>
    <li class="margin-1"><a href="community_main.jsp">커뮤니티</a></li>

<%
    if (userId != null) {
        // 로그인 상태일 때
%>
    <li class="margin-51"><span><strong><%= userId %></strong>님</span></li>
    <li class="margin-1"><a href="logout.jsp">로그아웃</a></li>
<%
    } else {
        // 로그인하지 않았을 때
%>
    <li class="margin-50"><a href="login.jsp">로그인</a></li>
    <li class="margin-1"><a href="signup.jsp">회원가입</a></li>
<%
    }
%>
  </ul>
</div>
