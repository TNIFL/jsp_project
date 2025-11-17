package com.phone.dao;

import com.phone.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phone.util.DB;

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
		// 아무것도 없으면 null 이 반환
		User user = null;
		// users DB 에서 데이터 가져오기(userId 와 같은)
		String sql = "SELECT * FROM users WHERE = ?";
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					user = new User(
						rs.getString("nickname"),
						rs.getString("userId")
						// password 는 가져오지 않음
						//rs.getString("password")
					);
				}
			}	
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return user;	//나중에 User 객체로 변경
	}
	
	public boolean createUser(User user) {
		String sql = "INSERT INTO users (nickname, userId, password) VALUES (?, ?, ?)";
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getNickname());
			ps.setString(2, user.getUserId());
			ps.setString(3, user.getPassword());
			
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	// 모든 유저를 가져오는 메서드
	public List<User> readAllUsers() {
		String sql = "SELECT * FROM users";
		List<User> list = new ArrayList<>();
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				User user = new User(
					rs.getString("nickname"),
					rs.getString("userId"),
					rs.getString("password")
				);
				// 반환 할 때 리스트로 반환
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return list;	//나중에 User 객체로 변경
	}
	
	// update 할 때 nickname, userId, password 파라미터 별로 따로 업데이트 가능하게 해야할지 모르겠음
	// 우선은 어떤 정보든간에 업데이트 하면 전부 다 업데이트
	public Boolean updateUser(User user) {
		// 업데이트 할 때 userId 또는 nickname을 키 값으로 검색 해야함
		// 키 값은 userId 로
		// 근데 전부 다 업데이트 해야하니까 전부 SET 에 추가함
		String sql = "UPDATE users SET nickname = ?, userId = ?, password = ? WHERE userId = ?";
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, user.getNickname());
			ps.setString(2, user.getUserId());
			ps.setString(3, user.getPassword());
			// UPDATE 를 하기위해 검색 할 때 사용하는 키 값은 userID
			ps.setString(4, user.getUserId());
			// DB에 sql 문 실행 및 반영확인
			int rows = ps.executeUpdate();
			// 영향을 받은 행이 1개 이상이면 true 반환
			return rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteUser(String userId) {
		String sql = "DELETE FROM users WHERE userId = ?";
		
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, "userId");
			int rows = ps.executeUpdate();
			return rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
			
	}
	
	
}
