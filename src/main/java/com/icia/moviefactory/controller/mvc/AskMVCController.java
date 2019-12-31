package com.icia.moviefactory.controller.mvc;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AskMVCController {
	// 유저가보는 공지글 리스트
	@Secured("ROLE_USER")
	@GetMapping("/adminAsk/listuser")
	public String listuser(Model model) {
		model.addAttribute("viewName", "adminAsk/listuser.jsp");
		return "main";
	}
	// 관리자가 보는 공지글 리스트
	@Secured("ROLE_ADMIN")
	@GetMapping({"/adminAsk/list"})
	public String list(Model model) {
		model.addAttribute("viewName","adminAsk/list.jsp");
		return "main";
	}
	
	// 관리자 글 쓰기
	@Secured("ROLE_USER")
	@GetMapping("/adminAsk/write")
	public String write(Model model) {
		model.addAttribute("viewName", "adminAsk/write.jsp");
		return "main";
	}
	// 관리자가 글 읽기
	@GetMapping("/adminAsk/read")
	public String read(Model model) {
		model.addAttribute("viewName", "adminAsk/read.jsp");
		return "main";
	}	
}
