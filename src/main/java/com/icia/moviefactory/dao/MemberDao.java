package com.icia.moviefactory.dao;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class MemberDao {

	@Autowired
	private SqlSessionTemplate tpl;

	// UDAO-1. 아이디 중복 확인
	public String findUsernameById(String username) {
		return tpl.selectOne("memberMapper.findUsernameById", username);
	}

	// UDAO-2. 이메일 중복 확인
	public String findUsernameByEmail(String email) {
		return tpl.selectOne("memberMapper.findUsernameByEmail", email);
	}

	// UDAO-2. 닉네임 중복 확인
	public String findUsernameByNick(String nick) {
		return tpl.selectOne("memberMapper.findUsernameByNick", nick);
	}

	// UDAO-3. 회원 정보 저장
	public int insert(Member member) {
		return tpl.insert("memberMapper.insert", member);
	}

	// UDAO-7. 아이디로 비밀번호 읽어오기
	public String findPasswordById(String username) {
		return tpl.selectOne("memberMapper.findPasswordById", username);
	}

	// UDAO-8. 회원 정보 읽기
	public Member findById(String username) {
		return tpl.selectOne("memberMapper.findById", username);
	}
}
