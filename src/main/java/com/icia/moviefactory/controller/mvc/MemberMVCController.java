package com.icia.moviefactory.controller.mvc;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@Controller
public class MemberMVCController {

	@Autowired
	private MemberService service;

	// MVC-1. 서비스 동의 페이지
	@GetMapping("/member/yesorno")
	public String yesorno(Model model) {
		model.addAttribute("viewName", "member/YesOrNo.jsp");
		return "main";
	}

	// MVC-2. 회원 가입
	@GetMapping("/member/join")
	public String join(Model model, HttpSession session) {
		if (session.getAttribute("yes") == null) { 
			return "redirect:/member/yesorno"; 
		}
		model.addAttribute("viewName", "member/join.jsp");
		return "main";
	}

	// MVC-3. 비밀번호 확인
	@Secured("ROLE_USER")
	@GetMapping("/member/checkpassword")
	public String pwdCheck(Model model) {
		model.addAttribute("viewName", "member/checkPassword.jsp");
		return "main";
	}
	
	// MVC-4. 내 정보 보기
	@Secured("ROLE_USER")
	@GetMapping("/member/userinfo")
	public String userinfo(Model model, HttpSession session) {
		if (session.getAttribute("pwdCheck") == null) { 
			return "redirect:/member/checkpassword"; 
		}
		model.addAttribute("viewName", "member/userInfo.jsp");
		return "main";
	}
	
	// MVC-4. 내 정보 수정
	@Secured("ROLE_USER")
	@GetMapping("/member/userupdate")
	public String userupdate(Model model, HttpSession session) {
		if (session.getAttribute("pwdCheck") == null) { 
			return "redirect:/member/checkpassword"; 
		}
		model.addAttribute("viewName", "member/userUpdate.jsp");
		return "main";
	}

	// MVC-1. 로그인
	@GetMapping("/member/login")
	public String login(Model model) {
		model.addAttribute("viewName", "member/login.jsp");
		return "main";
	}

	// MVC-2. 아이디 찾기
	@GetMapping("/member/findId")
	public String findId(Model model) {
		model.addAttribute("viewName", "member/findId.jsp");
		return "main";
	}

	// MVC-3. 비밀번호 찾기
	@GetMapping("/member/findPassword")
	public String findPwd(Model model) {
		model.addAttribute("viewName", "member/findPassword.jsp");
		return "main";
	}

	// MVC-4. 아이디 알려주는 창
	@GetMapping("/member/id")
	public String checkId(Model model) {
		model.addAttribute("viewName", "member/id.jsp");
		return "main";
	}

	// MVC-5. 비밀번호 알려주는 창
	@GetMapping("/member/pwd")
	public String checkPwd(Model model) {
		model.addAttribute("viewName", "member/pwd.jsp");
		return "main";
	}
  
	@GetMapping("/ap/api1")
	public String api(Model model) {
		model.addAttribute("viewName", "ap/api1.jsp");
		return "main";
	}
	
	@GetMapping("/ap/app")
	public String api2(Model model) {
		model.addAttribute("viewName", "ap/app.jsp");
		return "main";
	}
}

