package com.springboot.springboot.project.member;

import lombok.Data;

@Data
public class MemberVO {
    private int member_idx;
    private String username;
    private String password;
    private String role;
    private String name;
    private String phone;
    private String email;
    private String postcode;
    private String address;
    private String detailAddress;
    private String extraAddress;
    private String regdate;
    private String etc;
    
    private String ch1;
    private String ch2;
  
    private int memo_idx;
    private String memo;
    private String memo_today;
}
