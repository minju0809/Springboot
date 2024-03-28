package com.springboot.springboot.project.bookmark;

import java.util.List;

public interface BookmarkService {
  void insertBoardBookmark(BookmarkVO bookmark);

  void deleteBoardBookmark(int member_idx, int board_idx);

  BookmarkVO getMemberIdxAndBoardIdx(int member_idx, int board_idx);

  List<BookmarkVO> getBookmarkedBoards(int member_idx);
}
