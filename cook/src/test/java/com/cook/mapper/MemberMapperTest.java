package com.cook.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cook.model.MemberVO;

import lombok.Builder;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTest {
	
	@Autowired
	MemberMapper mapper; //의존성 주입
	
//	@Test
//	public void join() {
//		MemberVO vo = new MemberVO();
//		
//		vo.setEmail("test");
//		vo.setPass("test");
//		vo.setAddress("test");
//		vo.setAuthority("test");
//		
//	mapper.memberInsert(vo);
//	}
	
	// 아이디 중복검사
	@Test
	public void memberIdChk() throws Exception{
		String id = "test";	// 존재하는 아이디
		String id2 = "hdhdhdfg";	// 존재하지 않는 아이디
		mapper.emailCheck(id);
		mapper.emailCheck(id2);
	}

}
