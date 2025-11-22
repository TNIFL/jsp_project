package com.phone.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.phone.dao.PostDao;

@WebServlet("/writePost")
public class PostWriteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        PostDao dao = new PostDao();
        dao.createPost(userId, title, content);

        resp.sendRedirect("community_main.jsp");
    }
}