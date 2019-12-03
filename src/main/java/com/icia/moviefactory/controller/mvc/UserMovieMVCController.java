package com.icia.moviefactory.controller.mvc;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserMovieMVCController {

	// MVC-0. 영화 마이페이지 보기
	@GetMapping("/usermovie/mypage")
	public String mypage(Model model) {
		model.addAttribute("viewName", "usermovie/mypage.jsp");
		return "main";
	}
	
	// MVC-1. 유저 페이지 보기
	@GetMapping("/usermovie/userpage")
	public String read(Model model) {
		model.addAttribute("viewName", "usermovie/userpage.jsp");
		return "main";
	}

	// MVC-3. 컬렉션 목록보기
	@GetMapping("/usermovie/collection")
	public String collection(Model model) {
		model.addAttribute("viewName", "usermovie/collection.jsp");
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

	// MVC-6. 팔로워 목록보기
	@GetMapping("/usermovie/follower")
	public String follower(Model model) {
		model.addAttribute("viewName", "usermovie/follower.jsp");
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

	// MVC-13. 내 선호영화 예상 목록 보기(미정)
	@GetMapping("/usermovie/preferencemovie")
	public String preferencemovie(Model model) {
		model.addAttribute("viewName", "usermovie/preferencemovie.jsp");
		return "main";
	}
}
