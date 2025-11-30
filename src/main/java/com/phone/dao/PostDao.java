package com.phone.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phone.model.Post;
import com.phone.util.DB;

public class PostDao {

    // 게시물 생성
    public void createPost(String userId, String title, String content) {

        String sql = "INSERT INTO community_posts (writer_id, title, content) VALUES (?, ?, ?)";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, title);
            ps.setString(3, content);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 전체 게시물 조회
    public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<>();

        String sql = "SELECT post_id, writer_id, title, content, created_at, click_count "
                + "FROM community_posts ORDER BY post_id DESC";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post p = new Post(
                    rs.getInt("post_id"),
                    rs.getString("writer_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("created_at"),
                    rs.getInt("click_count")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 단일 게시물 조회
    public Post getPostById(int postId) {

        String sql = "SELECT * FROM community_posts WHERE post_id = ?";
        Post post = null;

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                post = new Post(
                    rs.getInt("post_id"),
                    rs.getString("writer_id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("created_at"),
                    rs.getInt("click_count")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    // 조회수 증가
    public void increaseClick(int postId) {

        String sql = "UPDATE community_posts SET click_count = click_count + 1 WHERE post_id = ?";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
