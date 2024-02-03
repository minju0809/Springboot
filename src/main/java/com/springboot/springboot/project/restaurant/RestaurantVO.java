package com.springboot.springboot.project.restaurant;

import lombok.Data;

@Data
public class RestaurantVO {
  private int idx;
  private String title; // 시티투어명
  private String extent; // 시티투어유형(순환형,고정형)
  private String reference; // 시티투어 문의처
  private String rights; // 시티투어 지자체의 담당부서
  private String source; // 시티투어 홈페이지
  private String charge; // 시티투어 요금
  private String venue; // 시티투어 탑승장소
  private String time; // 시티투어 운영일시
  private String description; // 시티투어 코스정보
  private String subDescription; // 시티투어 코스 경유지 정보
  private String spatial; // 시티투어 담당 시군구
  private String viaNearTourInfo; // 경유지 근처 관광지 정보
  private String tourAddInfo; // 투어코스 부가 정보
  private String oprBgnTm; // 운영시작시간
  private String oprEndTm; // 운영종료시간
  private String oprintrvlTm; // 배차시간
  private String chargeAddInfo; // 이용요금부가정보
  private String dataStdDt; // 데이터기준일자
  private String dataOfferInst; // 정보제공기관명
  private String rstrNm; // 시티투어 주변 맛집 식당명
  private String rstrRoadAddr; // 시티투어 주변 맛집 식당 주소
  private String rstrLatPos; // 시티투어 주변 맛집 식당 위치정보, 위도
  private String rstrLotPos; // 시티투어 주변 맛집 식당 위치정보, 경도
  private String rstrUrl; // 시티투어 주변 맛집 식당 홈페이지
  private String rstrTelNo; // 시티투어 주변 맛집 식당 전화번호
  private String rstrMenuNm; // 시티투어 주변 맛집 식당 메뉴
  private String rstrMenuPri; // 시티투어 주변 맛집 식당 메뉴 가격
  private String rstrInfoStdDt; // 시티투어 주변 맛집 식당 정보 업데이트 일자
}
