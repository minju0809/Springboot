package com.springboot.springboot.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

import jakarta.servlet.http.HttpSession;

@Service
public class SecurityUserDetailsService implements UserDetailsService  {
	
	SecurityUserDetailsService(){
		System.out.println("==>SecurityUserDetailsService");
	}
	
	@Autowired
	private MemberService service;

  @Autowired
	HttpSession session; 
		
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = new MemberVO();
		System.out.println("username확인:" + username);
		vo.setUsername(username);
		
		MemberVO user = service.login(vo);
		if (user == null) {
			throw  new UsernameNotFoundException(username + "사용자 없음");
		}else {
      // session.setAttribute("session", user);
			return new SecurityUser(user);
		}
	}

}