package com.icia.moviefactory.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.entity.*;

@Service
public class AskService {
	@Autowired
	private AskDao askDao;
	@Value("10")
	private int pagesize;
	
	// 관리자가 모든 유저문의글을 가져오기
	public Page findAll(int pageno, String username) {
		int count = askDao.findAllCount();
		int startRowNum = (pageno-1) * pagesize + 1;
		int endRowNum = startRowNum + pagesize - 1;
		
		if(endRowNum >= count)
			endRowNum = count;
		List<AdminAsk> adminAsks = askDao.findAll(startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
	}
	// 유저의 목록을 가져온다 페이징
	public Page findAllAdminAskByUsername(int pageno, String username) {
		if(username==null) {
			int count = askDao.findAllCount();
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAll(startRowNum, endRowNum);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		} else {
			int count = askDao.findCountByUsername(username);
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAllByUsername(startRowNum, endRowNum,username);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		}
	}
	// 유저 글 작성
	public AdminAsk writeAdminAsk(AdminAsk adminAsk) {
		askDao.insert(adminAsk);
		return adminAsk;
	}
	// 유저 글 변경
	public Integer updateAdminAsk(Long adminAskNo, String content ,String username) {
		if(!username.equals(askDao.findUsernameById(adminAskNo)))
			new IllegalAccessException();
		return askDao.update(adminAskNo,content);
	}
	
	// 유저 글 삭제
	public Integer deleteAdminAsk(Long adminAskNo, String username) {
		if(!username.equals(askDao.findUsernameById(adminAskNo)))
			new IllegalAccessException();
		return askDao.delete(adminAskNo);
	}
	// 글 읽기
	public AdminAsk readAdminAsk(long adminAskNo, String username) {
		return askDao.findByAdminAsk(adminAskNo);
	}
	// 관리자 답글 작성
	public int askAnswer(AdminAsk adminAsk) {
		return askDao.askAnswer(adminAsk);
	}
	
	// 아이디로 검색해 글 페이징 가져오기
	public Page findAdminAskBySearchUsername(int pageno, String username) {
		if(username==null) {
			int count = askDao.findAllCount();
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAll(startRowNum, endRowNum);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		} else {
			int count = askDao.findAdminAskCountByUsername(username);
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAdminAskByUsername(startRowNum, endRowNum,username);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		}
	}
	// 글제목으로 검색해 글 페이징 가져오기
	public Page findAdminAskBySearchTitle(int pageno, String title) {
		if(title==null) {
			int count = askDao.findAllCount();
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAll(startRowNum, endRowNum);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		} else {
			int count = askDao.findAdminAskCountByTitle(title);
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAdminAskByTitle(startRowNum, endRowNum,title);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		}
	}
	
	// 읽기전 답변중으로 바꾸기
	public int answering(long adminAskNo) {
		return askDao.answering(adminAskNo);
	}
	public String checkusername(String username, long adminAskNo) {
		return askDao.checkusername(username, adminAskNo)==null?"false":"true";
	}
}
