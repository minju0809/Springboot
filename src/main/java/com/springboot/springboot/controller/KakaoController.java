package com.springboot.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Value;

import com.springboot.springboot.project.board.BoardService;
import com.springboot.springboot.project.board.BoardVO;
import com.springboot.springboot.project.member.MemberVO;
import com.springboot.springboot.project.s3.S3Service;

import jakarta.servlet.http.HttpSession;

@Controller
public class KakaoController {
  private static final String DEFAULT_IMAGE_URL = "https://travel-project-images.s3.ap-northeast-2.amazonaws.com/space.jpeg";

  @Autowired
  private BoardService service;

  @Autowired
  private HttpSession session;

  @Autowired
  private S3Service s3Service;

  @Value("${javascript.key}")
  private String javascriptKey;

  @GetMapping("/kakaoBoardForm.do")
  String kakaoBoardForm(Model model) {
    model.addAttribute("keyValue", javascriptKey);
    return "/board/boardForm";
  }

  @PostMapping("/kakaoBoardInsert.do")
  String kakaoBoardInsert(BoardVO vo) throws Exception {
    MemberVO mvo = (MemberVO) session.getAttribute("session");
    int midx = mvo.getMember_idx();
    String name = mvo.getName();
    vo.setMember_idx(midx);
    vo.setMember_name(name);

    MultipartFile file = vo.getBoard_img();
    if (!file.isEmpty()) {
      String imageUrl = s3Service.upload(file, "board");
      vo.setBoard_imgStr(imageUrl);
    } else {
      vo.setBoard_imgStr(DEFAULT_IMAGE_URL);
    }
    
    service.boardInsert(vo);

    return "redirect:/getBoardList.do";
  }

  @PostMapping("/kakaoBoardUpdate.do")
  String boardUpdate(BoardVO vo) throws Exception {
    MultipartFile board_img = vo.getBoard_img();
    if (!board_img.isEmpty()) {
      // 기존 이미지가 기본 이미지가 아니면 S3에서 삭제
      if (vo.getBoard_imgStr() != null && !vo.getBoard_imgStr().equals(DEFAULT_IMAGE_URL)) {
        s3Service.delete(vo.getBoard_imgStr());
      }
      // 새 이미지 업로드
      String imageUrl = s3Service.upload(board_img, "board");
      vo.setBoard_imgStr(imageUrl);
    }

    service.boardUpdate(vo);

    return "redirect:/getBoardList.do";
  }

  @GetMapping("/kakaoBoardDelete.do")
  String boardDelete(BoardVO vo) {
    vo = service.getBoard(vo);

    // 이미지가 기본 이미지가 아니면 S3에서 삭제
    if (!vo.getBoard_imgStr().equals(DEFAULT_IMAGE_URL)) {
      s3Service.delete(vo.getBoard_imgStr());
    }

    service.boardDelete(vo);

    return "redirect:/getBoardList.do";
  }
}
