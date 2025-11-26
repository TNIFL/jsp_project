package com.phone.service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	// Dao 객체, DB에 접근하기 위해 사용
	private final PhoneDao phoneDao = new PhoneDao();
	//핸드폰 전체 조회
	public List<Phone> getAllPhones() {
		List<Phone> list = phoneDao.getAllPhones();
		// 리스트에 폰들 넣고
		// 점수 계산해서 각 폰에 setScore
		applyScore(list);
		return list;
	}
	//핸드폰 아이디로 조회
	public Phone getPhoneById(int id) {
		Phone phone = phoneDao.getPhoneById(id);
		// 단일 핸드폰에도 점수 적용
		applyScore(phone);
		return phone;
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
	// 핸드폰 비교 비즈니스 로직
	// id1, id2로 각각의 핸드폰 phone_id 를 가져와 비교
	// 더 좋은 제품의 phone_id 를 반환함
	public Phone comparePhoneLogic(int id1, int id2) {
	    Phone phone1 = phoneDao.getPhoneById(id1);
	    Phone phone2 = phoneDao.getPhoneById(id2);
	    // 이 if문은 핸드폰 하나라도 없을 경우를 찾기 위해 존재
	    // 하지만 굳이 여기서 해야할까?
	    // 그냥 메서드 호출하기 전에 존재하는지 검사 한 후에 메서드로 넘기는게 좋지 않을까?
	    // 일단 주석처리하고 추후에 메서드 호출 전 검사 해봐야함
	    
	    
	    if (phone1 == null || phone2 == null) {
	    	System.out.println("하나 이상의 핸드폰을 찾을 수 없습니다.");
	    	return null;
	    }
	    
	    double score1 = calculatePhoneScore(phone1);
	    double score2 = calculatePhoneScore(phone2);
	    
	    return (score1 >= score2) ? phone1 : phone2;	// score1 이 score2 보다 크거나 같을 시 phone1 리턴 / 아니라면 phone2 리턴
	    
	}
	//가성비 핸드폰 찾기 비즈니스 로직
	// 가성비의 기준은 점수가 높으면서 가격은 낮은 제품
	// 가성비 지수 = 점수 / 가격
	// 예
	// 폰 A : 점수 80, 가격 1,600,000 -> 80 / 1,600,000 = 0.00005
	// 폰 B : 점수 75, 가격 1,000,000 -> 75 / 1,000,000 = 0.000075
	// 가성비 지수는 B 가 더 높음 -> B 가 가성비 더 좋은 폰
	public Phone findCostEfffectivePhoneLogic(int minPrice, int maxPrice) {
		// min, max 사이에 있는 폰들 가져옴
		// phoneDao.getPhonesByPriceRange(min, max) 를 통해 가져옴
		// 각 폰 마다 calculatePhoneScore(phone) 으로 점수 계산
		// score / price 로 가성비 지수 계산
		// 그 중 점수가 높은 폰 리턴
		// 우선 가격으로 1차 필터링
		List<Phone> list = phoneDao.getPhonesByPriceRange(minPrice, maxPrice);
		if (list == null || list.isEmpty()) {
			return null;
		}
		Phone best = null;
		
		// double 자료형이 가질 수 있는 가장 작은 값
		// 가장 작은 값을 기준으로 잡아야지 나중에 비교하면서 갱신 가능
		// 맨 처음 ratio는 무조건 bestRatio 보다 크니까 최고값 후보로 등록됨
		// 이후 값들이 크면 계속 갱신
		double bestRatio = Double.NEGATIVE_INFINITY;
		
		for (Phone p : list) {
			double score = calculatePhoneScore(p);
			double price = p.getPrice();
			// 가격이 0원 이거나 이상한 값은 스킵
			if (price <= 0) {
				continue;
			}
			// 가성비 지수 계산
			double ratio = score / price;
			
			// 가성비 지수 높은걸로 갱신
			if (ratio > bestRatio) {
				bestRatio = ratio;
				// 반환 할 Phone 객체
				best = p;
			}
		}
		return best;
	}
	/*
	===============================================================
	Phone 점수 계산 규칙 (총점 목표: 좋은 제품 = 70~95점)
	===============================================================

	▶ 총점 구성 요소 (각 항목별 최대 점수)
	- year_of_release     최대 +12
	- price               최대 -18
	- storage             최대 +10
	- ram                 최대 +15
	- battery             최대 +10
	- display_inch        최대 +8
	- weight              최대 +5
	- camera              최대 +12
	- connectivity        최대 +10
	- special_features    최대 +10


	===============================================================
	1) 출시년도 점수 (최신일수록 +)
	---------------------------------------------------------------
	currentYear = 2025
	yearDiff = currentYear - year

	yearDiff ≤ 0      → +12
	yearDiff = 1       → +10
	yearDiff = 2       → +8
	yearDiff = 3~4     → +5
	yearDiff ≥ 5       → +2


	===============================================================
	2) 가격 점수 (비쌀수록 감점, 최대 -18)
	---------------------------------------------------------------
	pricePenalty = (price / 100,000) × 0.6
	최대 감점 = -10


	===============================================================
	3) 저장공간 (클수록 +)
	---------------------------------------------------------------
	≥ 512GB   → +10
	≥ 256GB   → +8
	≥ 128GB   → +6
	≥ 64GB    → +4
	그 미만    → +2


	===============================================================
	4) RAM (클수록 +)
	---------------------------------------------------------------
	≥ 16GB   → +15
	≥ 12GB   → +12
	≥ 8GB    → +9
	≥ 6GB    → +7
	≥ 4GB    → +5
	그 미만   → +3


	===============================================================
	5) 배터리 (용량 클수록 +)
	---------------------------------------------------------------
	≥ 5500mAh → +10
	≥ 5000mAh → +9
	≥ 4500mAh → +8
	≥ 4000mAh → +7
	≥ 3500mAh → +5
	그 미만     → +3


	===============================================================
	6) 화면 크기 (클수록 +)
	---------------------------------------------------------------
	≥ 6.8" → +8
	≥ 6.5" → +7
	≥ 6.1" → +6
	≥ 5.8" → +5
	그 미만 → +4


	===============================================================
	7) 무게 (가벼울수록 +)
	---------------------------------------------------------------
	≤ 180g → +5
	≤ 200g → +4
	≤ 220g → +3
	≤ 240g → +2
	그 이상 → +1


	===============================================================
	8) 카메라 (주요 MP 기준, 렌즈 개수 보너스 없음)
	---------------------------------------------------------------
	≥ 200MP → +12
	≥ 108MP → +10
	≥ 64MP  → +8
	≥ 50MP  → +7
	≥ 48MP  → +6
	≥ 12MP  → +4
	그 미만  → +2


	===============================================================
	9) 연결성 (좋을수록 +, 최대 +10)
	---------------------------------------------------------------
	5G                → +3
	Wi-Fi 7           → +4
	Wi-Fi 6E          → +3
	Wi-Fi 6           → +2
	Wi-Fi 5           → +1
	Bluetooth 5.3~5.4 → +2
	Bluetooth ≥ 5.0   → +1
	(단, 총합 최대 +10)


	===============================================================
	10) 특수 기능 (기능 많은 만큼 +)
	---------------------------------------------------------------
	기능 1개당 +2점
	최대 +10점 (5개까지 인정)


	===============================================================
	최종 총점 계산 공식
	---------------------------------------------------------------
	TOTAL_SCORE =
	    yearScore
	  + storageScore
	  + ramScore
	  + batteryScore
	  + displayScore
	  + weightScore
	  + cameraScore
	  + connectivityScore
	  + specialFeatureScore
	  - pricePenalty
	===============================================================
	*/

	// 최종 핸드폰 점수 계산 메서드
	private double calculatePhoneScore(Phone p) {
        double score = 0.0;

        score += calcYearScore(p.getYearOfRelease());
        score += calcStorageScore(p.getStorage());
        score += calcRamScore(p.getRam());
        score += calcBatteryScore(p.getBattery());
        score += calcDisplayScore(p.getDisplayInch());
        score += calcWeightScore(p.getWeight());
        score += calcCameraScore(p.getCameraInfo());
        score += calcConnectivityScore(p.getConnectivity());
        score += calcSpecialFeaturesScore(p.getSpecialFeatures());

        score -= calcPricePenalty(p.getPrice());
        
        score += 10.0;	// 점수가 너무 낮은 관계로 10점 추가

        return score;
    }
	// 1) 출시연도 점수 (최대 +12점)
    private double calcYearScore(int year) {
        if (year <= 0) return 0.0;

        int currentYear = 2025;
        int diff = currentYear - year;

        if (diff <= 0) {
            return 12.0;     // 올해 또는 미래
        } else if (diff == 1) {
            return 10.0;
        } else if (diff == 2) {
            return 8.0;
        } else if (diff <= 4) {
            return 5.0;
        } else {
            return 2.0;
        }
    }
    // 2) 가격 페널티 (최대 -18점)
    private double calcPricePenalty(int price) {
        if (price <= 0) return 0.0;
        double penalty = (price / 100000.0) * 0.6; // 10만원당 0.6점
        return Math.min(penalty, 10.0);
    }
    // 3) 저장공간 점수 (최대 +10점)
    private double calcStorageScore(int storageGb) {
        if (storageGb >= 512) return 10.0;
        if (storageGb >= 256) return 8.0;
        if (storageGb >= 128) return 6.0;
        if (storageGb >= 64)  return 4.0;
        if (storageGb > 0)    return 2.0;
        return 0.0;
    }
    // 4) RAM 점수 (최대 +15점)
    private double calcRamScore(int ramGb) {
        if (ramGb >= 16) return 15.0;
        if (ramGb >= 12) return 12.0;
        if (ramGb >= 8)  return 9.0;
        if (ramGb >= 6)  return 7.0;
        if (ramGb >= 4)  return 5.0;
        if (ramGb > 0)   return 3.0;
        return 0.0;
    }

    // 5) 배터리 점수 (최대 +10점)
    private double calcBatteryScore(int batteryMah) {
        if (batteryMah >= 5500) return 10.0;
        if (batteryMah >= 5000) return 9.0;
        if (batteryMah >= 4500) return 8.0;
        if (batteryMah >= 4000) return 7.0;
        if (batteryMah >= 3500) return 5.0;
        if (batteryMah > 0)     return 3.0;
        return 0.0;
    }
    // 6) 화면 크기 점수 (최대 +8점)
    private double calcDisplayScore(double inch) {
        if (inch >= 6.8) return 8.0;
        if (inch >= 6.5) return 7.0;
        if (inch >= 6.1) return 6.0;
        if (inch >= 5.8) return 5.0;
        if (inch > 0)    return 4.0;
        return 0.0;
    }

    // 7) 무게 점수 (가벼울수록 +, 최대 +5점)
    private double calcWeightScore(double weight) {
        if (weight <= 0)   return 0.0;
        if (weight <= 180) return 5.0;
        if (weight <= 200) return 4.0;
        if (weight <= 220) return 3.0;
        if (weight <= 240) return 2.0;
        return 1.0;
    }
    // 8) 카메라 점수 (최대 +12점)
    // cameraInfo 예: "200MP + 12MP + 10MP + 10MP"
    private double calcCameraScore(String cameraInfo) {
        if (cameraInfo == null || cameraInfo.isBlank()) {
            return 0.0;
        }

        int mainMp = extractMaxMpFromString(cameraInfo);

        if (mainMp >= 200) return 12.0;
        if (mainMp >= 108) return 10.0;
        if (mainMp >= 64)  return 8.0;
        if (mainMp >= 50)  return 7.0;
        if (mainMp >= 48)  return 6.0;
        if (mainMp >= 12)  return 4.0;
        if (mainMp > 0)    return 2.0;
        return 0.0;
    }
    // 문자열에서 "NNMP" 형태의 숫자 중 가장 큰 값 찾기
    private int extractMaxMpFromString(String text) {
    	// \\d+ -> \d 는 숫자(0~9)
    	// + -> 하나 이상 반복
    	// () 는 캡처 그룹
    	// \\s* -> \s 는 공백 문자(스페이스, 탭 등)
    	// * -> 0개 이상
    	// 숫자와 MP 사이에 공백이 있든 없든 다 허용 ==> 200MP, 200 MP, 둘 다 가능
    	// MP -> 말 그대로 MP라는 텍스트를 찾음
    	// Pattern.CASE_INSENSITIVE -> 대소문자 구분 안함, MP Mp mp mP 전부 매칭 가능
        Pattern pattern = Pattern.compile("(\\d+)\\s*MP", Pattern.CASE_INSENSITIVE);
        //
        Matcher matcher = pattern.matcher(text);
        int max = 0;
        while (matcher.find()) {
            try {
                int value = Integer.parseInt(matcher.group(1));
                //() 안에 있는 group() Strign 을 int 로 파싱 후 사용
                if (value > max) { 
                    max = value;
                }
            } catch (NumberFormatException ignore) {
            }
        }
        return max;
    }
    // 9) 연결성 점수 (최대 +10점)
    private double calcConnectivityScore(String connectivity) {
        if (connectivity == null || connectivity.isBlank()) {
            return 0.0;
        }
        String lower = connectivity.toLowerCase();
        double score = 0.0;

        if (lower.contains("5g"))       score += 3.0;
        if (lower.contains("wi-fi 7") || lower.contains("wifi 7"))   score += 4.0;
        if (lower.contains("wi-fi 6e") || lower.contains("wifi 6e")) score += 3.0;
        else if (lower.contains("wi-fi 6") || lower.contains("wifi 6")) score += 2.0;
        else if (lower.contains("wi-fi 5") || lower.contains("wifi 5")) score += 1.0;

        if (lower.contains("bluetooth 5.3") || lower.contains("bluetooth 5.4")) {
            score += 2.0;
        } else if (lower.contains("bluetooth 5")) {
            score += 1.0;
        }

        return Math.min(score, 10.0);
    }
    // 10) 특수 기능 점수 (기능 1개당 +2, 최대 +10)
    private double calcSpecialFeaturesScore(String features) {
        if (features == null || features.isBlank()) {
            return 0.0;
        }
        // 쉼표 기준으로 기능 분리
        String[] parts = features.split(",");
        int count = 0;
        for (String part : parts) {
            if (part != null && !part.trim().isEmpty()) {
                count++;
            }
        }
        int effectiveCount = Math.min(count, 5); // 최대 5개까지 인정
        return effectiveCount * 2.0; // 1개당 2점
    }
    
	//브랜드별 필터링
	public List<Phone> filterPhonesByBrand(String brand) {
		return phoneDao.getPhonesByBrand(brand);
	}
	//가격대별 필터링
	public List<Phone> filterPhonesByPriceRange(int minPrice, int maxPrice) {
		return phoneDao.getPhonesByPriceRange(minPrice, maxPrice);
	}
	
	// 하나의 핸드폰에 점수 적용
	private void applyScore(Phone phone) {
		if (phone == null) {
			return;
		}
		// 점수 계산 및 적
		double rawScore = calculatePhoneScore(phone);
		// 반올림하여 정수로 변환
		int finalScore = (int) Math.round(rawScore);
		// 핸드폰 객체에 점수 설정
		phone.setScore(finalScore);;
	}
	
	// 핸드폰 리스트에 점수 적용
	// applyScore(Phone phone) 메서드 오버로딩
	private void applyScore(List<Phone> list) {
		if (list == null || list.isEmpty()) {
			return;
		}
		// applyScore(Phone phone) 메서드 재사용
		// 리스트에 존재하는 각각의 핸드폰을 applyScore 메서드로 전달
		// applyScore 메서드는 알아서 각 핸드폰마다 점수를 매겨줄거임
		for (Phone p : list) {
			applyScore(p);
		}
	}
}
