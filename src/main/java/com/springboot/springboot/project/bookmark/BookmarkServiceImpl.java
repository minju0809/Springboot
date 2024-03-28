package com.springboot.springboot.project.bookmark;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookmarkServiceImpl implements BookmarkService {

  @Autowired
  private BookmarkDao dao;
  
  @Override
  public void insertBoardBookmark(BookmarkVO bookmark) {
    dao.insertBoardBookmark(bookmark);
  }

  @Override
  public void deleteBoardBookmark(int member_idx, int board_idx) {
    dao.deleteBoardBookmark(member_idx, board_idx);
  }

  @Override
  public BookmarkVO getMemberIdxAndBoardIdx(int member_idx, int board_idx) {
    return dao.getMemberIdxAndBoardIdx(member_idx, board_idx);
  }

  @Override
  public List<BookmarkVO> getBookmarkedBoards(int member_idx) {
    return dao.getBookmarkedBoards(member_idx);
  }
}
