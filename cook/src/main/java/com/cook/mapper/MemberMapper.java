package com.cook.mapper;

import com.cook.model.MemberVO;

public interface MemberMapper {
	
	//회원가입
	public void memberInsert(MemberVO vo);
	
	public int emailCheck(String email);

}
