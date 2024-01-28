package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

@Controller
public class MemberController {
    
  @Autowired
  private MemberService service;

  @GetMapping("/getMemberList.do")
  String getMemberList(Model model, MemberVO vo) {

    model.addAttribute("li", service.getMemberList(vo));
    
    return "/member/getMemberList";
  } 

  @GetMapping("/memberForm.do")
  String memberForm(Model model) {

    return "/member/memberForm";
  } 

  @GetMapping("/memberInsert.do")
  String memberInsert(MemberVO vo) {

    service.memberInsert(vo);

    return "redirect:/getMemberList.do";
  } 
}
