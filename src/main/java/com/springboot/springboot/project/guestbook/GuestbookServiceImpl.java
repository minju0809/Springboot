package com.springboot.springboot.project.guestbook;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GuestbookServiceImpl implements GuestbookService {

  @Autowired
  private GuestbookDao dao;

  @Override
  public List<GuestbookVO> getGuestbookList(GuestbookVO vo) {
    return dao.getGuestbookList(vo);
  }

  @Override
  public GuestbookVO getGuestbook(GuestbookVO vo) {
    return dao.getGuestbook(vo);
  }

  @Override
  public void guestbookInsert(GuestbookVO vo) {
    dao.guestbookInsert(vo);
  }

  @Override
  public void guestbookUpdate(GuestbookVO vo) {
    dao.guestbookUpdate(vo);
  }

  @Override
  public void guestbookDelete(GuestbookVO vo) {
    dao.guestbookDelete(vo);
  }

}


