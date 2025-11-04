package com.phone.service;

import java.util.List;

import com.phone.dao.CommentDao;
import com.phone.model.Comment;

/*
 * Service 클래스는 Dao 를 이용한 데이터 접근 + 비즈니스 로직 구현부
 * Dao 클래스에 직접적으로 접근하지 않고, service 클래스를 통해서 접근
 * jsp 도 마찬가지로 Dao에 직접 접근하지 않고, service 클래스를 통해서 접근
 * 
 * 회원가입, 로그인, 사용자 정보 수정, 사용자 계정 삭제 등의 기능 구현
 */
public class CommentService {
	private final CommentDao commentDao = new CommentDao();
	
	//댓글 생성
	public void createComment(int commentId, int postId, String userId, String content, String timestamp) {
		commentDao.createComment(commentId, postId, userId, content, timestamp);
	}
	//특정 게시물의 모든 댓글 조회
	public List<Comment> getAllCommentsByPostId(int postId) {
		return commentDao.getAllCommentsByPostId(postId);
	}
	//댓글 수정
	public void updateComment(int commentId, String content) {
		commentDao.updateComment(commentId, content);
	}
	//댓글 삭제
	public void deleteComment(int commentId) {
		commentDao.deleteComment(commentId);
	}
	
}
