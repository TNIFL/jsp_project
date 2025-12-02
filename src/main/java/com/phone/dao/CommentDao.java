package com.phone.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phone.model.Comment;
import com.phone.util.DB;

public class CommentDao {

    // 댓글 생성
    public void createComment(int postId, String content, String userId, String timestamp) {

        // 테이블명이 community_comments가 맞는지 DB 확인 필요
        String sql = "INSERT INTO community_comments (post_id, content, writer_id, created_at) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            ps.setString(2, content);
            ps.setString(3, userId);
            ps.setString(4, timestamp);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 특정 게시글의 모든 댓글 조회
    public List<Comment> getAllCommentsByPostId(int postId) {

        List<Comment> list = new ArrayList<>();
        String sql = "SELECT * FROM community_comments WHERE post_id = ? ORDER BY created_at ASC";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Comment 생성자 순서와 DB 컬럼 순서가 맞는지 확인 필요
                Comment c = new Comment(
                        rs.getInt("comment_id"),
                        rs.getInt("post_id"),
                        rs.getString("writer_id"), // DB 컬럼명이 writer_id 인지 확인
                        rs.getString("content"),
                        rs.getString("created_at")
                );
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 댓글 수정
    public void updateComment(int commentId, String content) {
        String sql = "UPDATE community_comments SET content = ? WHERE comment_id = ?";
        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setInt(2, commentId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 댓글 삭제
    public void deleteComment(int commentId) {
        String sql = "DELETE FROM community_comments WHERE comment_id = ?";
        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}