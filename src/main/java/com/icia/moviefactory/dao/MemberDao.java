package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

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

}
