package com.cook.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cook.mapper.MemberMapper;
import com.cook.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	@Override
	public void memberInsert(MemberVO vo) {
		memberMapper.memberInsert(vo);

	}
	@Override
	public int emailCheck(String email) {
		return memberMapper.emailCheck(email);
	}
	@Override
	public MemberVO memberLogin(MemberVO vo) {
		return memberMapper.memberLogin(vo);
	}

}
