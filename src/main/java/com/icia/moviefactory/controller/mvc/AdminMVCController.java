package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
@Controller
public class AdminMVCController {
	@GetMapping("/admin/blocklist") 
	public String blocklist(Model model) {
		model.addAttribute("viewName", "admin/blocklist.jsp");
		return "main";
	}
	
	@GetMapping("/admin/readblock") 
	public String readblock(Model model) {
		model.addAttribute("viewName", "admin/readblock.jsp");
		return "main";
	}
	
	@GetMapping("/admin/blindrevlist") 
	public String blindrevlist(Model model) {
		model.addAttribute("viewName", "admin/blindrevlist.jsp");
		return "main";
	}
	
	@GetMapping("/admin/blindcmntlist") 
	public String blindcmntlist(Model model) {
		model.addAttribute("viewName", "admin/blindcmntlist.jsp");
		return "main";
	}
	

	@GetMapping("/admin/readrevblind") 
	public String readrevblind(Model model) {
		model.addAttribute("viewName", "admin/readrevblind.jsp");
		return "main";
	}
	
	@GetMapping("/admin/readrevcmntblind") 
	public String readrevcmntblind(Model model) {
		model.addAttribute("viewName", "admin/readrevcmntblind.jsp");
		return "main";
	}
}
