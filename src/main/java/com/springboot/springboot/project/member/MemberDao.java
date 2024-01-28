package com.springboot.springboot.project.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDao {
  List<MemberVO> getMemberList(MemberVO vo);

  void memberInsert(MemberVO vo);
}
