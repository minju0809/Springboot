package com.springboot.springboot.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class SecurityController {

  @Autowired
  private HttpSession session;

  @Autowired
  private MemberService service;

  private final String rest_api_key = "bca2874a60dd557309b92b2eb396f029";
  private final String redirect_uri = "http://localhost:8081/login.do";
  // private final String redirect_uri =
  // "http://localhost:8081/login/oauth2/code/kakao";

  @GetMapping("/login.do")
  String login(Model model, @RequestParam(value = "code", required = false) String code, MemberVO vo) {
    // System.out.println("redirect_uri: " + redirect_uri);
    System.out.println("code: " + code);

    if (code == null) {
      model.addAttribute("rest_api_key", rest_api_key);
      model.addAttribute("redirect_uri", redirect_uri);

      return "/login/login";

    } else {
      String accessToken = getAccessToken(code);

      RestTemplate restTemplate = new RestTemplate();
      HttpHeaders headers = new HttpHeaders();
      headers.add("Authorization", "Bearer " + accessToken);
      headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

      HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(headers);
      ResponseEntity<String> response = restTemplate.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
          httpEntity, String.class);
      // System.out.println("==========================================> " +
      // response);
      // Jackson ObjectMapper를 사용하여 JSON 문자열을 Map 객체로 변환
      try {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> responseMap = objectMapper.readValue(response.getBody(),
            new TypeReference<Map<String, Object>>() {
            });

        Map<String, Object> kakaoAccount = (Map<String, Object>) responseMap.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
        String nickname = (String) profile.get("nickname");
        System.out.println("======================+> " + nickname);

        session.setAttribute("nickname", nickname);
        System.out.println("token: " + accessToken);
        // MemberVO uuidCk = service.uuidCk(vo);
        // String uuid = uuidCk.getUuid();
        // System.out.println("uuid!!!: " + uuid);
        // if (uuid == null) {
        // System.out.println("kakao!!!: " + service.uuidCk(vo));
        // service.kakaoInsert(vo);
        // }

      } catch (Exception err) {
        System.out.println("======================+> 실패");
      }
      return "/member/kakaoCk";
    }
  }

  private String getAccessToken(String code) {
    RestTemplate restTemplate = new RestTemplate();

    // 카카오 OAuth 토큰 요청 URL 설정
    String tokenUrl = "https://kauth.kakao.com/oauth/token";

    // 헤더 설정
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

    // 파라미터 설정
    MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
    parameters.add("grant_type", "authorization_code");
    parameters.add("client_id", rest_api_key);
    parameters.add("redirect_uri", redirect_uri);
    parameters.add("code", code);

    // 요청 생성
    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);

    // 요청 보내기
    ResponseEntity<String> response = restTemplate.exchange(tokenUrl, HttpMethod.POST, request, String.class);

    // 응답 처리
    if (response.getStatusCode() == HttpStatus.OK) {
      // JSON 응답에서 액세스 토큰 추출하여 반환
      return extractAccessTokenFromResponse(response.getBody());
    } else {
      throw new RuntimeException("카카오 OAuth 토큰 요청 실패");
    }
  }

  private String extractAccessTokenFromResponse(String responseBody) {
    try {
      // Jackson ObjectMapper를 사용하여 JSON 문자열을 Map 객체로 변환
      ObjectMapper objectMapper = new ObjectMapper();
      Map<String, Object> responseMap = objectMapper.readValue(responseBody, new TypeReference<Map<String, Object>>() {
      });

      // 응답에서 액세스 토큰 추출
      String accessToken = (String) responseMap.get("access_token");
      return accessToken;
    } catch (IOException e) {
      throw new RuntimeException("토큰 응답 파싱 실패", e);
    }
  }

  @GetMapping("/kakaoCk.do")
  private String kakaoCk(String uuid, MemberVO vo) {
    System.out.println("uuid =>>>>>>>>>>>>>>>> " + uuid);

    MemberVO uuidCk = service.uuidCk(vo);
    if (uuidCk == null) { // uuidCk 객체가 null인 경우
      vo.setUuid(uuid);
      service.kakaoInsert(vo);

      MemberVO member = service.uuidCk(vo);
      int member_idx = member.getMember_idx();
      // System.out.println("member_idx: " + member_idx);

      return "redirect:/kakaoForm.do?member_idx=" + member_idx;
    } else {
      String DBuuid = uuidCk.getUuid();
      if (DBuuid == null || !DBuuid.equals(uuid)) { // DBuuid가 null이거나 uuid와 일치하지 않는 경우
        vo.setUuid(uuid);
        service.kakaoInsert(vo);
        return "/jsp";
      } else { // DBuuid와 uuid가 일치하는 경우
        MemberVO member = service.uuidCk(vo);
        int member_idx = member.getMember_idx();

        service.getMember(member);
        if (member.getUsername() == null) {
          // 아이디가 없으면
          return "redirect:/kakaoForm.do?member_idx=" + member_idx;
        } else {
          // 아이디가 있으면
          return "redirect:/loginSuccess.do?member_idx=" + member_idx;
        }
      }
    }
  }

  @GetMapping("/loginSuccess.do")
  String loginSuccess(Principal user, @RequestParam(value = "member_idx", required = false) String memberIdx) {
    // 기본적으로 @RequestParam 어노테이션을 사용할 때 파라미터는 필수적으로 요청되어야 함
    // required = false를 사용하면 해당 요청 파라미터가 요청에 포함되지 않아도 핸들러 메서드가 호출 됨
    // 선택적인 요청 파라미터에 대해 유연하게 처리 가능
    MemberVO vo = new MemberVO();

    if (user != null) {
      System.out.println("===> loginSuccess.do: " + user.getName());
      vo.setUsername(user.getName());

      MemberVO member = service.login(vo);
      System.out.println("member: " + member);

      session.setAttribute("session", member);
    } else {
      // 이때 session에 값을 담아야 아이디는 맞지만 비밀번호가 틀린 경우도 파악을 할 수 있음
      vo.setMember_idx(Integer.parseInt(memberIdx));
      MemberVO member = service.getMember(vo);
      System.out.println("kakaoMember: " + member);

      session.setAttribute("session", member);
    }
    return "/login/loginSuccess";
  }

  @GetMapping("/accessDenied.do")
  String accessDenied() {
    System.out.println("===> accessDenied.do");
    return "/login/accessDenied";
  }
}
