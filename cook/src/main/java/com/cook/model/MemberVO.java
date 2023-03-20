package com.cook.model;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class MemberVO {
	
	//회원번호
	private int mno;
	//회원이메일(아이디)
	private String  email;
	//회원비밀번호
	private String pass;
	//회원주소
	private String address;
	//회원권한
	private String authority;
	//가입일
	private Date created_date;

}
