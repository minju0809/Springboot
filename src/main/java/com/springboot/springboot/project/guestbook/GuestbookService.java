package com.springboot.springboot.project.guestbook;

import java.util.List;

public interface GuestbookService {
  List<GuestbookVO> getGuestbookList(GuestbookVO vo);
  GuestbookVO getGuestbook(GuestbookVO vo);

  void guestbookInsert(GuestbookVO vo);
  void guestbookUpdate(GuestbookVO vo);
  void guestbookDelete(GuestbookVO vo);
}


