package com.phone.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

// ▼ Tomcat 10 이상에서는 javax 대신 jakarta를 사용해야 합니다.
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.phone.service.CommentService;

@WebServlet("/writeComment")
public class WriteCommentServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private CommentService commentService = new CommentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. 세션에서 로그인된 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("loginUserId");

        // ★ 팀원이 로그인 기능을 아직 안 만들었다면? 테스트를 위해 아래 주석을 풀고 강제로 ID를 넣으세요.
         userId = "test"; 

        // 로그인이 안 되어 있다면 로그인 페이지로 튕겨내기
        if (userId == null) {
            response.sendRedirect("login.jsp"); 
            return;
        }

        // 2. 파라미터 받기
        String postIdStr = request.getParameter("postId");
        String content = request.getParameter("content");

        if (postIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("community_main.jsp");
            return;
        }

        int postId = Integer.parseInt(postIdStr);

        // 3. 현재 시간 생성
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // 4. 서비스 호출 (댓글 저장)
        commentService.createComment(postId, userId, content, timestamp);

        // 5. 처리가 끝나면 다시 해당 게시글 상세 페이지로 이동
        // (주의: 상세페이지 파일명이 detail_page.jsp 인지 community_post_page.jsp 인지 확인 후 수정하세요)
        response.sendRedirect("community_post_page.jsp?postId=" + postId); 
    }
}