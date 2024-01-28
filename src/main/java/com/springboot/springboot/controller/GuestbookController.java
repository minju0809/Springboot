package com.springboot.springboot.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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

    int start = 0;
    int pageSize = 10;
    int pageListSize = 10;
    int totalCount = service.getTotalCount(vo);

    System.out.println("!@#@@@@@@@@@@@@@@@@" + vo.getStart());
    if (vo.getStart() == 0) {
      start = 1;
    } else {
      start = vo.getStart();
    }

    int end = start + pageSize - 1;

    int totalPage = (totalCount / pageSize) + 1;
    int currentPage = (start / pageSize) + 1;
    int lastPage = (totalPage - 1) * pageSize + 1;
    int listStartPage = (currentPage - 1) / pageListSize * pageListSize + 1;
    int listEndPage = listStartPage + pageListSize - 1;

    vo.setStart(start);
    System.out.println("@@@@@@@@@@@@@@@@" + vo.getStart());
    vo.setPageSize(pageSize);
    vo.setEnd(end);

    model.addAttribute("totalCount", totalCount);
    model.addAttribute("start", start);
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("end", end);
    model.addAttribute("totalPage", totalPage);
    model.addAttribute("currentPage", currentPage);
    model.addAttribute("lastPage", lastPage);

    model.addAttribute("pageListSize", pageListSize);
    model.addAttribute("listStartPage", listStartPage);
    model.addAttribute("listEndPage", listEndPage);

    model.addAttribute("ch1", vo.getCh1());
    model.addAttribute("ch2", vo.getCh2());

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

    return "redirect:/getGuestbookList.do";
  }

  @GetMapping("/a/guestbookAdd.do")
  String guestbookAdd(GuestbookVO vo) {

    String[] name = { "하니", "둘리", "세실", "사샤", "다솔", "여신", "일환", "팔득", "아힌", "시우" };
    String[] memo = { "반갑습니다", "내용이 유용합니다", "또 오고 싶네요", "자주 만났으면 좋겠습니다", "도움이 많이 되었어요" };

    Random random = new Random();

    for (int i = 0; i < 10; i++) {
      String randomName = name[random.nextInt(name.length)];
      String randomMemo = memo[random.nextInt(memo.length)];

      vo.setGuestbook_name(randomName);
      vo.setGuestbook_memo(randomName + ": " + randomMemo);

      service.guestbookInsert(vo);
    }

    return "redirect:/getGuestbookList.do";
  }

  @GetMapping("/guestbookUpdate.do")
  String guestbookUpdate(GuestbookVO vo) {

    service.guestbookUpdate(vo);

    try {
      String encodedCh1 = URLEncoder.encode(vo.getCh1(), StandardCharsets.UTF_8.toString());
      String encodedCh2 = URLEncoder.encode(vo.getCh2(), StandardCharsets.UTF_8.toString());

      return "redirect:/getGuestbookList.do?start=" + vo.getStart() + "&ch1=" + encodedCh1 + "&ch2=" + encodedCh2;

    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
      return "redirect:/getGuestbookList.do?start=" + vo.getStart() + "&ch1=" + vo.getCh1() + "&ch2=" + vo.getCh2();
    }
  }

  @GetMapping("/guestbookDelete.do")
  String guestbookDelete(GuestbookVO vo) {

    service.guestbookDelete(vo);

    try {
      String encodedCh1 = URLEncoder.encode(vo.getCh1(), StandardCharsets.UTF_8.toString());
      String encodedCh2 = URLEncoder.encode(vo.getCh2(), StandardCharsets.UTF_8.toString());

      return "redirect:/getGuestbookList.do?start=" + vo.getStart() + "&ch1=" + encodedCh1 + "&ch2=" + encodedCh2;

    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
      return "redirect:/getGuestbookList.do?start=" + vo.getStart() + "&ch1=" + vo.getCh1() + "&ch2=" + vo.getCh2();
    }
  }
}
