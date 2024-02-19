package com.springboot.springboot.reactController;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.springboot.project.guestbook.GuestbookService;
import com.springboot.springboot.project.guestbook.GuestbookVO;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ReactGuestbookController {

  @Autowired
  private GuestbookService service;

  @RequestMapping("/ReactGuestbookList")
  String getGuestbookList(GuestbookVO vo) {

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

    Map<String, Object> resultMap = new HashMap<>();
    resultMap.put("totalCount", totalCount);
    resultMap.put("start", start);
    resultMap.put("pageSize", pageSize);
    resultMap.put("end", end);
    resultMap.put("totalPage", totalPage);
    resultMap.put("currentPage", currentPage);
    resultMap.put("lastPage", lastPage);
    resultMap.put("pageListSize", pageListSize);
    resultMap.put("listStartPage", listStartPage);
    resultMap.put("listEndPage", listEndPage);
    resultMap.put("ch1", vo.getCh1());
    resultMap.put("ch2", vo.getCh2());
    resultMap.put("li", service.getGuestbookList(vo));

     // Convert the Map to JSON and return
    ObjectMapper mapper = new ObjectMapper();
    try {
      return mapper.writeValueAsString(resultMap);
    } catch (JsonProcessingException err) {
      err.printStackTrace();
      return null;
    }
  }
}
