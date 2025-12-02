package com.phone.model;

public class User {
	private String userId;			//로그인할 때 사용할 ID(primary key)	
	private String password;		//비밀번호
	private String nickname;		//사용자가 사용할 닉네
	
	// 기본 생성자
	public User() {}
	
	// 생성자
	public User( String userId, String password,String nickname) {
		this.userId = userId;
		this.password = password;
		this.nickname = nickname;
	}
	// DB에서 유저 정보 가져올 때 사용하는 생성자
	public User(String nickname, String userId) {
		this.nickname = nickname;
		this.userId = userId;
	}
	
	// Getters and Setters
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
		
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
		
	}

}
