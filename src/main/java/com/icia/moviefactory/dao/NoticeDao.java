package com.icia.moviefactory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.moviefactory.entity.Notice;

@Repository
public class NoticeDao {
	@Autowired
	private SqlSessionTemplate tpl;

	// 전체 글의 개수
	public int findAllCount() {
		return tpl.selectOne("noticeMapper.findAllCount");
	}

	// 전체 글의 개수를 이용한 페이징
	public List<Notice> findAll(int startRowNum, int endRowNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("noticeMapper.findAll", map);
	}

	// 글 쓰기
	public int insert(Notice notice) {
		return tpl.insert("noticeMapper.insert", notice);
	}

	// 글 변경
	public Integer update(Long noticeNo, String content) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);
		map.put("content", content);
		return tpl.update("noticeMapper.update", map);
	}

	// 글 삭제
	public int delete(long adminAskNo) {
		return tpl.delete("noticeMapper.delete", adminAskNo);
	}

	// 아이디로 검색해 게시판 글 페이징
	public List<Notice> findAllByUsername(int startRowNum, int endRowNum, String username) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		map.put("username", username);
		return tpl.selectList("noticeMapper.findAllByUsername", map);
	}

	// 글 작성자 읽어오기
	public String findUsernameById(long noticeNo) {
		return tpl.selectOne("noticeMapper.findUsernameById", noticeNo);
	}

	// 게시판 글 상세 읽어오기
	public Notice findByNotice(long noticeNo) {
		System.out.println(noticeNo + "dao로 옵니까???");
		return tpl.selectOne("noticeMapper.findByNotice", noticeNo);
	}
	// 글제목으로 검색해서 리스트 불러오기
	public List<Notice> findNoticeByTitle(int startRowNum, int endRowNum, String title) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		map.put("title", title);
		return tpl.selectList("noticeMapper.findNoticeByTitle", map); 
	}
	// 제목의 글 개수 가져오기
	public int findNoticeCountByTitle(String title) {
		return tpl.selectOne("noticeMapper.findNoticeCountByTitle", title); 
	}
}
