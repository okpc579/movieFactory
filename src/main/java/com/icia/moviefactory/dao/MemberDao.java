package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class MemberDao {
   @Autowired
   private SqlSessionTemplate tpl;
	// 아이디 찾기
	public String findIdByEmailAndName(String email, String name) {
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
		return tpl.update("memberMapper.updatePassword", map);
	}

	// 아이디 중복 확인
	public String findUsernameById(String username) {
		return tpl.selectOne("memberMapper.findUsernameById", username);
	}

	// 이메일 중복 확인
	public String findUsernameByEmail(String email) {
		return tpl.selectOne("memberMapper.findUsernameByEmail", email);
	}

	// 닉네임 중복 확인
	public String findUsernameByNick(String nick) {
		return tpl.selectOne("memberMapper.findUsernameByNick", nick);
	}

	// 회원 정보 저장 (회원 가입)
	public int insert(Member member) {
		return tpl.insert("memberMapper.insert", member);
	}

	// 아이디로 비밀번호 읽어오기 (비밀번호 확인)
	public String findPasswordById(String username) {
		return tpl.selectOne("memberMapper.findPasswordById", username);
	}

	// 회원 정보 읽기 (내 정보 보기)
	public Member findById(String username) {
		return tpl.selectOne("memberMapper.findById", username);
	}

	// 회원 정보 변경
	public int update(Member member) {
		return tpl.update("memberMapper.update", member);
	}

	// 비밀번호 변경
	public int updateNewPassword(String username, String newEncodedPassword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("newEncodedPassword", newEncodedPassword);
		return tpl.update("memberMapper.updateNewPassword", map);
	}

	// 회원 탈퇴
	public int delete(String username) {
		return tpl.update("memberMapper.delete", username);
	}
}

