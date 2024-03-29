package com.springboot.springboot.project.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentBoardServiceImpl implements CommentBoardService {

  @Autowired
  private CommentBoardDao dao;

  @Override
  public void commentBoardInsert(CommentBoardVO vo) {
    dao.commentBoardInsert(vo);
  }

  @Override
  public List<CommentBoardVO> getCommentBoardList(CommentBoardVO vo) {
    return dao.getCommentBoardList(vo);
  }
  
}
