package com.springboot.springboot.controller;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MemberController {
    
  @Autowired
  private MemberService service;

  @Autowired
	private PasswordEncoder encoder;

  @GetMapping("/getMember.do")
  String getMember(Model model, MemberVO vo) {

    model.addAttribute("member", service.getMember(vo));

    return "/member/getMember";
  } 

  @GetMapping("/memberForm.do")
  String memberForm(Model model) {


    return "/member/memberForm";
  } 

  @GetMapping("/memberInsert.do")
  String memberInsert(MemberVO vo) {

    vo.setPassword(encoder.encode(vo.getPassword()));
    service.memberInsert(vo);

    return "redirect:/login.do";
  } 

  @GetMapping("/kakaoForm.do")
  String kakaoForm(Model model) {
    System.out.println("kakaoForm check");
    return "/member/kakaoForm";
  } 

  @GetMapping("/kakaoUpdate.do")
  String kakaoInsert(MemberVO vo) {

    vo.setPassword(encoder.encode(vo.getPassword()));
    service.kakaoUpdate(vo);

    System.out.println("kakao update vo: " + vo);

    return "redirect:/loginSuccess.do?member_idx=" + vo.getMember_idx();
  } 

  @GetMapping("/usernameCk.do")
  void usernameCk(MemberVO vo, HttpServletResponse response) throws Exception {

    PrintWriter out = response.getWriter();

    if (service.login(vo) == null) {
      out.print("T");
    } else {
      out.print("F");
    }
  }
}

