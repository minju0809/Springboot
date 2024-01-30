package com.springboot.springboot.thymeleafController;

import java.util.Random;

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

  @GetMapping("/thymeleaf/guestbook/tGetGuestbook")
  void getGuestbook(Model model, GuestbookVO vo) {

    model.addAttribute("guestbook", service.getGuestbook(vo));
  }
  
  @GetMapping("/thymeleaf/guestbook/tGuestbookAdd")
  String guestbookInsert(GuestbookVO vo) {

    String[] nameArr = { "타하니", "타둘리", "타세실", "타사샤", "타다솔", "타여신", "타일환", "타팔득", "타아힌", "타시우" };
    String[] memoArr = { "반갑습니다", "내용이 유용합니다", "또 오고 싶네요", "자주 만났으면 좋겠습니다", "도움이 많이 되었어요" };

    Random random = new Random();

    for (int i = 0; i < 10; i++) {
      String name = nameArr[random.nextInt(nameArr.length)];
      String memo = name + ": " + memoArr[random.nextInt(memoArr.length)];

      vo.setGuestbook_name(name);
      vo.setGuestbook_memo(memo);

      service.guestbookInsert(vo);
    }
    return "redirect:/thymeleaf/guestbook/tGetGuestbookList";
  }
}
