package com.phone.service;

import java.util.List;

import com.phone.dao.PostDao;
import com.phone.model.Post;

public class PostService {

    private final PostDao postDao = new PostDao();

    // 게시물 생성
    public void createPost(String userId, String title, String content) {
        postDao.createPost(userId, title, content);
    }

    // 전체 게시물 조회
    public List<Post> getAllPosts() {
        return postDao.getAllPosts();
    }

    // 게시물 상세 조회
    public Post getPost(int postId) {
        return postDao.getPostById(postId);
    }

    // 조회수 증가
    public void increaseClick(int postId) {
        postDao.increaseClick(postId);
    }
}
