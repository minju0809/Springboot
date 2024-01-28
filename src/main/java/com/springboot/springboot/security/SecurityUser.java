package com.springboot.springboot.security;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import com.springboot.springboot.project.member.MemberVO;

public class SecurityUser extends User {

	private static final long serialVersionUID = 1L;

	public SecurityUser(MemberVO vo ) {
		super(vo.getUsername(), 
			  "{noop}"+vo.getPassword(), 
			  AuthorityUtils.createAuthorityList(vo.getRole().toString()));
  	}	

}