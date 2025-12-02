package com.phone.service;

import java.util.List;
import com.phone.dao.CommentDao;
import com.phone.model.Comment;

public class CommentService {

    private final CommentDao commentDao = new CommentDao();

    public void createComment(int commentId, int postId, String content, String userId, String timestamp) {
        commentDao.createComment(commentId, postId, content, userId, timestamp);
    }

    public List<Comment> getAllCommentsByPostId(int postId) {
        return commentDao.getAllCommentsByPostId(postId);
    }

    public void updateComment(int commentId, String content) {
        commentDao.updateComment(commentId, content);
    }

    public void deleteComment(int commentId) {
        commentDao.deleteComment(commentId);
    }
}
