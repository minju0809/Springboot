package com.springboot.springboot.project.board;

import lombok.Data;

@Data
public class CommentBoardVO {
  private int comment_idx; 
  private int board_idx;
  private int member_idx;
  private String username;
  private String comment_content;
  private String comment_date;
}
