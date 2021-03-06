package com.icia.moviefactory.controller.mvc;

import org.springframework.lang.*;
import org.springframework.security.access.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SystemMVCController {

	// 여기에 있던 회원가입 관련 것들 멤버 mvc로 옮김

	@GetMapping("/system/e403")
	public String notAuthorized(Model model) {
		model.addAttribute("viewName", "e403.jsp");
		return "main";
	}

	@GetMapping("/")
	public String home(Model model) {
		return "index";
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

