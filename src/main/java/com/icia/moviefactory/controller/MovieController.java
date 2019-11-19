package com.icia.moviefactory.controller;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class MovieController {
	@GetMapping("/movie/review/write")
	public String insertrev(Model model) {
		model.addAttribute("viewName","movie/review/write.jsp");
		return "main";
	}
	
	@GetMapping("/movie/review/update")
	public String updaterev(Model model) {
		model.addAttribute("viewName", "movie/review/update.jsp");
		return "main";
	}
	
	@GetMapping("/movie/review/report")
	public String insertrevrep(Model model) {
		model.addAttribute("viewName", "movie/review/report.jsp");
		return "main";
	}
	@GetMapping("/movie/comment/update")
	public String updaterevcmnt(Model model) {
		model.addAttribute("viewName", "update.jsp");
		return "main";
	}
	@GetMapping("/movie/comment/report")
	public String insertcmntrep(Model model) {
		model.addAttribute("viewName", "report.jsp");
		return "main";
	}
	
	@GetMapping("/movie/review/read")
	public String read(Model model) {
		model.addAttribute("viewName", "movie/review/read.jsp");
		return "main";
	}
	
	
	
}
