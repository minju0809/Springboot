package com.springboot.springboot.project.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

  @Autowired
  private MemberDao dao;

  @Override
  public List<MemberVO> getMemberList(MemberVO vo) {
    return dao.getMemberList(vo);
  }
  
  @Override
  public MemberVO getMember(MemberVO vo) {
    return dao.getMember(vo);
  }

  @Override
  public void memberInsert(MemberVO vo) {
    dao.memberInsert(vo);
  }

  @Override
  public MemberVO login(MemberVO vo) {
    return dao.login(vo);
  }

  @Override
  public void updateAll(MemberVO vo) {
    dao.updateAll(vo);
  }

  
}
