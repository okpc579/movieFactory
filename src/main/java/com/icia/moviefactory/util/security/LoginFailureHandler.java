package com.icia.moviefactory.util.security;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.authentication.*;
import org.springframework.security.core.*;
import org.springframework.security.web.*;
import org.springframework.security.web.authentication.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;


@Component("loginFailureHandler")
public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Autowired
	private LoginJobMapper mapper;
	// 비밀번호 틀린 횟수 증가, 비밀번호 틀린 횟수 가져오기, 계정 블록, 비밀번호 틀린 횟수 리셋
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException e) throws IOException, ServletException {
		// 인증에 실패하면 AuthenticationException이 발생
		// 이 예외가 BadCredentialException - 비밀번호 틀림
		// 이 예외가 InternalAuthenticationException - 아이디 없음
		//		Principal, UserDetailsService 작성이 필요
		// 이 예외가 DisabledException - 계정 차단
		
		HttpSession session = request.getSession();
		
		if(e instanceof BadCredentialsException) {
			// 이 if문에서 아이디를 찾을 수 없는 경우와 비밀번호가 틀린 경우를 처리
			String username = request.getParameter("username");
			Long loginFailureCount = mapper.findLoginFailureCount(username);
			
			// 비밀번호가 틀린 경우 로그인 실패 횟수를 읽어온다
			
			// 아이디가 존재하지 않는 경우 검색이 실패하기 때문에 로그인 실패 횟수가 null이 된다
			if(loginFailureCount==null) { 
				session.setAttribute("msg", "아이디나 비밀번호를 확인하세요");
			} else if(loginFailureCount<4) {
				// 로그인에 3회이하로 실패한 경우
				mapper.increaseLoginFailureCount(username);
				session.setAttribute("msg", "아이디나 비밀번호를 확인하세요");
			} else if(loginFailureCount==4) {
				// 이건 아니고 로그인에 5번 실패하면 그냥 캡차 띄우기
				// 로그인에 4회 실패한 경우. 실패횟수 증가시키고 계정 블록
				mapper.increaseLoginFailureCount(username);
				// 그럼 굳이 메시지를 띄울 필요가 없는 거 아닌가?
				// session.setAttribute("msg", "5회이상 실패해 계정이 차단되었습니다");
				
				// 여기서 캡차 띄워아햐는거 아닌가?
			} 			
		} else if(e instanceof DisabledException) {
			// enabled가 0인 경우 로그인에 실패하면서 영구정지된 계정이라고.
			session.setAttribute("msg", "관리자에 의해 영구정지된 계정입니다.");
		}
		
		// redirect를 담당하는 객체. 스프링 컨트롤러가 아니므로 return "redirect:/" 사용 불가
		new DefaultRedirectStrategy().sendRedirect(request, response, "/member/login?job=fail");
		
	}
}







