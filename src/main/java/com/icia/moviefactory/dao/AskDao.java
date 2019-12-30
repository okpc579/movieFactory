package com.icia.moviefactory.dao;


import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;


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
		// 일반회원 의 게시판 글 페이징
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
		
		// 아이디로 검색해서 리스트 불러오기
		public List<AdminAsk> findAdminAskByUsername(int startRowNum, int endRowNum, String username) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startRowNum", startRowNum);
			map.put("endRowNum", endRowNum);
			map.put("username", username);
			return tpl.selectList("askMapper.findAdminAskByUsername", map); 
		}
		
		// 일반회원의 글 개수 가져오기
		public int findAdminAskCountByUsername(String username) {
			return tpl.selectOne("askMapper.findAdminAskCountByUsername", username); 
		}
		// 글제목으로 검색해서 리스트 불러오기
		public List<AdminAsk> findAdminAskByTitle(int startRowNum, int endRowNum, String title) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startRowNum", startRowNum);
			map.put("endRowNum", endRowNum);
			map.put("title", title);
			return tpl.selectList("askMapper.findAdminAskByTitle", map); 
		}
		
		// 제목의 글 개수 가져오기
		public int findAdminAskCountByTitle(String title) {
			return tpl.selectOne("askMapper.findAdminAskCountByTitle", title); 
		}
		
		// 읽기전을 답변중으로 바꾸기
		public int answering(long adminAskNo) {
			return tpl.update("askMapper.answering",adminAskNo);
		}
		// 로그인한 아이디인지 확인하기
		public String checkusername(String username, long adminAskNo) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("username", username);
			map.put("adminAskNo", adminAskNo);
			return tpl.selectOne("askMapper.checkusername",map);
		}
}
