package com.cook.service;

import com.cook.model.MemberVO;

public interface MemberService {
	
	//회원가입
	public void memberInsert(MemberVO vo);
	//이메일체크
	public int emailCheck(String email);
	//로그인
	public MemberVO memberLogin(MemberVO vo);

}
