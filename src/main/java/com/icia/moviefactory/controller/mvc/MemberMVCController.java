package com.icia.moviefactory.controller.mvc;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.annotation.*;
>>>>>>> a33b2e02cef4d45e92f80206ec75714d11f7bd93
=======
>>>>>>> soonsim2
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
=======
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.icia.moviefactory.service.MemberService;
>>>>>>> dongmin_1

import com.icia.moviefactory.service.*;

@Controller
public class MemberMVCController {
<<<<<<< HEAD
<<<<<<< HEAD
=======
	@Autowired
	private MemberService service;

	// MVC-1. 서비스 동의 페이지
	@GetMapping("/member/yesorno")
	public String yesorno(Model model) {
		model.addAttribute("viewName", "member/YesOrNo.jsp");
		return "main";
	}

	// MVC-2. 회원 가입
	@GetMapping("/member/join")
	public String join(Model model) {
		model.addAttribute("viewName", "member/join.jsp");
		return "main";
	}

	// MVC-3. 비밀번호 확인
	@Secured("ROLE_USER")
	@GetMapping("/member/checkpassword")
	public String pwdCheck(Model model) {
		model.addAttribute("viewName", "member/checkPassword.jsp");
		return "main";
	}

>>>>>>> a33b2e02cef4d45e92f80206ec75714d11f7bd93
	// MVC-1. 로그인
	@GetMapping("/member/login")
	public String login(Model model) {
		model.addAttribute("viewName", "member/login.jsp");
		return "main";
	}

	// MVC-2. 아이디 찾기
	@GetMapping("/api/member/findId")
	public String findId(Model model) {
		model.addAttribute("viewName", "member/findId.jsp");
		return "main";
	}

	// MVC-3. 비밀번호 찾기
	@GetMapping("/api/member/findPassword")
	public String findPwd(Model model) {
		model.addAttribute("viewName", "member/findPassword.jsp");
		return "main";
	}

	// MVC-4. 아이디 알려주는 창
	@GetMapping("/member/id")
	public String checkId(Model model) {
		model.addAttribute("viewName", "member/id.jsp");
		return "main";
	}

	// MVC-5. 비밀번호 알려주는 창
	@GetMapping("/member/pwd")
	public String checkPwd(Model model) {
		model.addAttribute("viewName", "member/pwd.jsp");
		return "main";
	}
	
<<<<<<< HEAD
	
}
=======
   @Autowired
   private MemberService service;

   // MVC-1. 서비스 동의 페이지
   @GetMapping("/member/yesorno")
   public String yesorno(Model model) {
      model.addAttribute("viewName", "member/YesOrNo.jsp");
      return "main";
   }

   // MVC-2. 회원 가입
   @GetMapping("/member/join")
   public String join(Model model) {
      model.addAttribute("viewName", "member/join.jsp");
      return "main";
   }

   // MVC-3. 비밀번호 확인
   @Secured("ROLE_USER")
   @GetMapping("/member/checkpassword")
   public String pwdCheck(Model model) {
      model.addAttribute("viewName", "member/checkPassword.jsp");
      return "main";
   }

   // MVC-1. 로그인
   @GetMapping("/member/login")
   public String login(Model model) {
      model.addAttribute("viewName", "member/login.jsp");
      return "main";
   }

   // MVC-2. 아이디 찾기
   @GetMapping("/member/findId")
   public String findId(Model model) {
      model.addAttribute("viewName", "member/findId.jsp");
      return "main";
   }

   // MVC-3. 비밀번호 찾기
   @GetMapping("/member/findPwd")
   public String findPwd(Model model) {
      model.addAttribute("viewName", "member/findPwd.jsp");
      return "main";
   }

   // MVC-4. 아이디 알려주는 창
   @GetMapping("/member/id")
   public String checkId(Model model) {
      model.addAttribute("viewName", "member/id.jsp");
      return "main";
   }

   // MVC-5. 비밀번호 알려주는 창
   @GetMapping("/member/pwd")
   public String checkPwd(Model model) {
      model.addAttribute("viewName", "member/pwd.jsp");
      return "main";
   }
   
   
=======
	@GetMapping("/ap/캡차API로직")
	public String api(Model model) {
		model.addAttribute("viewName", "ap/캡차API로직.jsp");
		return "main";
	}
	
	@GetMapping("/ap/캡차API사용자화면")
	public String api2(Model model) {
		model.addAttribute("viewName", "ap/캡차API사용자화면.html");
		return "main";
	}
>>>>>>> soonsim2
}
>>>>>>> dongmin_1
