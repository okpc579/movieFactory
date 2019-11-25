package com.icia.moviefactory.controller.rest;

import javax.servlet.http.*;

import org.springframework.security.access.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class MemberController {


	// MVC-4. 내 정보 보기
	@Secured("ROLE_USER")
	@GetMapping("/member/userinfo")
	public String userinfo(Model model, HttpSession session) {
		if (session.getAttribute("pwdCheck") == null) { 
			System.out.println("비밀번호 확인하러 가렴");
			return "redirect:/member/checkpassword"; 
		}
		model.addAttribute("viewName", "member/userInfo.jsp");
		return "main";
	}
	
	// MVC-4. 내 정보 수정
	@Secured("ROLE_USER")
	@GetMapping("/member/userupdate")
	public String userupdate(Model model, HttpSession session) {
		if (session.getAttribute("pwdCheck") == null) { 
			System.out.println("비밀번호 확인하러 가렴");
			return "redirect:/member/checkpassword"; 
		}
		System.out.println("mvc 내정정보 수정컨트롤러에 도착");
		model.addAttribute("viewName", "member/userUpdate.jsp");
		return "main";
	}

}
