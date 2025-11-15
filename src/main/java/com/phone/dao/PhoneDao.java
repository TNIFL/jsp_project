package com.phone.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.phone.model.Phone;
import com.phone.util.DB;

/*
 * DB 와 직접적으로 상호작용하는 클래스
 * 핸드폰에 대한 CRUD 기능 구현
 * SQL 쿼리를 사용하여 데이터베이스와 통신
 * 
 * Service 계층에서 이 Dao 클래스를 호출하여 데이터 접근
 * jsp 에서 dao 에 직접 접근하지 않고 service 를 통해 접근
 */

public class PhoneDao {
	// 전체 핸드폰 조회
	//리턴값을 List<Phone> 으로
	public List<Phone> getAllPhones() {
		// Phone 객체를 담을 리스트 생성
		List<Phone> list = new ArrayList<>();
		// phone 테이블의 모든 컬럼을 phone_id 기준으로 내림차순 정렬하여 조회
        String sql = "SELECT * FROM phone ORDER BY phone_id DESC";
        // DB 연결 및 쿼리 실행
        // try-with-resources 문을 사용하여 자원 자동 해제 / try ( ... ) { }
        // Connection conn에 DB.getConnection 을 사용하여 DB 연결을 하는 객체 생성
        // PreparedStatement ps 를 사용하여 SQL 쿼리를 준비하는 객체 생성
        // ps.executeQuery() : SELECT 문을 실제 DB 에서 실행
        // ResultSet rs 를 사용하여 쿼리 실행 결과를 저장하는 객체 생성
        try (Connection conn = DB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
        	// rs 에 저장된 결과를 반복문을 통해 하나씩 처리
        	// rs.next() : 다음 행이 있으면 true 반환, 없으면 false
            while (rs.next()) {
                Phone phone = new Phone(
                	// ResultSet 에서 각 컬럼의 값을 추출하여 Phone 객체 생성
                	// rs.get자료형("컬럼명")
                    rs.getInt("phone_id"),
                    rs.getInt("year_of_release"),
                    rs.getInt("price"),
                    rs.getInt("storage_gb"),
                    rs.getInt("ram"),
                    rs.getInt("battery"),
                    rs.getDouble("display_inch"),
                    rs.getDouble("weight"),
                    rs.getString("brand"),
                    rs.getString("model"),
                    rs.getString("processor"),
                    rs.getString("display_info"),
                    rs.getString("camera"),
                    rs.getString("connectivity"),
                    rs.getString("special_features"),
                    rs.getString("size")
                );
                // Phone 객체를 리스트에 추가
                list.add(phone);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        // 완성된 리스트 반환
    	return list;
    }
	// 단일 휴대폰 조회
	// Phone 객체 하나만 리턴(id 로 조회)
    public Phone getPhoneById(int id) {
    	// 결과를 저장할 Phone 객체 생성
    	// 아직 조회 전이므로 초기값으로 null 설정
    	// 만약 조회 결과가 없으면 초기값 null 그대로 반환
    	Phone phone = null;
    	// phone 테이블에서 특정 phone_id 에 해당하는 행 조회
    	// ? 는 PreparedStatement 에서 나중에 값 설정
    	// ? 에 getPhoneById의 파라미터인 int id 값 들어감
        String sql = "SELECT * FROM phone WHERE phone_id = ?";
        // DB 연결 및 쿼리 실행
        // try-with-resources 문을 사용하여 자원 자동 해제
        // Connection conn에 DB.getConnection 을 사용하여 DB 연결을 하는 객체 생성
        // PreparedStatement ps 를 사용하여 SQL 쿼리를 준비하는 객체 생성
        try (Connection conn = DB.getConnection();
        	PreparedStatement ps = conn.prepareStatement(sql)) {
        	// sql 쿼리 안에 첫번째 ? 에 id 값 설정
        	ps.setInt(1, id);
        	// 쿼리 실행 및 결과 저장
        	// ps.executeQuery() : SELECT 문을 실제 DB 에서 실행
        	// 실행 결과를 rs에 저장
        	try (ResultSet rs = ps.executeQuery()) {
        		// rs.next() : 다음 행이 있으면 true 반환, 없으면 false
        		// rs.next() 처음에는 첫번째 행 이전에 커서가 위치하므로
        		// 한번 호출해야 첫번째 행으로 이동
        		if (rs.next()) {
        			// 조회된 값을 사용해 새로운 Phone 객체 생성
        			phone = new Phone(
    					rs.getInt("phone_id"),
    					rs.getInt("year_of_release"),
    					rs.getInt("price"),
    					rs.getInt("storage_gb"),
    					rs.getInt("ram"),
    					rs.getInt("battery"),
    					rs.getDouble("display_inch"),
    					rs.getDouble("weight"),
    					rs.getString("brand"),
    					rs.getString("model"),
    					rs.getString("processor"),
    					rs.getString("display_info"),
    					rs.getString("camera"),
    					rs.getString("connectivity"),
    					rs.getString("special_features"),
    					rs.getString("size")
    				);
        		}
        	}
        } catch (Exception e) {
			e.printStackTrace();
        }
        return phone;	// 조회된 Phone 객체 반환 (없으면 null 반환)
    }
    // 핸드폰 생성
    // Phone 객체를 받아 DB에 저장
    // 저장 성공 여부를 boolean 으로 반환
    public boolean createPhone(Phone phone) {
    	// phone_id 는 AUTO_INCREMENT 로 자동 생성되므로 제외
    	String sql = "INSERT INTO phone (" +
                "brand, model, price, processor, ram, display_info, display_inch, "
                + "camera, battery, storage_gb, year_of_release, connectivity, "
                + "special_features, weight, size) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    	try (Connection conn = DB.getConnection();
    		PreparedStatement ps = conn.prepareStatement(sql)) {
    		ps.setString(1,  phone.getBrand());          // brand
            ps.setString(2,  phone.getModel());          // model
            ps.setInt(3,     phone.getPrice());          // price
            ps.setString(4,  phone.getProcessor());      // processor
            ps.setInt(5,     phone.getRam());            // ram
            ps.setString(6,  phone.getDisplayInfo());    // display_info
            ps.setDouble(7,  phone.getDisplayInch());    // display_inch
            ps.setString(8,  phone.getCameraInfo());     // camera (DB 컬럼명: camera)
            ps.setInt(9,     phone.getBattery());        // battery
            ps.setInt(10,    phone.getStorage());        // storage_gb (Phone 필드는 storage)
            ps.setInt(11,    phone.getYearOfRelease());  // year_of_release
            ps.setString(12, phone.getConnectivity());   // connectivity
            ps.setString(13, phone.getSpecialFeatures());// special_features
            ps.setDouble(14, phone.getWeight());         // weight
            ps.setString(15, phone.getSize());           // size
            // executeUpdate() 메서드는 영향을 받은 행의 갯수를 반환
            // 실제로 값이 반영이 되었는지 확인 가능
            int rows = ps.executeUpdate();	//INSERT 문 실행
            return rows > 0; // 영향을 받은 행이 1개 이상이면 true 반환
    	} catch (Exception e) {
    		e.printStackTrace();
    		return false;
    	}
	}
    
    // 핸드폰 정보 수정
    // Phone 객체를 받아 DB에 업데이트
    // 수정 성공 여부를 boolean 으로 반환
    // 현재 이 메서드는 전체 정보를 업데이트하도록 되어있음
    // 필요에 따라 부분 업데이트 기능도 추가 가능
    public boolean updatePhone(Phone phone) {
    	// phone_id 를 기준으로 특정 핸드폰 정보 업데이트
    	// 나머지 컬럼들은 ? 로 설정하여 PreparedStatement 에서 값 설정
    	// 마지막에 WHERE 절의 phone_id 도 ? 로 설정
    	// ? 에는 updatePhone의 파라미터인 Phone phone 객체의 각 필드 값 들어감
    	// phone_id 는 WHERE 절에서 사용
    	// 나머지 필드들은 SET 절에서 사용
    	String sql = "UPDATE phone SET " +
                "brand = ?, model = ?, price = ?, processor = ?, ram = ?, "
                + "display_info = ?, display_inch = ?, camera = ?, battery = ?, "
                + "storage_gb = ?, year_of_release = ?, connectivity = ?, "
                + "special_features = ?, weight = ?, size = ? "
                + "WHERE phone_id = ?";
    	// DB 연결 및 쿼리 실행
    	// try-with-resources 문을 사용하여 자원 자동 해제
    	// Connection conn 에 DB.getConnection 을 사용하여 DB 연결을 하는 객체
    	// PreparedStatement ps 를 사용하여 SQL 쿼리를 준비하는 객체 생성
    	// ps.executeUpdate() : UPDATE 문을 실제 DB 에서 실행
    	try (Connection conn = DB.getConnection();
    	     PreparedStatement ps = conn.prepareStatement(sql)) {

    	        ps.setString(1,  phone.getBrand());
    	        ps.setString(2,  phone.getModel());
    	        ps.setInt(3,     phone.getPrice());
    	        ps.setString(4,  phone.getProcessor());
    	        ps.setInt(5,     phone.getRam());
    	        ps.setString(6,  phone.getDisplayInfo());
    	        ps.setDouble(7,  phone.getDisplayInch());
    	        ps.setString(8,  phone.getCameraInfo());
    	        ps.setInt(9,     phone.getBattery());
    	        ps.setInt(10,    phone.getStorage());
    	        ps.setInt(11,    phone.getYearOfRelease());
    	        ps.setString(12, phone.getConnectivity());
    	        ps.setString(13, phone.getSpecialFeatures());
    	        ps.setDouble(14, phone.getWeight());
    	        ps.setString(15, phone.getSize());
    	        // 마지막에 WHERE 절의 phone_id 설정
    	        ps.setInt(16, phone.getPhoneId());  // WHERE phone_id = ?
    	        // ps.executeUpdate() : UPDATE 문을 실제 DB 에서 실행
                // executeUpdate() 메서드는 영향을 받은 행의 갯수를 반환
                // 실제로 값이 반영이 되었는지 확인 가능
                int rows = ps.executeUpdate();	//UPDATE 문 실행
                return rows > 0; // 영향을 받은 행이 1개 이상이면 true 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
    }
	// 핸드폰 삭제
    // id 로 특정 핸드폰 삭제
    // 삭제 성공 여부를 boolean 으로 반환
	public boolean deletePhone(int id) {
		// phone_id 가 특정 id 인 행 삭제
		// ? 는 PreparedStatement 에서 나중에 값 설정
		// ? 에 deletePhone의 파라미터인 int id 값 들어감
		String sql = "DELETE FROM phone WHERE phone_id = ?";
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			// sql 쿼리 안에 첫번째 ? 에 id 값 설정
			ps.setInt(1, id);
			// ps.executeUpdate() : DELETE 문을 실제 DB 에서 실행
            // executeUpdate() 메서드는 영향을 받은 행의 갯수를 반환
            // 실제로 값이 반영이 되었는지 확인 가능
            int rows = ps.executeUpdate();	//DELETE 문 실행
            return rows > 0; // 영향을 받은 행이 1개 이상이면 true 반환
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 브랜드별 핸드폰 조회
	// List<Phone> 리턴
	// brand 로 특정 브랜드의 핸드폰들 조회
	// 예: getPhonesByBrand("Apple") -> Apple 핸드폰들 조회
	public List<Phone> getPhonesByBrand(String brand) {
		List<Phone> list = new ArrayList<>();
		// phone 테이블에서 특정 brand 에 해당하는 행들을
		// price 낮은 순 으로 정렬하여 조회
		String sql = "SELECT * FROM phone WHERE brand = ? ORDER BY price ASC";
		try (Connection conn = DB.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			// sql 쿼리 안에 첫번째 ? 에 brand 값 설정
			ps.setString(1,  brand);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Phone phone = new Phone(
						rs.getInt("phone_id"),
						rs.getInt("year_of_release"),
						rs.getInt("price"),
						rs.getInt("storage_gb"),
						rs.getInt("ram"),
						rs.getInt("battery"),
						rs.getDouble("display_inch"),
						rs.getDouble("weight"),
						rs.getString("brand"),
						rs.getString("model"),
						rs.getString("processor"),
						rs.getString("display_info"),
						rs.getString("camera"),
						rs.getString("connectivity"),
						rs.getString("special_features"),
						rs.getString("size")
					);
					list.add(phone);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 에러나도 빈 리스트를 반환 후
		// 호출한 쪽에서 빈 리스트인지 확인
		return list;
	}
	
	public List<Phone> getPhonesByPriceRange(int minPrice, int maxPrice) {
		List<Phone> list = new ArrayList<>();
		// phone 테이블에서 price 가 minPrice 와 maxPrice 사이인
		// 핸드폰들 조회
		// price 낮은 순 으로 정렬하여 조회
		String sql = "SELECT * FROM phone WHERE price BETWEEN ? AND ? ORDER BY price ASC";
		
		try (Connection conn = DB.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql)) {
			// sql 쿼리 안에 첫번째 ? 에 minPrice 값 설정
			// 두번째 ? 에 maxPrice 값 설정
			ps.setInt(1, minPrice);
			ps.setInt(2, maxPrice);
			// rs 에 저장된 결과를 반복문을 통해 하나씩 처리
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Phone phone = new Phone(
						rs.getInt("phone_id"),
						rs.getInt("year_of_release"),
						rs.getInt("price"),
						rs.getInt("storage_gb"),
						rs.getInt("ram"),
						rs.getInt("battery"),
						rs.getDouble("display_inch"),
						rs.getDouble("weight"),
						rs.getString("brand"),
						rs.getString("model"),
						rs.getString("processor"),
						rs.getString("display_info"),
						rs.getString("camera"),
						rs.getString("connectivity"),
						rs.getString("special_features"),
						rs.getString("size")
					);
					list.add(phone);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 에러나도 빈 리스트를 반환 후
		// 호출한 쪽에서 빈 리스트인지 확인
		return list;
	}
	
}
