package com.icia.moviefactory.service;

import java.io.*;
import java.util.*;

import org.apache.commons.lang3.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.entity.*;
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
	
	@Value("#{config['upload.profile.folder']}")
	private String PROFILE_FOLDER;
	
	@Value("#{config['download.profile.uri']}")
	private String PROFILE_URI;
	
	@Autowired
	private AuthorityMapper authorityMapper;

	// 아이디 찾기
	public String findId(String email, String name) {
		String result = dao.findIdByEmailAndName(email,name);
		if(result==null)
			throw new MemberNotFoundException();
		return result;
	}

	// 비밀번호 찾는건데 비밀번호 업데이트되고, 임시비번 발급해서 이메일로 쏴주는것.

	public String findPassword(String username, String email, String name) {
		String result = dao.findPasswordByIdAndEmailAndName(username, email,name);
		if(result==null)
			throw new MemberNotFoundException();
		String newPassword = RandomStringUtils.randomAlphanumeric(10);
		String newEncodedPassword = pwdEncoder.encode(newPassword);
		dao.updatePassword(username, newEncodedPassword);
		String text = "<p>임시번호를 발급했습니다. 로그인해주세요</p>";
		text = text + "<p>임시비밀번호 :" + newPassword +"</p>";
		Mail mail = Mail.builder().sender("webmaster@icia.com").receiver(email).title("비밀번호 재발급 메일입니다").content(text).build();
		mailUtil.sendMail(mail);
		return "임시비밀번호를 이메일로 발급하였습니다.";
	}
	
	// 아이디 중복체크
	public String idAvailable(String username) {
		String result = dao.findUsernameById(username);
		if (result != null)
			throw new IllegalArgumentException("사용중인 아이디입니다");
		return "사용가능한 아이디입니다.";
	}

	// 이메일 중복체크
	public String emailAvailable(String email) {
		String result = dao.findUsernameByEmail(email);
		if (result != null)
			throw new IllegalArgumentException("사용중인 이메일입니다");
		return "사용가능한 이메일입니다.";
	}

	// 닉네임 중복체크
	public String nickAvailable(String nick) {
		String result = dao.findUsernameByNick(nick);
		if (result != null)
			throw new IllegalArgumentException("사용중인 닉네임입니다");
		return "사용가능한 닉네임입니다.";
	}

	// 회원가입, 프로필 사진
	@Transactional
	public Member insert(Member member, MultipartFile photo) throws IllegalStateException, IOException {
		if (photo != null) {
			// 업로드한 파일의 contentType이 image인지 확인
			if (photo.getContentType().toLowerCase().startsWith("image/")) {
				// 프사의 파일명은 사용자 아이디와 같지만 이미지의 확장자는 여러 종류가 있다
				// 즉 아이디가 hasaway일 경우 프사는 hasaway.jpg일 수도 hasaway.png 일 수도 있다
				// 확장자를 잘라내자
				// 1. 파일이름에서 마지막 . 의 위치를 찾는다
				int lastIndexOfDot = photo.getOriginalFilename().lastIndexOf('.');
				// 2. 파일 이름에서 마지막 . 뒷 부분을 잘라낸다
				String extension = photo.getOriginalFilename().substring(lastIndexOfDot);
				// 3. 아이디 뒤에 잘라낸 확장자를 붙인다
				String imageName = member.getUsername() + extension;
				File file = new File(PROFILE_FOLDER, imageName);
				photo.transferTo(file);
				String fileUrl = PROFILE_URI + imageName;
				member.setPhoto(fileUrl);
			} else {
			member.setPhoto("http://localhost:8081/sajin/18default.png");
			}
		}
		System.out.println("여기는 사진까지 처리한 후=========");
		member.setPassword(pwdEncoder.encode(member.getPassword()));
		member.setRegDate(new Date());
		dao.insert(member);
		authorityMapper.insert(member.getUsername(), "ROLE_USER");
		return dao.findById(member.getUsername());

	}


	// 비밀번호 확인
	public String checkpassword(String username, String password) {
		String encodedPassword = dao.findPasswordById(username);
		if (pwdEncoder.matches(password, encodedPassword) == false)
			throw new IllegalArgumentException("비밀번호를 확인하지 못했습니다");
		return "OK";
	}

	// 내정보 확인
	public Member userinfo(String username) {
		Member member = dao.findById(username);
		return member;
	}
	
	// 내 정보 수정 
	public Member update(Member member, MultipartFile sajin) throws IllegalStateException, IOException {
		Member prevMember = dao.findById(member.getUsername());
		if(member.getNick().equals(""))
			member.setNick(prevMember.getNick());
		if(member.getEmail().equals(""))
			member.setEmail(prevMember.getEmail());
		if(member.getZipCode().equals(""))
			member.setZipCode(prevMember.getZipCode());
		if(member.getBaseAddr().equals(""))
			member.setBaseAddr(prevMember.getBaseAddr());
		if(member.getTel().equals(""))
			member.setTel(prevMember.getTel());
		if(member.getIntro().equals(""))
			member.setIntro(prevMember.getIntro());
		
		
		if (sajin != null) {
			if (sajin.getContentType().toLowerCase().startsWith("image/")) {
				int lastIndexOfDot = sajin.getOriginalFilename().lastIndexOf('.');
				String extension = sajin.getOriginalFilename().substring(lastIndexOfDot);
				String imageName = member.getUsername() + extension;
				File file = new File(PROFILE_FOLDER, imageName);
				sajin.transferTo(file);
				String fileUrl = PROFILE_URI + imageName;
				member.setPhoto(fileUrl);
			}
		}else if(sajin ==null) {
			member.setPhoto(prevMember.getPhoto());
		}
		if (dao.update(member) == 0)
			throw new IllegalArgumentException("사용자 정보를 변경하지 못했습니다");
		return dao.findById(member.getUsername());
	}

	// 비밀번호 변경
	public String updateNewPassword(String username, String password, String newPassword) {
		//String username =  principal.getName();
		String encodedPassword = dao.findById(username).getPassword();
		if (pwdEncoder.matches(password, encodedPassword) == false)
			throw new IllegalArgumentException("비밀번호를 확인하지 못했습니다");
		String newEncodedPassword = pwdEncoder.encode(newPassword);
		dao.updateNewPassword(username, newEncodedPassword);
		return "OK";
	}
	
	// 회원탈퇴
	public Void delete(String username) {
		dao.delete(username);
		authorityMapper.delete(username);
		return null;
	}

}
