package com.springboot.springboot.controller;

import java.io.File;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springboot.project.board.BoardService;
import com.springboot.springboot.project.board.BoardVO;
import com.springboot.springboot.project.member.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
  
  @Autowired
  private BoardService service;

  @Autowired
  private HttpServletRequest request;

  @Autowired
  private HttpSession session;

  @GetMapping("/getBoardList.do")
  String getBoardList(Model model, BoardVO vo) {
    model.addAttribute("li", service.getBoardList(vo));
    return "/board/getBoardList";
  }

  @GetMapping("/getBoard.do")
  String getBoard(Model model, BoardVO vo) {
    
    service.boardCnt(vo);
    model.addAttribute("keyValue", "5fd42cdd845577dc157f2510c3e96a73");
    model.addAttribute("board", service.getBoard(vo));
    return "/board/getBoard";
  }

  @GetMapping("/m/boardForm.do")
  String boardForm(Model model) {

    model.addAttribute("keyValue", "5fd42cdd845577dc157f2510c3e96a73");

    return "/board/boardForm";
  }

  @PostMapping("/m/boardInsert.do")
  String boardInsert(BoardVO vo) throws Exception {

    String path = request.getSession().getServletContext().getRealPath("/img/board/");
    System.out.println("path: " + path);
    // path: /Users/minju/Springboot/src/main/webapp/img/board/

    MemberVO mvo = (MemberVO) session.getAttribute("session");
    int midx = mvo.getMember_idx();
    String name = mvo.getName();
    vo.setMember_idx(midx);
    vo.setMember_name(name);

    long time = System.currentTimeMillis();
    SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
    String timeStr = sdf.format(time);

    MultipartFile file = vo.getBoard_img();
    String fileName = file.getOriginalFilename();
    File f = new File(path + fileName);

    if (!file.isEmpty()) {
      if (f.exists()) {
        String onlyFileName = fileName.substring(0, fileName.lastIndexOf("."));
        String ext = fileName.substring(fileName.lastIndexOf("."));
        fileName = onlyFileName + "_" + timeStr + ext;
      }
      file.transferTo(new File(path + fileName));
    } else {
      fileName = "space.png";
    }

    vo.setBoard_imgStr(fileName);
    
    System.out.println("vo: " + vo);
    service.boardInsert(vo);

    return "redirect:/getBoardList.do";
  }
  
}
