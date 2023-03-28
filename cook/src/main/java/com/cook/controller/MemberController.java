package com.cook.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
   @Autowired
   private BCryptPasswordEncoder pwEncoder;
	
	//로그인페이지 진입
	@GetMapping("/login")
	public void loginForm() {
		System.out.println("로그인페이지 진입");
	}
	//로그인
	@PostMapping("/login")
	public String login(HttpServletRequest request, MemberVO vo, RedirectAttributes rttr){
		log.info("로그인컨트롤러");
		log.info("전달된VO" + vo);
        HttpSession session = request.getSession();
        String rawPw = "";
        String encodePw = "";
    
        MemberVO lvo = memberService.memberLogin(vo);    // 제출한아이디와 일치하는 아이디 있는지 
        
        if(lvo != null) {            // 일치하는 아이디 존재시     
            rawPw = vo.getPass();        // 사용자가 제출한 비밀번호
            encodePw = lvo.getPass();        // 데이터베이스에 저장한 인코딩된 비밀번호     
            if(true == pwEncoder.matches(rawPw, encodePw)) {        // 비밀번호 일치여부 판단     
                lvo.setPass("");                    // 인코딩된 비밀번호 정보 지움
                session.setAttribute("member", lvo);     // session에 사용자의 정보 저장
                return "redirect:/main";        // 메인페이지 이동      
            } else {
                rttr.addFlashAttribute("result", 0);            
                return "redirect:/member/login";    // 로그인 페이지로 이동          
            }      
        } else {                    // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)    
            rttr.addFlashAttribute("result", 0);            
            return "redirect:/member/login";    // 로그인 페이지로 이동       
        }
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
        String rawPw = "";            // 인코딩 전 비밀번호
        String encodePw = "";        // 인코딩 후 비밀번호
        rawPw = vo.getPass();            // 비밀번호 데이터 얻음
        encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
        vo.setPass(encodePw);            // 인코딩된 비밀번호 member객체에 다시 저장
		memberService.memberInsert(vo);
		log.info("회원가입진행중");
	return "redirect:/main";
}
	
	//로그아웃
    /* 비동기방식 로그아웃 메서드 */
    @PostMapping("/logout")
    @ResponseBody
    public void logoutPOST(HttpServletRequest request) throws Exception{
        
        log.info("로그아웃 메서드 진입");
        
        HttpSession session = request.getSession();
        
        session.invalidate();
        
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
