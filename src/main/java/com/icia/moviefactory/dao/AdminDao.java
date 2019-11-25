package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class AdminDao {
	@Autowired
	private SqlSessionTemplate tpl;

	

	// 블라인드 된 리뷰 블라인드 여부 수정
	public long updateRevBlind(long mRevNo) {
		return tpl.update("adminMapper.updateRevBlind", mRevNo);
	}

	// 블라인드 된 댓글 블라인드 여부 수정
	public long updateCmntBlind(long mRevCmntNo) {
		return tpl.update("adminMapper.updateRevCmntBlind", mRevCmntNo);
	}

	// 블라인드 된 댓글 상세(신고내역)
	public List<MovieReviewCommentReport> readCmntBlind(long mRevCmntNo) {
		return tpl.selectList("adminMapper.readCmntBlind", mRevCmntNo);
	}

	// 블라인드 된 리뷰 상세(신고내역)
	public List<MovieReviewReport> readRevBlind(long mRevNo) {
		return tpl.selectList("adminMapper.readRevBlind", mRevNo);
	}

	// 블락리스트 상세
	public List<MovieReview> findRevBlindByUser(long isBlind, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isBlind", isBlind);
		map.put("username", username);
		return tpl.selectList("adminMapper.findRevBlindByUser", map);
	}

	public List<MovieReviewComment> findRevCmntBlindByUser(long isBlind, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isBlind", isBlind);
		map.put("username", username);
		return tpl.selectList("adminMapper.findRevCmntBlindByUser", map);
	}

	// 블락 된 계정 블락여부 수정
	public long updateEnabled(String username) {
		return tpl.update("adminMapper.updateEnabled", username);
	}
	// 블라인드 당한 리뷰 수
		public int findRevBlindCount() {
			return tpl.selectOne("adminMapper.findRevBlindCount");
	}
			
	// 블라인드당한 리뷰를 이용한 페이징
	public List<MovieReview> findRevBlind(int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("adminMapper.findRevBlind", map);
	}
		
	// 블라인드 당한 댓글 수
	public int findRevCmntBlindCount() {
		return tpl.selectOne("adminMapper.findRevCmntBlindCount");
	}
				
	// 블라인드당한 댓글을 이용한 페이징
	public List<MovieReviewComment> findRevCmntBlind(int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("adminMapper.findRevCmntBlind", map);
	}	
	
	// 블락 당한 유저 수
	public int findEnabledCount() {
		return tpl.selectOne("adminMapper.findEnabledCount");
	}

	// 블락당한 전체유저를 이용한 페이징
	public List<Member> findAllEnabledList(int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("adminMapper.findAllEnabledList", map);
	}
	
	
}
