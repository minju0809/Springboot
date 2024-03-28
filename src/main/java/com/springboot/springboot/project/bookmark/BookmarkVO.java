package com.springboot.springboot.project.bookmark;

import lombok.Data;

@Data
public class BookmarkVO {
  private int bookmark_idx;
  private int member_idx;
  private int board_idx;
  private int boardBookmarked;
}
