package com.springboot.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StartController {

  @GetMapping("/index.do")
  String index() {
    return "index";
  }
}



