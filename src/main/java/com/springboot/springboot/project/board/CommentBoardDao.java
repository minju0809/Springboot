package com.springboot.springboot.project.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentBoardDao {
  void commentBoardInsert(CommentBoardVO vo);

  List<CommentBoardVO> getCommentBoardList(CommentBoardVO vo);

  void commentBoardDelete(CommentBoardVO vo);
}
