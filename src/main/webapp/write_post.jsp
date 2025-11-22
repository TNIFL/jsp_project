<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h2>글 작성</h2>

<form action="writePost" method="post">
    <label>작성자 ID:</label>
    <input type="text" name="userId" required><br><br>

    <label>제목:</label>
    <input type="text" name="title" required><br><br>

    <label>내용:</label><br>
    <textarea name="content" rows="10" cols="50" required></textarea><br><br>

    <button type="submit">등록</button>
</form>