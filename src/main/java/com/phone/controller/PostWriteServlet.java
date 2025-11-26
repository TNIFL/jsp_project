package com.phone.controller;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.phone.dao.PostDao;

@WebServlet("/writePost")
public class PostWriteServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1. 세션에서 로그인된 사용자 ID 가져오기
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("loginUserId");

        // ★ 테스트용
        // userId = "test"; 

        // 2. 로그인 체크 (테스트 아이디도 없고 세션도 없으면 쫓아내기)
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // 3. DAO를 통해 글 저장
        PostDao dao = new PostDao();
        // createPost 메서드에서 자동으로 현재 시간을 넣거나, 여기서 생성해서 넘겨주거나 구현 방식에 따라 다를 수 있음.
        // 만약 dao.createPost(userId, title, content) 만 있다면 그대로 사용.
        dao.createPost(userId, title, content);

        // 4. 저장 후 메인 페이지로 이동
        resp.sendRedirect("community_main.jsp");
    }
}