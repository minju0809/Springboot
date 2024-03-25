package com.springboot.springboot.project.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDao {
  List<MemberVO> getMemberList(MemberVO vo);
  MemberVO getMember(MemberVO vo);

  void memberInsert(MemberVO vo);
  MemberVO uuidCk(MemberVO vo);
  void kakaoInsert(MemberVO vo);

  MemberVO login(MemberVO vo);

  void kakaoUpdate(MemberVO vo);
  void updateAll(MemberVO vo);
  void memberUpdate(MemberVO vo);

  void memberDelete(int member_idx);
}
