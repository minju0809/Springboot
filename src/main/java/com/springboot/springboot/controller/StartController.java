package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springboot.springboot.project.shop.ProductVO;
import com.springboot.springboot.project.shop.ShopService;

@Controller
public class StartController {
  
  @Autowired
  private ShopService shopService;

  @GetMapping("/jsp.do")
  public String index(Model model, ProductVO vo) {
    // 페이지네이션을 위한 변수 설정
    int pageSize = 8;
    int start = vo.getStart() == 0 ? 1 : vo.getStart();
    int offset = (start - 1) * pageSize;
    
    // 전체 상품 수 조회
    int totalCount = shopService.getTotalCount(vo);
    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
    
    // 현재 페이지 설정
    vo.setStart(offset);
    vo.setPageSize(pageSize);
    
    // 모델에 데이터 추가
    model.addAttribute("li", shopService.getProductList(vo));
    model.addAttribute("start", start);
    model.addAttribute("totalPages", totalPages);
    
    return "/jsp";
  }
}



