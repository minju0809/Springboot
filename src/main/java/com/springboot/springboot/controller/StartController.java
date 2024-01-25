package com.springboot.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StartController {
  @GetMapping("/jsp.do")
  public String index() {
    return "/jsp";
  }

  @GetMapping("/thymeleaf/thymeleaf")
  public String thymeleaf(Model model) {
    model.addAttribute("hello", "안녕하세요 타임리프입니다");
    return "thymeleaf/thymeleaf";
  }
}



