package com.springboot.springboot.project.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDao {
  List<BoardVO> getBoardList(BoardVO vo);

  BoardVO getBoard(BoardVO vo);

  void boardInsert(BoardVO vo);

  void boardCnt(BoardVO vo);

  void boardUpdate(BoardVO vo);

  void boardDelete(BoardVO vo);
}
