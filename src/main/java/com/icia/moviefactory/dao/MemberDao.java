package com.icia.moviefactory.dao;

<<<<<<< HEAD
import java.util.*;

=======
>>>>>>> gwanger
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class MemberDao {
	@Autowired
	private SqlSessionTemplate tpl;

	// 아이디 찾기
	public String findIdByEmailAndName(String email,String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("name", name);
		return tpl.selectOne("memberMapper.findIdByEmailAndName", map);
	}

	// 비밀번호 찾기
	public String findPasswordByIdAndEmailAndName(String username, String email, String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("email", email);
		map.put("name", name);
		return tpl.selectOne("memberMapper.findPasswordByIdAndEmailAndName", map);
	}

	// 비밀번호 보내고 업데이트
	public int updatePassword(String username, String newEncodedPassword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("newEncodedPassword", newEncodedPassword);
		return tpl.update("memberMapper.updatePassword",map);
	}

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
