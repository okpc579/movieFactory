package com.icia.moviefactory.util.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.stereotype.Component;

import com.icia.moviefactory.dao.LoginJobMapper;


@Component("loginSuccessHandler")
public class LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
<<<<<<< HEAD
   @Autowired
   private LoginJobMapper mapper;
   
   // 사용자가 갈 목적지를 저장하는 클래스
   // 특별한 목적지가 없다면 /로 보내면 된다
   private RequestCache cache = new HttpSessionRequestCache();
   
   // redirect를 담당하는 객체. 스프링 컨트롤러가 아니므로 return "redirect:/" 사용 불가
   private RedirectStrategy rs = new DefaultRedirectStrategy();
   
   @Override
   public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
         Authentication authentication) throws IOException, ServletException {
      
      HttpSession session = request.getSession();
      
      // 로그인 성공하면 실패횟수 초기화, 로그인 횟수 증가
      mapper.resetLoginFailureCount(authentication.getName());
      /*
       * mapper.increaseLoginCount(authentication.getName());
       * 
       * if(mapper.isNotReadMemoExist(authentication.getName())!=null) {
       * session.setAttribute("msg", "읽지 않은 메모가 있습니다"); }
       */
      SavedRequest savedRequest = cache.getRequest(request, response);
      
      // 로그인 성공 후 이동할 페이지가 있을 경우 세션에 저장
      if(savedRequest!=null)
         session.setAttribute("dest", savedRequest.getRedirectUrl());
      
      // 무조건 루트로 이동. 이동할 페이지가 있을 경우도 루트를 거쳐 이동
      rs.sendRedirect(request, response, "/");
      
   }
<<<<<<< HEAD
=======
	@Autowired
	private LoginJobMapper mapper;
	
	// 사용자가 갈 목적지를 저장하는 클래스
	// 특별한 목적지가 없다면 /로 보내면 된다
	private RequestCache cache = new HttpSessionRequestCache();
	
	// redirect를 담당하는 객체. 스프링 컨트롤러가 아니므로 return "redirect:/" 사용 불가
	private RedirectStrategy rs = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		
		// 로그인 성공하면 실패횟수 초기화, 로그인 횟수 증가
		
		/*
		mapper.resetLoginFailureCount(authentication.getName());
		mapper.increaseLoginCount(authentication.getName());
		
		if(mapper.isNotReadMemoExist(authentication.getName())!=null) {
			session.setAttribute("msg", "읽지 않은 메모가 있습니다");
		}
		SavedRequest savedRequest = cache.getRequest(request, response);
		
		// 로그인 성공 후 이동할 페이지가 있을 경우 세션에 저장
		 * 
		 */
		/*
		if(savedRequest!=null)
			session.setAttribute("dest", savedRequest.getRedirectUrl());
		*/
		// 무조건 루트로 이동. 이동할 페이지가 있을 경우도 루트를 거쳐 이동
		rs.sendRedirect(request, response, "/");
		
	}
>>>>>>> dongmin_1
}
=======
}
>>>>>>> jihye1
