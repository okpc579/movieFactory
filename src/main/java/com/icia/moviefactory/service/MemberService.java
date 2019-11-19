package com.icia.moviefactory.service;

import java.util.*;

import org.apache.commons.lang3.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.exception.*;
import com.icia.moviefactory.util.*;


@Service
public class MemberService {
	@Autowired
	private MemberDao dao;
	@Autowired
	private MailUtil mailUtil;
	@Autowired
	private PasswordEncoder pwdEncoder;
	
	// 아이디 찾기
	public Object findId(String email, String name) {
		String result = dao.findIdByEmailAndName(email,name);
		if(result==null)
			throw new MemberNotFoundException();
		// 하드코딩(바로 값 적는것)을 하게되면 값을 고치기가 어려움
		
		// 이 부분이 누르면 바로 아이디가 나오게 할 수 있도록 해야하는데
		// 그걸 jsp부분에서 하는건가?
		/* jsp 부분에서 해주는 것 같다....
		 * String link =
		 * "<a href='http://localhost:8081/moviefactory/member/login>로그인</a>"; String
		 * text = "<p>아이디를 찾았습니다. 로그인해주세요</p>"; text = text + "<p>고객님의 아이디" + result
		 * +"</p>";
		 */
		return result;
	}

	// 비밀번호 찾는건데 비밀번호 업데이트되고, 임시비번 발급해서 이메일로 쏴주는것.
	public Object findPassword(String username, String email, String name) {
		String result = dao.findPasswordByIdAndEmailAndName(username, email,name);
		if(result==null)
			throw new MemberNotFoundException();
		String newPassword = RandomStringUtils.randomAlphanumeric(10);
		String newEncodedPassword = pwdEncoder.encode(newPassword);
		dao.updatePassword(username, newEncodedPassword);
		String link = "<a href='http://localhost:8081/moviefactory/member/login>로그인</a>";
		String text = "<p>임시번호를 발급했습니다. 로그인해주세요</p>";
		text = text + "<p>임시비밀번호 :" + newPassword +"</p>";
		text = text + link;
		Mail mail = new Mail("webmaster@icia.com", "dmdu11@naver.com", "이메일 확인", text);	// 아이디 자기꺼로 바꾸셈
		mailUtil.sendMail(mail);
		return StringConstant.SEND_PASSWORD_EMAIL;
	}
	
	
}
