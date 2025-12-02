package com.phone.model;

public class Post {
	private int postId;			// 게시물 ID (primary key), 번호
	private String userId;		// 게시물 작성자 ID (user의 userId 참조)
	private String title;		// 게시물 제목
	private String content;		// 게시물 내용
	private String timestamp;	// 게시물 작성 시간 (예: "2024-06-15 14:30:00")
	private int clickCount;		// 조회수
	
	// 기본 생성자
	public Post() {}
	
	// 생성자
	public Post(int postId, String userId, String title, String content, String timestamp, int clickCount) {
		this.postId = postId;
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.timestamp = timestamp;
		this.clickCount = clickCount;
	}
	
	// Getters and Setters
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getClickCount() {
		return clickCount;
	}
	public void setClickCount(int clickCount) {
		this.clickCount = clickCount;
	}

}
