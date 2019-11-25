package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class MovieMVCController {
	// 영화 검색 결과 목록 나열
	@GetMapping("/movie/list")
	public String MovieList(Model model) {
		model.addAttribute("viewName", "movie/list.jsp");
		return "main";
	}
	@GetMapping("/movie/read")	// 디테일 리드
	public String MovieList(Model model, @RequestParam long mno) {
		model.addAttribute("viewName", "movie/read.jsp");	// 디테일 리드
		model.addAttribute("mno", mno);
		return "main";
	}

}
