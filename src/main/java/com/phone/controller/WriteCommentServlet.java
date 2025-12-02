package com.phone.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.phone.service.CommentService;
//"/writeComment" 주소로 요청이 오면 실행됨
@WebServlet("/writeComment")
public class WriteCommentServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
 // 서비스를 처리 (DAO를 직접 부르지 않고 Service를 거쳐가는 구조)
    private CommentService commentService = new CommentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. 세션에서 로그인된 사용자 ID 가져오기 (글쓰기와 동일)
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");

        // 로그인이 안 되어 있다면 로그인 페이지로 튕겨내기
        if (userId == null) {
            response.sendRedirect("login.jsp"); 
            return;
        }

        // 2. 어느 글(postId)에 달린 댓글인지, 내용은 무엇인지 받기
        String postIdStr = request.getParameter("postId");
        String content = request.getParameter("content");
        // 데이터가 비어있으면 저장하지 않고 목록으로 돌려보냄
        if (postIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("community_main.jsp");
            return;
        }

        int postId = Integer.parseInt(postIdStr);

        // 3. 현재 시간 생성
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // 4. 서비스 호출 (댓글 저장)
        commentService.createComment(postId, content, userId, timestamp);

        // 5. 처리가 끝나면 다시 해당 게시글 상세 페이지로 이동
        
        response.sendRedirect("community_post_page.jsp?postId=" + postId); 
    }
}