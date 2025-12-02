package com.phone.dao;

import com.phone.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phone.util.DB;

/*
 * UserDao 클래스
 * ----------------------------
 * DB와 직접적으로 상호작용하는 DAO(Data Access Object) 클래스
 * 유저(User)에 대한 CRUD(Create, Read, Update, Delete) 기능을 구현
 * SQL 쿼리를 사용하여 데이터베이스와 통신
 * 
 * Service 계층에서 이 Dao 클래스를 호출하여 데이터 접근
 * JSP에서는 Dao에 직접 접근하지 않고 Service를 통해 접근
 */
public class UserDao {

    /*
     * 특정 유저 조회
     * ----------------------------
     * userId를 기준으로 users 테이블에서 데이터를 가져옴
     * 존재하지 않으면 null 반환
     */
	public User getUserById(String userId) {
	    User user = null;
	    String sql = "SELECT * FROM users WHERE id = ?"; 

	    try (Connection conn = DB.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {

	        ps.setString(1, userId);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                user = new User(
	                    rs.getString("id"),       
	                    rs.getString("password"),
	                    rs.getString("nickname")
	                );
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	    return user;
	}


    /*
     * 유저 생성 (회원가입)
     * ----------------------------
     * users 테이블에 새로운 유저 추가
     */
    public boolean createUser(User user) {
        String sql = "INSERT INTO users (nickname, userId, password) VALUES (?, ?, ?)";
        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getNickname());
            ps.setString(2, user.getUserId());
            ps.setString(3, user.getPassword());

            int rows = ps.executeUpdate();
            return rows > 0; // 1개 이상 행이 추가되면 true 반환
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /*
     * 모든 유저 조회
     * ----------------------------
     * users 테이블의 모든 데이터를 가져와 리스트로 반환
     */
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
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list;
    }

    /*
     * 유저 정보 업데이트
     * ----------------------------
     * userId를 기준으로 nickname, userId, password를 모두 업데이트
     */
    public Boolean updateUser(User user) {
        String sql = "UPDATE users SET nickname = ?, userId = ?, password = ? WHERE userId = ?";
        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getNickname());
            ps.setString(2, user.getUserId());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getUserId()); // WHERE 조건에 사용할 userId

            int rows = ps.executeUpdate();
            return rows > 0; // 1개 이상 행이 수정되면 true 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /*
     * 유저 삭제
     * ----------------------------
     * userId를 기준으로 해당 유저 삭제
     */
    public boolean deleteUser(String userId) {
        String sql = "DELETE FROM users WHERE userId = ?";

        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId); // ✅ 수정: 문자열 "userId"가 아니라 실제 파라미터 값
            int rows = ps.executeUpdate();
            return rows > 0; // 1개 이상 행이 삭제되면 true 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
