package com.springboot.springboot.project.guestbook;

import lombok.Data;

@Data
public class GuestbookVO {
  private int guestbook_idx;
  private String guestbook_name;
  private String guestbook_memo;
  private String guestbook_today;
}
