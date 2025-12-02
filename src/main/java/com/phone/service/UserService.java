package com.phone.service;

import java.sql.*;
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
    // UserDao 객체 생성 -> 실제 DB와 연동을 담당
    private final UserDao userDao = new UserDao();

    public List<User> readAllUsers() {
        return userDao.readAllUsers();
    }

    public User getUserById(String userId) {
        return userDao.getUserById(userId);
    }

    public boolean createUser(User user) {
        return userDao.createUser(user);
    }

    /*
     * 로그인 메서드
     */
    public User loginUser(String userId, String password) {
        User user = userDao.getUserById(userId);

        if (user != null) {
            // ✅ 콘솔에 DB에서 가져온 값과 입력값을 찍어보기
            System.out.println("DB에서 조회된 아이디: [" + user.getUserId() + "]");
            System.out.println("DB에서 조회된 비밀번호: [" + user.getPassword() + "]");
            System.out.println("입력한 비밀번호: [" + password + "]");

            // 공백 제거 후 비교
            if (user.getPassword().trim().equals(password.trim())) {
                System.out.println("로그인 성공!");
                return user;
            } else {
                System.out.println("로그인 실패: 비밀번호 불일치");
            }
        } else {
            System.out.println("로그인 실패: DB에 해당 아이디 없음 → " + userId);
        }

        return null;
    }

    public boolean logoutUser(String userId) {
        return false; // JSP 세션에서 처리
    }

    public boolean updateUser(User user) {
        return userDao.updateUser(user);
    }

    public boolean deleteUser(String userId) {
        return userDao.deleteUser(userId);
    }

    /*
     * 회원가입 메서드
     * DB에 사용자 추가
     * 중복 아이디 체크 후 INSERT 실행
     */
    public boolean registerUser(String id, String password, String nickname) {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
            	    "jdbc:mysql://localhost:3306/ecompare?useUnicode=true&characterEncoding=UTF-8",
            	    "root", "1234"
            	);


            // 중복 아이디 체크
            String checkSql = "SELECT COUNT(*) FROM users WHERE id = ?";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, id);
            rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("회원가입 실패: 이미 존재하는 아이디");
                return false;
            }

            // INSERT 실행
            String insertSql = "INSERT INTO users (id, password, nickname) VALUES (?, ?, ?)";
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, id);
            insertStmt.setString(2, password);
            insertStmt.setString(3, nickname);

            int result = insertStmt.executeUpdate();
            return result == 1;

        } catch (Exception e) {
            System.out.println("회원가입 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (checkStmt != null) checkStmt.close(); } catch (Exception e) {}
            try { if (insertStmt != null) insertStmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
