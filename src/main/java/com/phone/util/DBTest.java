package com.phone.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBTest {
    public static void main(String[] args) {
        try (Connection conn = DB.getConnection()) {
            System.out.println("DB 연결 성공");
            
            // 연결 확인용 간단한 쿼리 (community_posts 테이블이 있는 경우)
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT NOW() AS time");
            if (rs.next()) {
                System.out.println("현재 DB 시간: " + rs.getString("time"));
            }

        } catch (Exception e) {
            System.out.println("DB 연결 실패");
            e.printStackTrace();
        }
    }
}
