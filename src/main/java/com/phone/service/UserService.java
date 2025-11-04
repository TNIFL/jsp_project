package com.phone.service;

import com.phone.dao.UserDao;

/*
 * Service 클래스는 Dao 를 이용한 데이터 접근 + 비즈니스 로직 구현부
 * Dao 클래스에 직접적으로 접근하지 않고, service 클래스를 통해서 접근
 * jsp 도 마찬가지로 Dao에 직접 접근하지 않고, service 클래스를 통해서 접근
 * 
 * 회원가입, 로그인, 사용자 정보 수정, 사용자 계정 삭제 등의 기능 구현
 */


public class UserService {
	//UserDao 객체 생성 -> 실제 DB와 연동을 담당
	private final UserDao userDao = new UserDao();
	
	public boolean registerUser(String userId, String password, String email) {
		//여기서 회원가입 비즈니스 로직 작성
		//dao의 createUser 메서드 호출
		return userDao.createUser(userId, password, email);
	}
	
	public boolean loginUser(String userId, String password) {
		//UserDao의 getUserById 메서드를 이용해 user의 데이터 가져오고 조회
		//여기서 로그인 비즈니스 로직 작성
		return false;
	}
	
	public void updateUserInfo(String nickname, String userId, String newPassword) {
		//여기서 사용자 정보 수정 비즈니스 로직 작성
		//dao의 updateUser 메서드 호출
		//return 값 추후 변경
	}
	
	public void deleteUserAccount(String userId) {
		//여기서 사용자 계정 삭제 비즈니스 로직 작성
		//dao의 deleteUser 메서드 호출
	}
	
}
