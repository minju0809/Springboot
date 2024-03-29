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
  public MemberVO uuidCk(MemberVO vo) {
    return dao.uuidCk(vo);
  }

  @Override
  public void kakaoInsert(MemberVO vo) {
    dao.kakaoInsert(vo);
  }

  @Override
  public MemberVO login(MemberVO vo) {
    return dao.login(vo);
  }
  
  @Override
  public void kakaoUpdate(MemberVO vo) {
    dao.kakaoUpdate(vo);
  }

  @Override
  public void updateAll(MemberVO vo) {
    dao.updateAll(vo);
  }

  @Override
  public void memberUpdate(MemberVO vo) {
    dao.memberUpdate(vo);
  }

  @Override
  public void memberDelete(int member_idx) {
    dao.memberDelete(member_idx);
  }

  @Override
  public void boardDeleteByMemberIdx(int member_idx) {
    dao.boardDeleteByMemberIdx(member_idx);
  }

  @Override
  public void cartDeleteByMemberIdx(int member_idx) {
    dao.cartDeleteByMemberIdx(member_idx);
  }

  @Override
  public void orderDeleteByMemberIdx(int member_idx) {
    dao.orderDeleteByMemberIdx(member_idx);
  }

  @Override
  public void bookmarkDeleteByMemberIdx(int member_idx) {
    dao.bookmarkDeleteByMemberIdx(member_idx);
  }

  @Override
  public void commentBoardDeleteByMemberIdx(int member_idx) {
    dao.commentBoardDeleteByMemberIdx(member_idx);
  }

}
