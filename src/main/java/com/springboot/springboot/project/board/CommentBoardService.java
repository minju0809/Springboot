package com.springboot.springboot.project.board;

import java.util.List;

public interface CommentBoardService {
  void commentBoardInsert(CommentBoardVO vo);

  List<CommentBoardVO> getCommentBoardList(CommentBoardVO vo);
}
