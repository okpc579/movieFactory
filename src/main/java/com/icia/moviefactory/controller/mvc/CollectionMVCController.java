package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;

@Controller
public class CollectionMVCController {
	//@GetMapping("/") 
	public String home(Model model) {
		model.addAttribute("viewName", "index.jsp");
		return "main";
	}
}
