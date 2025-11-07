package com.phone.dao;

import java.sql.*;
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
	
	public List<Phone> getAllPhones() {
    	return null;	//나중에 List<Phone>으로 변경
    }

    public Phone getPhoneById(int id) {
        return null;	//나중에 Phone 객체로 변경
    }
    
    public void createPhone(Phone phone) {
		//DB에 저장
	}
    
    public boolean updatePhone(Phone phone) {
		//DB에서 수정
    	return false;	//db에 값 삽입 후 결과따라 변경
	}
	
	public boolean deletePhone(int id) {
		//DB에서 삭제
		return false;	//db에서 값 제거 후 결과따라 변경
	}
	
	public List<Phone> getPhonesByBrand(String brand) {
		//특정 브랜드의 핸드폰 조회
		return null;	//나중에 List<Phone>으로 변경
	}
	
	public List<Phone> getPhonesByPriceRange(int minPrice, int maxPrice) {
		//특정 가격대의 핸드폰 조회
		return null;	//나중에 List<Phone>으로 변경
	}
	
}
