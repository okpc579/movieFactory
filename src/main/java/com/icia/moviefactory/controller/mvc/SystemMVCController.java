package com.icia.moviefactory.controller.mvc;

import org.springframework.lang.*;
import org.springframework.security.access.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SystemMVCController {

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

	@GetMapping("/system/e403")
	public String notAuthorized(Model model) {
		model.addAttribute("viewName", "e403.jsp");
		return "main";
	}

	@GetMapping("/")
	public String home(Model model) {
		model.addAttribute("viewName", "index.jsp");
		return "main";
	}

	// 통계 보기
	@Secured("ROLE_ADMIN")
	@GetMapping("/admin/stat")
	public String stat(@NonNull String job, Model model) {
		model.addAttribute("viewName", "admin/stat.jsp");
		return "main";
	}

	// 블록대상인 유저 보기
	@Secured("ROLE_ADMIN")
	@GetMapping("/admin/user/report")
	public String findReportUserList(Model model) {
		model.addAttribute("viewName", "admin/reportUserList.jsp");
		return "main";
	}

	// 블록대상인 유저 보기
	@Secured("ROLE_ADMIN")
	@GetMapping("/admin/user/block")
	public String findBlockUserList(Model model) {
		model.addAttribute("viewName", "admin/blockUserList.jsp");
		return "main";
	}
}
