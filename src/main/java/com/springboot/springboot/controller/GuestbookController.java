package com.springboot.springboot.controller;

import java.util.Random;

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
  String getGuestbookList(Model model, GuestbookVO vo) {

    int totalCount = service.getTotalCount(vo);
    
    model.addAttribute(  "totalCount", totalCount);
    model.addAttribute("li", service.getGuestbookList(vo));

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

  @GetMapping("/guestbookAdd.do")
  String guestbookAdd(GuestbookVO vo) {

    String[] name = {"하니","둘리","세실","사샤","다솔","여신","일환","팔득","아힌","시우"};
    String[] memo = {"반갑습니다","내용이 유용합니다","또 오고 싶네요","자주 만났으면 좋겠습니다","도움이 많이 되었어요"};

    Random random = new Random();

    for(int i = 0; i < 10; i++) {
      String randomName = name[random.nextInt(name.length)];
      String randomMemo = memo[random.nextInt(memo.length)];

      vo.setGuestbook_name(randomMemo);
      vo.setGuestbook_memo(randomName + ": " + randomMemo);

      service.guestbookInsert(vo);
    }

    return "redirect:getGuestbookList.do";
  }

  @GetMapping("/guestbookUpdate.do")
  String guestbookUpdate(GuestbookVO vo) {
    
    service.guestbookUpdate(vo);

    return "redirect:getGuestbookList.do";
  }

  @GetMapping("/guestbookDelete.do")
  String guestbookDelete(GuestbookVO vo) {
    
    service.guestbookDelete(vo);

    return "redirect:getGuestbookList.do";
  }
}



