package com.springboot.springboot.project.guestbook;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GuestbookDao {
  List<GuestbookVO> getGuestbookList(GuestbookVO vo);
  GuestbookVO getGuestbook(GuestbookVO vo);
  int getTotalCount(GuestbookVO vo);

  void guestbookInsert(GuestbookVO vo);
  void guestbookUpdate(GuestbookVO vo);
  void guestbookDelete(GuestbookVO vo);
}




