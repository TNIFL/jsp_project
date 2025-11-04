package com.phone.dao;

import java.util.List;

import com.phone.model.Comment;


/*
 * DB 와 직접적으로 상호작용하는 클래스
 * 댓글에 대한 CRUD 기능 구현
 * SQL 쿼리를 사용하여 데이터베이스와 통신
 * 
 * Service 계층에서 이 Dao 클래스를 호출하여 데이터 접근
 * jsp 에서 dao 에 직접 접근하지 않고 service 를 통해 접근
 */
public class CommentDao {
	public void createComment(int commentId, int postId, String userId, String content, String timestamp) {
		// DB에 댓글 저장
	}
	
	public List<Comment> getAllCommentsByPostId(int postId) {
		return null; // 나중에 List<Comment>로 변경
	}
	
	public void readComment(int commentId) {
		// DB에서 댓글 조회
	}
	
	public void updateComment(int commentId, String content) {
		// DB에서 댓글 수정
	}
	
	public void deleteComment(int commentId) {
		// DB에서 댓글 삭제
	}
}


  