package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.guestbook.GuestbookService;
import com.springboot.springboot.project.guestbook.GuestbookVO;

@Controller
public class GuestbookController {

  @Autowired
  private GuestbookService service;

  @GetMapping("/getGuestbookList.do")
  String getGuestbookList(Model model) {

    model.addAttribute("li", service.getGuestbookList(null));

    return "/guestbook/getGuestbookList";
  }

  @GetMapping("/getGuestbook.do")
  String getGuestbook(Model model, GuestbookVO vo) {
    model.addAttribute("guestbook", service.getGuestbook(vo));

    return "/guestbook/getGuestbook";
  }
  
  @GetMapping("/guestbookForm.do")
  String guestbookForm(GuestbookVO vo) {

    return "/guestbook/guestbookForm";
  }
  @GetMapping("/guestbookInsert.do")
  String guestbookInsert(GuestbookVO vo) {

    service.guestbookInsert(vo);

    return "redirect:getGuestbookList.do";
  }

  @GetMapping("/guestbookUpdate.do")
  String guestbookUpdate(GuestbookVO vo) {
    System.out.println("@@@@@@@@@@@@@@@@ " + vo);
    
    service.guestbookUpdate(vo);

    return "redirect:getGuestbookList.do";
  }

  @GetMapping("/guestbookDelete.do")
  String guestbookDelete(GuestbookVO vo) {
    
    service.guestbookDelete(vo);

    return "redirect:getGuestbookList.do";
  }
}



