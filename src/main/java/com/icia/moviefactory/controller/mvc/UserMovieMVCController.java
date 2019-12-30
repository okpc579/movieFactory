package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserMovieMVCController {

	// MVC-1. 영화 마이페이지 보기
	
	// MVC-2. 유저 페이지 보기
	@GetMapping("/usermovie/userpage")
	public String read(Model model) {
		model.addAttribute("viewName", "usermovie/userpage.jsp");
		return "main";
	}

	// MVC-4. 유저리뷰 목록보기
	@GetMapping("/usermovie/review")
	public String review(Model model) {
		model.addAttribute("viewName", "usermovie/review.jsp");
		return "main";
	}

	// MVC-5. 팔로잉 목록 보기
	@GetMapping("/usermovie/following")
	public String following(Model model) {
		model.addAttribute("viewName", "usermovie/following.jsp");
		return "main";
	}
	
	// MVC-7. 평점 상위 보기
	@GetMapping("/usermovie/toprating")
	public String toprating(Model model) {
		model.addAttribute("viewName", "usermovie/toprating.jsp");
		return "main";
	}
	
	// MVC-8. 유저 고평점 상위 보기
	@GetMapping("/usermovie/usertoprating")
	public String usertoprating(Model model) {
		model.addAttribute("viewName", "usermovie/usertoprating.jsp");
		return "main";
	}
	
	// MVC-11. 장르별 평점 상위 보기
	@GetMapping("/usermovie/genretoprating")
	public String genretoprating(Model model) {
		model.addAttribute("viewName", "usermovie/genretoprating.jsp");
		return "main";
	}
	
	// MVC-12. 좋아하는 영화 목록 보기
	@GetMapping("/usermovie/favoritemovie")
	public String favoritemovie(Model model) {
		model.addAttribute("viewName", "usermovie/favoritemovie.jsp");
		return "main";
	}
}
