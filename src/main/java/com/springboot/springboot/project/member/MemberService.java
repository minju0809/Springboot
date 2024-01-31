package com.springboot.springboot.project.member;

import java.util.List;

public interface MemberService {
  List<MemberVO> getMemberList(MemberVO vo);
  MemberVO getMember(MemberVO vo);

  void memberInsert(MemberVO vo);

  MemberVO login(MemberVO vo);
  void updateAll(MemberVO vo);
}
