package com.phone.service;

import java.util.ArrayList;
import java.util.List;

import com.phone.dao.UserDao;
import com.phone.model.User;

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
	
	public List<User> readAllUsers() {
		return userDao.readAllUsers();
	}
	
	public User getUserById(String userId) {
		return userDao.getUserById(userId);
	}
	
	public boolean createUser(User user) {
		//여기서 회원가입 비즈니스 로직 작성
		//dao의 createUser 메서드 호출
		return userDao.createUser(user);
	}

	public boolean loginUser(String userId, String password) {
		// UserDao의 getUserById 메서드를 이용해 user의 데이터 가져오고 조회
		// 로그인 할 때 사용자 입력을 받음
		// userId, password를 받아서
		// DB와 비교 후 존재하면 로그인 성공
		// 존재하지 않으면 실패
		User user = userDao.getUserById(userId);
		if (user.getUserId().equals(userId) && user.getPassword().equals(password)) {
			// 로그인이 성공하는 경우
			// user를 넘겨줘서 jsp 페이지에서 세션에 로그인 정보 저장 해야함
			return true;
		} else {
			return false;
		}
	}
	
	// 굳이 여기서 로그아웃 메서드를 정의할필요 없을듯
	// jsp 페이지에서 세션 로그아웃 하면 됌
	public boolean logoutUser(String userId) {
		//여기서 로그아웃 비즈니스 로직 작성
		//세션에서 사용자 정보 제거
		return false;
	}
	
	public boolean updateUser(User user) {
		//여기서 사용자 정보 수정 비즈니스 로직 작성
		//dao의 updateUser 메서드 호출
		//return 값 추후 변경
		return userDao.updateUser(user);
		
	}
	
	public boolean deleteUser(String userId) {
		//여기서 사용자 계정 삭제 비즈니스 로직 작성
		//dao의 deleteUser 메서드 호출
		return userDao.deleteUser(userId);
	}
	 public boolean registerUser(String id, String pw, String name) {
	        // DB 연결 후 INSERT 수행
	        // 중복 아이디 체크 → INSERT 성공 시 true, 실패 시 false 반환
	        // 예시용이므로 실제 DB 코드는 생략
	        return true; // 또는 false
	    }
}
