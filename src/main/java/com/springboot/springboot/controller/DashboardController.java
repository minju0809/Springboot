package com.springboot.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

  @GetMapping("/dashboard.do")
  String dashboard() {
    return "/sideworks/dashboard";
  }

  @GetMapping("/calendarToDoList.do")
  String calendarToDoList() {
    return "/sideworks/calendarToDoList";
  }
}
