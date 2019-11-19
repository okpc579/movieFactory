package com.icia.moviefactory.controller.mvc;

import org.springframework.security.access.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminaskMVCController {
	// MVC-1. 글 리스트
	@Secured("ROLE_ADMIN")
	@GetMapping("/adminAsk/list")
	public String list(Model model) {
		model.addAttribute("viewName", "adminAsk/list.jsp");
		return "main";
	}
	
	// MVC-2. 글 쓰기
	@Secured("ROLE_USER")
	@GetMapping("/adminAsk/write")
	public String write(Model model) {
		model.addAttribute("viewName", "adminAsk/write.jsp");
		return "main";
	}
	
	// MVC-3. 글 읽기
	@GetMapping("/adminAsk/read")
	public String read(Model model) {
		model.addAttribute("viewName", "adminAsk/read.jsp");
		return "main";
	}	
}
