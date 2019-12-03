package com.icia.moviefactory.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.moviefactory.entity.AdminAsk;


@Repository
public class AskDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
		// 전체 글의 개수
		public int findAllCount() {
			return tpl.selectOne("askMapper.findAllCount"); 
		}
		// 전체 글의 개수를 이용한 페이징
		public List<AdminAsk> findAll(int startRowNum, int endRowNum) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startRowNum", startRowNum);
			map.put("endRowNum", endRowNum);
			return tpl.selectList("askMapper.findAll", map); 
		}
		
		// 아이디로 검색해 게시판 글 개수 읽어오기
		public int findCountByUsername(String username) {
			return tpl.selectOne("askMapper.findCountByUsername", username); 
		}
		
		// 글 쓰기	
		public int insert(AdminAsk adminAsk) {
			return tpl.insert("askMapper.insert", adminAsk);
		}
		// 글 변경
		public Integer update(Long adminAskNo, String content) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("adminAskNo", adminAskNo);
			map.put("content", content);
			return tpl.update("askMapper.update", map); 
		}
		
		// 글 삭제
		public int delete(long adminAskNo) {
			return tpl.delete("askMapper.delete", adminAskNo);
		}
		// 아이디로 검색해 게시판 글 페이징
		public List<AdminAsk> findAllByUsername(int startRowNum, int endRowNum, String username) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startRowNum", startRowNum);
			map.put("endRowNum", endRowNum);
			map.put("username", username);
			return tpl.selectList("askMapper.findAllByUsername", map); 
		}
		
		// 문의 답변
		public int askAnswer(AdminAsk adminAsk) {
			return tpl.update("askMapper.askAnswer", adminAsk);
		}
		
		// 글 작성자 읽어오기
		public String findUsernameById(long adminAskNo) {
			return tpl.selectOne("askMapper.findUsernameById", adminAskNo);
		}
		// 게시판 글 상세 읽어오기
		public AdminAsk findByAdminAsk(long adminAskNo) {
			return tpl.selectOne("askMapper.findByAdminAsk", adminAskNo);
		}
}
