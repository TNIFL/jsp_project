package com.phone.model;

public class User {
	private String nickname;		//사용자가 사용할 닉네
	private String userId;			//로그인할 때 사용할 ID(primary key)	
	private String password;		//비밀번호
	
	// 기본 생성자
	public User() {}
	
	// 생성자
	public User(String nickname, String userId, String password) {
		this.nickname = nickname;
		this.userId = userId;
		this.password = password;
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
