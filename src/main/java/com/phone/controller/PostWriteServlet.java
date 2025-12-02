package com.phone.controller;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.phone.dao.PostDao;
//	브라우저에서 "/writePost"라는 주소로 요청을 보내면 이 파일이 작동.
@WebServlet("/writePost")
public class PostWriteServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    // [동작] 폼(Form)에서 method="post"로 전송된 데이터를 처리하는 메서드
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        //한글 깨짐 방지

        // 1. 세션에서 로그인된 사용자 ID 가져오기
        // getParameter()는 안전하지 않으므로 서버가 관리하는 getSession()을 사용
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userID"); //userID라는 이름으로 저장된 값을 꺼냄

        // ★ 테스트용
        // userId = "test"; 

        // 2. 로그인 체크 (테스트 아이디도 없고 세션도 없으면 로그인 페이지로 쫓아내기)
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        // 3. 사용자가 입력한 제목과 내용 가져오기
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // 4. DAO를 통해 글 저장
        PostDao dao = new PostDao();
        // createPost 메서드에서 자동으로 현재 시간을 넣거나, 여기서 생성해서 넘겨주거나 구현 방식에 따라 다를 수 있음.
        // 만약 dao.createPost(userId, title, content) 만 있다면 그대로 사용.
        dao.createPost(userId, title, content);

        // 5. 저장 후 메인 페이지로 이동
        resp.sendRedirect("community_main.jsp");
    }
}