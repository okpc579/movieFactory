package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class CollectionMVCController {
	@GetMapping("/collection/add") 
	public String add(Model model) {
		return "collection/add";
	}
	@GetMapping("/collection/addmovie") 
	public String addmovie(Model model) {
		return "collection/addmovie";
	}
	@GetMapping("/collection/read") 
	public String read(Model model) {
		model.addAttribute("viewName", "collection/read.jsp");
		return "main";
	}
	@GetMapping("/collection/update") 
	public String update(Model model) {
		return "collection/update";
	}
	@GetMapping("/collection/list") 
	public String list(Model model) {
		model.addAttribute("viewName", "collection/list.jsp");
		return "main";
	}
}
