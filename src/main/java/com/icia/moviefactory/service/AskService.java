package com.icia.moviefactory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.moviefactory.dao.AskDao;
import com.icia.moviefactory.dto.Page;
import com.icia.moviefactory.entity.AdminAsk;

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
	// 그 유저의 목록을 가져온다 페이징
	public Page findAllAdminAskByUsername(int pageno, String username) {
		//동민아 여기서 username이 null이라서 if문에 null쪽으로 출력되고 있어
		// 해결법 : rest에서 로그인확인시켰어
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
}
