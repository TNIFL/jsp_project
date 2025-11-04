package com.phone.model;

public class Comment {

	private int commentId;		// 댓글 ID (primary key), 번호
	private int postId;			// 댓글이 달린 게시물의 ID (community_post의 postId 참조), 번호
	private String userId;		// 댓글 작성자 ID (user의 id 참조)
	private String content;		// 댓글 내용
	private String timestamp;	// 댓글 작성 시간 (예: "2024-06-15 14:30:00")
	
	// 기본 생성자
	public Comment() {}
	
	// 생성자
	public Comment(int commentId, int postId, String userId, String content, String timestamp) {
		this.commentId = commentId;
		this.postId = postId;
		this.userId = userId;
		this.content = content;
		this.timestamp = timestamp;
	}
	
	// Getters and Setters
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
}
