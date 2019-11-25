package com.icia.moviefactory.controller.mvc;

import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

//@Controller
public class UserMovieMVCController {
	//@GetMapping("/") 
	public String home(Model model) {
		model.addAttribute("viewName", "index.jsp");
		return "main";
	}
	
	// MVC-1. 유저 페이지 보기
	@GetMapping("/usermovie/read")
	public String read(Model model) {
		model.addAttribute("viewName", "usermovie/read.jsp");
		return "main";
	}

	// MVC-2. 컬렉션 목록보기
	@GetMapping("/usermovie/collection")
	public String collection(Model model) {
		model.addAttribute("viewName", "usermovie/collection.jsp");
		return "main";
	}

	// MVC-3. 유저리뷰 목록보기
	@GetMapping("/usermovie/review")
	public String review(Model model) {
		model.addAttribute("viewName", "usermovie/review.jsp");
		return "main";
	}

	// MVC-4. 팔로잉 목록 보기
	@GetMapping("/usermovie/following")
	public String following(Model model) {
		model.addAttribute("viewName", "usermovie/following.jsp");
		return "main";
	}

	// MVC-5. 팔로워목록보기
	@GetMapping("/usermovie/follower")
	public String follower(Model model) {
		model.addAttribute("viewName", "usermovie/follower.jsp");
		return "main";
	}

	// MVC-6. 유저 고평점 상위보기
	@GetMapping("/usermovie/usertoprating")
	public String usertoprating(Model model) {
		model.addAttribute("viewName", "usermovie/usertoprating.jsp");
		return "main";
	}

	// MVC-7. 좋아하는 영화 목록 보기
	@GetMapping("/usermovie/favorite")
	public String favorite(Model model) {
		model.addAttribute("viewName", "usermovie/favorite.jsp");
		return "main";
	}

	// MVC-8. 내 선호영화 예상 목록 보기
	@GetMapping("/usermovie/preference")
	public String preference(Model model) {
		model.addAttribute("viewName", "usermovie/preference.jsp");
		return "main";
	}

	// MVC-9. 평점상위보기
	@GetMapping("/usermovie/toprating")
	public String toprating(Model model) {
		model.addAttribute("viewName", "usermovie/toprating.jsp");
		return "main";
	}

	// MVC-10. 장르별 평점 상위 보기
	@GetMapping("/usermovie/genretoprating")
	public String genretoprating(Model model) {
		model.addAttribute("viewName", "usermovie/genretoprating.jsp");
		return "main";
	}
}
