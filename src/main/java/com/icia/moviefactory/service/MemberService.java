package com.icia.moviefactory.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

@Service
public class MemberService {
	@Autowired
	private MemberDao dao;
	@Autowired
	private PasswordEncoder pwdEncoder;
	@Value("#{config['upload.profile.folder']}")
	private String PROFILE_FOLDER;
	@Value("#{config['download.profile.uri']}")
	private String PROFILE_URI;
	@Autowired
	private AuthorityMapper authorityMapper;

	
	public String idAvailable(String username) {
		String result = dao.findUsernameById(username);
		if(result!=null)
			throw new IllegalArgumentException("사용중인 아이디입니다"); 
		return "사용가능한 아이디입니다.";
	}

	public String emailAvailable(String email) {
		String result = dao.findUsernameByEmail(email);
		if(result!=null)
			throw new IllegalArgumentException("사용중인 이메일입니다"); 
		return "사용가능한 이메일입니다.";
	}
	

	public String nickAvailable(String nick) {
		String result = dao.findUsernameByNick(nick);
		if(result!=null)
			throw new IllegalArgumentException("사용중인 닉네임입니다"); 
		return "사용가능한 닉네임입니다.";
	}

	@Transactional
	public Member insert(Member member, MultipartFile photo) throws IllegalStateException, IOException {
		if(photo!=null) {
			// 업로드한 파일의 contentType이 image인지 확인
			if(photo.getContentType().toLowerCase().startsWith("image/")) {
				// 프사의 파일명은 사용자 아이디와 같지만 이미지의 확장자는 여러 종류가 있다
				// 즉 아이디가 hasaway일 경우 프사는 hasaway.jpg일 수도 hasaway.png 일 수도 있다
				// 확장자를 잘라내자
				// 1. 파일이름에서 마지막 . 의 위치를 찾는다
				int lastIndexOfDot =  photo.getOriginalFilename().lastIndexOf('.');
				// 2. 파일 이름에서 마지막 . 뒷 부분을 잘라낸다
				String extension = photo.getOriginalFilename().substring(lastIndexOfDot);
				// 3. 아이디 뒤에 잘라낸 확장자를 붙인다
				String imageName = member.getUsername() + extension;
				File file = new File(PROFILE_FOLDER, imageName);
				photo.transferTo(file);
				String fileUrl = PROFILE_URI + imageName;
				member.setPhoto(fileUrl);
			}
		}
		member.setPassword(pwdEncoder.encode(member.getPassword()));
		member.setRegDate(new Date());
		dao.insert(member);
			authorityMapper.insert(member.getUsername(), "ROLE_USER");
		return dao.findById(member.getUsername());
		
	}
	
	public String checkpassword(String username, String password) {
		String encodedPassword = dao.findPasswordById(username);
		if(pwdEncoder.matches(password, encodedPassword)==false) 
			throw new IllegalArgumentException("비밀번호를 확인하지 못했습니다");
		return "OK";
	}

	
}
