package com.springboot.springboot.project.member;

import java.util.List;

public interface MemberService {
  List<MemberVO> getMemberList(MemberVO vo);

  void memberInsert(MemberVO vo);
}
