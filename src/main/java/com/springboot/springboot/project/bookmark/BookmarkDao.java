package com.springboot.springboot.project.bookmark;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookmarkDao {
  void insertBoardBookmark(BookmarkVO bookmark);

  void deleteBoardBookmark(int member_idx, int board_idx);

  BookmarkVO getMemberIdxAndBoardIdx(int member_idx, int board_idx);

  List<BookmarkVO> getBookmarkedBoards(int member_idx);
}
