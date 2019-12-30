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
		return "movie/review/report";
	}
	
	
	@GetMapping("/movie/review/cmntreport")
	public String insertcmntrep(Model model) {
		return "movie/review/cmntreport";
	}
	
	@GetMapping("/movie/comment/update")
	public String updaterevcmnt(Model model) {
		model.addAttribute("viewName", "update.jsp");
		return "main";
	}
	
	@GetMapping("/movie/review/read")
	public String read(Model model) {
		model.addAttribute("viewName", "movie/review/read.jsp");
		return "main";
	}	
	
	@GetMapping("/movie/review/list")
	public String list(Model model) {
		model.addAttribute("viewName", "movie/review/list.jsp");
		return "main";
	}

}
