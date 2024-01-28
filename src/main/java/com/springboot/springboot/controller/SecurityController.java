package com.springboot.springboot.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

import jakarta.servlet.http.HttpSession;

@Controller
public class SecurityController {

  @Autowired
  private HttpSession session;

  @Autowired
  private MemberService service;

  @GetMapping("/login.do")
  String login() {
    System.out.println("===> index.do");
    return "/login/login";
  }

  @GetMapping("/loginSuccess.do")
  String loginSuccess(Principal user) {

    System.out.println("===> loginSuccess.do: " + user.getName());

    MemberVO vo = new MemberVO();
    vo.setUsername(user.getName());

    session.setAttribute("session", service.login(vo));

    return "/login/loginSuccess";
  }

  @GetMapping("/accessDenied.do")
  String accessDenied() {
    System.out.println("===> accessDenied.do");
    return "/login/accessDenied";
  }
}
