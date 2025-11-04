package com.phone.dao;

import com.phone.model.User;

/*
 * DB 와 직접적으로 상호작용하는 클래스
 * 유저에 대한 CRUD 기능 구현
 * SQL 쿼리를 사용하여 데이터베이스와 통신
 * 
 * Service 계층에서 이 Dao 클래스를 호출하여 데이터 접근
 * jsp 에서 dao 에 직접 접근하지 않고 service 를 통해 접근
 */
public class UserDao {
	public User getUserById(String userId) {
		return null;	//나중에 User 객체로 변경
	}
	
	public boolean createUser(String nickname, String userId, String password) {
		// DB에 사용자 정보 저장
		return false;
	}
	
	public String readUser(String userId) {
		// DB에서 사용자 정보 조회
		return null;	//나중에 User 객체로 변경
	}
	
	public Boolean updateUser(String nickname, String userId, String password) {
		// DB에서 사용자 정보 수정
		return false;
	}
	
	public void deleteUser(String userId) {
		// DB에서 사용자 정보 삭제
	}
	
	
}
