package com.springboot.springboot.project.board;

import java.util.List;

public interface BoardService {
  List<BoardVO> getBoardList(BoardVO vo);

  BoardVO getBoard(BoardVO vo);

  void boardInsert(BoardVO vo);
}
