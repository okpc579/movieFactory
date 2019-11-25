package com.icia.moviefactory.controller.mvc;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminaskMVCController {
	// MVC-1.관리자에게 들어온 모든 문의글 리스트
	//@Secured("ROLE_ADMIN")
	@GetMapping("/adminAsk/list")
	public String list(Model model) {
		model.addAttribute("viewName", "adminAsk/list.jsp");
		return "main";
	}
//	// 유저의 글 리스트
//	//@Secured("ROLE_USER")
//	@GetMapping({"/adminAsk/userlist"})
//	public String userlist(Model model) {
//		model.addAttribute("viewName","adminAsk/userlist.jsp");
//		return "main";
//	}
	
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
