package com.cook.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cook.model.MemberVO;
import com.cook.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	@Autowired
	MemberService memberService;
    @Autowired
    private JavaMailSender mailSender;
	
	//로그인페이지 진입
	@GetMapping("/login")
	public void login() {
		System.out.println("로그인페이지 진입");
	}
	//회원가입폼
	@GetMapping("/join")
	public void joinForm() {
		System.out.println("회원가입폼 진입");
	}
	
	//회원가입 진행
	@PostMapping("/join")
	public String join(MemberVO vo) {
		System.out.println("회원가입진행");
		memberService.memberInsert(vo);
		log.info("회원가입진행중");
		return "redirect:/main";
	}
	
	// 아이디 중복 검사
	@PostMapping("/emailChk")
	@ResponseBody
	public String emailChk(String email) throws Exception{
		log.info("이메일 중복체크 진입 진입");
		int result = memberService.emailCheck(email);
		log.info("결과값 = " + result);
		if(result != 0) {
			return "fail";	// 중복 아이디가 존재
		} else {
			return "success";	// 중복 아이디 x
		}
	} 
	
    /* 이메일 인증 */
    @GetMapping("/mailCheck")
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("보낸이메일 : " + email);
        
        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        log.info("인증번호 " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "gm045723@gmail.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "회원가입 인증 번호 요청 이메일입니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        String num = Integer.toString(checkNum);
        return num;
    }

}
