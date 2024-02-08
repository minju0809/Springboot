package com.springboot.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

  @GetMapping("/a/dashboard.do")
  String dashboard() {
    return "/dashboard/dashboard";
  }
}
