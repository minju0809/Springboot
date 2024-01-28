package com.springboot.springboot;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.springboot.springboot.project.member.MemberService;
import com.springboot.springboot.project.member.MemberVO;

@SpringBootTest
class SpringbootApplicationTests {

	@Autowired
	private MemberService service;

	@Autowired
	private PasswordEncoder encoder;

	@Test
	void contextLoads() {
	}

	@Test 
	void testUpdate() {
		MemberVO vo = new MemberVO();
		vo.setPassword(encoder.encode("1234"));

		service.updateAll(vo);
		System.out.println("=====> Test update" + vo);
	}

}
