package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;
import com.springboot.springboot.project.shop.CartVO;
import com.springboot.springboot.project.shop.OrderVO;
import com.springboot.springboot.project.shop.ShopService;

@Controller
public class AdminController {
  @Autowired
  private MemberService memberService;

  @Autowired
  private ShopService shopService;

  @GetMapping("/a/admin.do")
  String getMemberList(Model model, MemberVO memberVO, CartVO cartVO, OrderVO orderVO) {

    model.addAttribute("memberList", memberService.getMemberList(memberVO));
    model.addAttribute("order_idx", shopService.order_idx(orderVO));
    model.addAttribute("cartList", shopService.adminGetCartList(cartVO));
    model.addAttribute("orderList", shopService.adminGetOrderList(orderVO));
    
    return "/admin/admin";
  } 
}