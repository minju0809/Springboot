package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

@Controller
public class MemberController {
    
  @Autowired
  private MemberService service;

  @Autowired
	private PasswordEncoder encoder;

  @GetMapping("/a/getMemberList.do")
  String getMemberList(Model model, MemberVO vo) {

    model.addAttribute("li", service.getMemberList(vo));
    
    return "/member/getMemberList";
  } 

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
}
