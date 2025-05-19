package com.springboot.springboot.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.springboot.project.board.BoardService;
import com.springboot.springboot.project.board.BoardVO;
import com.springboot.springboot.project.board.CommentBoardService;
import com.springboot.springboot.project.board.CommentBoardVO;
import com.springboot.springboot.project.bookmark.BookmarkService;
import com.springboot.springboot.project.bookmark.BookmarkVO;
import com.springboot.springboot.project.member.MemberVO;
import com.springboot.springboot.project.s3.S3Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
  
  @Autowired
  private BoardService service;

  @Autowired
  private BookmarkService bookmarkService;

  @Autowired
  private CommentBoardService commentBoardService;

  @Autowired
  private HttpServletRequest request;

  @Autowired
  private HttpSession session;

  @Autowired
  private S3Service s3Service;

  @Value("${javascript.key}")
  private String javascriptKey;

  @GetMapping("/getBoardList.do")
  String getBoardList(Model model, BoardVO vo) {

    model.addAttribute("li", service.getBoardList(vo));

    return "/board/getBoardList";
  }

  @GetMapping("/getBoard.do")
  String getBoard(Model model, BoardVO vo, CommentBoardVO commentVo) {
    
    service.boardCnt(vo);
    model.addAttribute("keyValue", javascriptKey);
    model.addAttribute("board", service.getBoard(vo));

    commentVo.setBoard_idx(vo.getBoard_idx());
    model.addAttribute("comment", commentBoardService.getCommentBoardList(commentVo));

    return "/board/getBoard";
  }

  @GetMapping("/m/boardForm.do")
  String boardForm(Model model) {

    model.addAttribute("keyValue", javascriptKey);

    return "/board/boardForm";
  }

  String path = "";
  String timeStr = "";

  @PostMapping("/m/boardInsert.do")
  String boardInsert(BoardVO vo) throws Exception {
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
      vo.setBoard_imgStr("space.png");
    }
    
    service.boardInsert(vo);

    return "redirect:/getBoardList.do";
  }

  @PostMapping("/m/boardUpdate.do")
  String boardUpdate(BoardVO vo) throws Exception {
    MultipartFile board_img = vo.getBoard_img();
    if (!board_img.isEmpty()) {
      // 기존 이미지가 space.png가 아니면 S3에서 삭제
      if (vo.getBoard_imgStr() != null && !vo.getBoard_imgStr().equals("space.png")) {
        s3Service.delete(vo.getBoard_imgStr());
      }
      // 새 이미지 업로드
      String imageUrl = s3Service.upload(board_img, "board");
      vo.setBoard_imgStr(imageUrl);
    }

    service.boardUpdate(vo);

    return "redirect:/getBoardList.do";
  }

  @GetMapping("/m/boardDelete.do")
  String boardDelete(BoardVO vo) {
    vo = service.getBoard(vo);

    // 이미지가 space.png가 아니면 S3에서 삭제
    if (!vo.getBoard_imgStr().equals("space.png")) {
      s3Service.delete(vo.getBoard_imgStr());
    }

    service.boardDelete(vo);

    return "redirect:/getBoardList.do";
  }

  @GetMapping("/getBookmarkStatus.do")
  @ResponseBody
  public String getBookmarkStatus(int member_idx, int board_idx) {
    BookmarkVO bookmark = bookmarkService.getMemberIdxAndBoardIdx(member_idx, board_idx);
    if (bookmark != null) {
      return "bookmarked";
    } else {
      return "not_bookmarked";
    }
  }

  @GetMapping("/toggleBookmark.do")
  @ResponseBody // 응답 반환
  String toggleBookmark(int member_idx, int board_idx) {
    // System.out.println("로그인 member_idx: " + member_idx + ", board_idx: " +
    // board_idx);
    BookmarkVO bookmark = bookmarkService.getMemberIdxAndBoardIdx(member_idx, board_idx);
    if (bookmark != null) {
      bookmarkService.deleteBoardBookmark(member_idx, board_idx);
      // System.out.println("북마크가 삭제되었습니다: " + bookmark);
      return "deleted";
    } else {
      BookmarkVO newBookmark = new BookmarkVO();
      newBookmark.setMember_idx(member_idx);
      newBookmark.setBoard_idx(board_idx);
      newBookmark.setBoardBookmarked(1);
      bookmarkService.insertBoardBookmark(newBookmark);
      // System.out.println("북마크가 추가되었습니다: " + newBookmark);
      return "added";
    }
  }

  @GetMapping("/getBoardBookmark.do")
  String getBoardBookmark(Model model, int member_idx) {

    List<BookmarkVO> bookmarks = bookmarkService.getBookmarkedBoards(member_idx);
    List<BoardVO> boardBookmarks = new ArrayList<>();
    for (BookmarkVO bookmark : bookmarks) {
      BoardVO vo = new BoardVO();
      vo.setBoard_idx(bookmark.getBoard_idx());
      BoardVO board = service.getBoard(vo);
      if (board != null) {
        boardBookmarks.add(board);
      }
    }

    model.addAttribute("li", boardBookmarks);

    return "/board/getBoardBookmarkList";
  }

  @GetMapping("/commentBoardInsert.do")
  String commentBoardInsert(CommentBoardVO vo) {

    commentBoardService.commentBoardInsert(vo);

    return "redirect:/getBoard.do?board_idx=" + vo.getBoard_idx();
  }

  @GetMapping("/commentBoardDelete.do")
  String commentBoardDelete(CommentBoardVO vo) {

    commentBoardService.commentBoardDelete(vo);

    return "redirect:/getBoard.do?board_idx=" + vo.getBoard_idx();
  }

}
