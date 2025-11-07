package com.phone.service;

import java.util.List;

import com.phone.dao.PhoneDao;
import com.phone.model.Phone;

/*
 * Service 클래스는 Dao 를 이용한 데이터 접근 + 비즈니스 로직 구현부
 * Dao 클래스에 직접적으로 접근하지 않고, service 클래스를 통해서 접근
 * jsp 도 마찬가지로 Dao에 직접 접근하지 않고, service 클래스를 통해서 접근
 * 
 * 회원가입, 로그인, 사용자 정보 수정, 사용자 계정 삭제 등의 기능 구현
 */
public class PhoneService {
	private final PhoneDao phoneDao = new PhoneDao();
	//핸드폰 전체 조회
	public List<Phone> getAllPhones() {
		return phoneDao.getAllPhones();
	}
	//핸드폰 아이디로 조회
	public Phone getPhoneById(int id) {
		return phoneDao.getPhoneById(id);
	}
	//핸드폰 삽입
	public void insertPhone(Phone phone) {
		phoneDao.createPhone(phone);
	}
	//핸드폰 수정
	public boolean updatePhone(Phone phone) {
		return phoneDao.updatePhone(phone);
	}
	//핸드폰 삭제
	public boolean deletePhone(int id) {
		return phoneDao.deletePhone(id);
	}
	//비즈니스 로직 예시
	public void comparePhoneLogic() {
		//여기서 핸드폰 비교 비즈니스 로직 작성
	}
	//가성비 핸드폰 찾기 비즈니스 로직 예시
	public void findCostEfffectivePhoneLogic() {
		//여기서 가성비 핸드폰 찾기 비즈니스 로직 작성
	}
	//브랜드별 필터링
	public List<Phone> filterPhonesByBrand(String brand) {
		return phoneDao.getPhonesByBrand(brand);
	}
	//가격대별 필터링
	public List<Phone> filterPhonesByPriceRange(int minPrice, int maxPrice) {
		return phoneDao.getPhonesByPriceRange(minPrice, maxPrice);
	}
}
