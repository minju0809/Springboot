package com.springboot.springboot.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.guestbook.GuestbookService;
import com.springboot.springboot.project.guestbook.GuestbookVO;

@Controller
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class GuestbookController {

  @Autowired
  private GuestbookService service;

  @GetMapping("/getGuestbookList.do")
  String getGuestbookList(Model model, GuestbookVO vo) {

    if (vo.getPage() == 0) {
      vo.setPage(1);
    }

    int pageSize = 10;
    vo.setPageSize(pageSize);
    int offset = Math.max((vo.getPage() - 1) * pageSize, 0);
    vo.setOffset(offset);
    int totalCount = service.getTotalCount(vo);

    int current_block = (int) Math.ceil((double) vo.getPage() / 10);
    int currentPage = vo.getPage();
    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
    int startPage = (current_block - 1) * 10 + 1;
    int endPage = Math.min(current_block * 10, totalPage);

    if (currentPage < 1)
      currentPage = 1;
    if (currentPage > totalPage)
      currentPage = totalPage;

    model.addAttribute("page", vo.getPage());
    model.addAttribute("currentPage", currentPage);
    model.addAttribute("totalCount", totalCount);
    model.addAttribute("totalPage", totalPage);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
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

      return "redirect:/getGuestbookList.do?page=" + vo.getPage() + "&ch1=" + encodedCh1 + "&ch2=" + encodedCh2;

    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
      return "redirect:/getGuestbookList.do?page=" + vo.getPage() + "&ch1=" + vo.getCh1() + "&ch2=" + vo.getCh2();
    }
  }

  @GetMapping("/guestbookDelete.do")
  String guestbookDelete(GuestbookVO vo) {

    service.guestbookDelete(vo);

    try {
      String encodedCh1 = URLEncoder.encode(vo.getCh1(), StandardCharsets.UTF_8.toString());
      String encodedCh2 = URLEncoder.encode(vo.getCh2(), StandardCharsets.UTF_8.toString());

      return "redirect:/getGuestbookList.do?page=" + vo.getPage() + "&ch1=" + encodedCh1 + "&ch2=" + encodedCh2;

    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
      return "redirect:/getGuestbookList.do?page=" + vo.getPage() + "&ch1=" + vo.getCh1() + "&ch2=" + vo.getCh2();
    }
  }
}
