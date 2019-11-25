package com.icia.moviefactory.controller.mvc;

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
	public String join(Model model) {
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
	@GetMapping("/member/findPwd")
	public String findPwd(Model model) {
		model.addAttribute("viewName", "member/findPwd.jsp");
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
	
	
}
