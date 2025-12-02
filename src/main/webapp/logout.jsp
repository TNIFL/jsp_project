<%
    session.invalidate(); // 세션 초기화
    response.sendRedirect("mainpage.jsp"); // 메인 페이지로 이동
%>

