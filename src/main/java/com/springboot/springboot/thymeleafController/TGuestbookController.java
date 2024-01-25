package com.springboot.springboot.thymeleafController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.guestbook.GuestbookService;
import com.springboot.springboot.project.guestbook.GuestbookVO;

@Controller
public class TGuestbookController {
  @Autowired
  private GuestbookService service;

  @GetMapping("/thymeleaf/guestbook/tGetGuestbookList")
  void getGuestbookList(Model model, GuestbookVO vo) {

    int start = 0;
    int pageSize = 10;
    int pageListSize = 10;
    int totalCount = service.getTotalCount(vo);

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
  }
}
