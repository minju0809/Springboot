package com.springboot.springboot.project.member;

import java.util.List;

public interface MemberService {
  List<MemberVO> getMemberList(MemberVO vo);
  MemberVO getMember(MemberVO vo);

  void memberInsert(MemberVO vo);
  MemberVO uuidCk(MemberVO vo);
  void kakaoInsert(MemberVO vo);

  MemberVO login(MemberVO vo);
  MemberVO kakaoLogin(MemberVO vo);

  void kakaoUpdate(MemberVO vo);
  void updateAll(MemberVO vo);
}
