package com.springboot.springboot.project.board;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
  private int board_idx;
  private int member_idx;
  private String member_name;
  private String board_title;
  private String board_content;
  private String board_map;
  private String map_dot;
  private String board_imgStr;
  private MultipartFile board_img;
  private String board_today;
  private int board_cnt;
}
