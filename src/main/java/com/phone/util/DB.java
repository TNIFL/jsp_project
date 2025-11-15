package com.phone.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	// DB 접속 정보
	// 본인 환경에 맞게 수정할 것
	// URL 형식: jdbc:mysql://호스트:포트/데이터베이스명
	// 기본 포트는 3306
	// DB 이름은 ecompare 로 통일
	// 먼저 MySQL 에 ecompare DB 생성 후 사용
	// 테이블 양식은 추후 제공 예정
	
	// .env 파일에서 설정한 환경 변수로 DB 접속 정보 불러오기
	// 하드코딩으로 변경
	// 추후 dotenv로 변경 해야함
	private static final String DB_URL = "jdbc:mysql://localhost:3306/ecompare?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
	private static final String DB_USER = "root";
	private static final String DB_PASS = "1234";
	
    private static final String URL = DB_URL;
    // USER 와 PASS 도 본인 환경에 맞게 수정
	private static final String USER = DB_USER;
    private static final String PASS = DB_PASS;

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

// MySQL 이 기본적으로 설치되어있고, 정상적으로 MySQL 이 실행된다는 가정 하에 적은 설명입니다.

// DB 커넥터 드라이브 설치 방법 (혹시 거나 에러가 났을 시 참고)
// 1. MySQL Connector/J 다운로드
//    - MySQL 공식 웹사이트(https://dev.mysql.com/downloads/connector/j)
//      -> 상단의 "Archives" 선택
//      -> 버전은 8.2.0 으로 통일
//      -> Operating System: Platform Independent 선택
//      -> 다운로드 파일 형식: ZIP Archive 선택
//      -> 다운로드 후 압축 해제
// 2. JDBC 드라이버 JAR 파일 찾기
//    - 압축 해제한 폴더 내에서 mysql-connector-java-8.jar 복사
//    - src/main/webapp/WEB-INF/lib/ 폴더에 붙여넣기
//    - lib 폴더가 없을 시 생성
//    - 마우스 우클릭 후 "Refresh"
// 3. MySQL 초기 설정
//    - 각자 환경에 맞는 설정법 찾아서 잘 하시길..
// 4. 연결 테스트
//    - DBTest.java 마우스 우클릭 후 "Run As" -> "Java Application" 선택
//   - "DB 연결 성공" 메시지 확인