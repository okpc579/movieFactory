package com.icia.moviefactory.controller.mvc;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoticeMVCController {
	// 글 리스트
	@GetMapping({ "/notice/list" })
	public String list(Model model) {
		model.addAttribute("viewName", "notice/list.jsp");
		return "main";
	}

	// MVC-2. 글 쓰기
	@Secured("ROLE_ADMIN")
	@GetMapping("/notice/write")
	public String write(Model model) {
		model.addAttribute("viewName", "notice/write.jsp");
		return "main";
	}

	// 글 읽기
	@GetMapping("/notice/read")
	public String read(Model model) {
		model.addAttribute("viewName", "notice/read.jsp");
		return "main";
	}
}
