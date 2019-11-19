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
	
	// 그 유저의 목록을 가져온다 페이징
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
			List<AdminAsk> adminAsks = askDao.findAllByUsername(startRowNum, endRowNum, username);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).adminAsks(adminAsks).build();
		}
	}
	// 글 작성
	public AdminAsk writeAdminAsk(AdminAsk adminAsk) {
		askDao.insert(adminAsk);
		return adminAsk;
	}
	// 글 변경
	public Void updateAdminAsk(AdminAsk adminAsk, String username) {
		if(!username.equals(askDao.findUsernameById(adminAsk.getAdminAskNo())))
			new IllegalAccessException();
		askDao.update(adminAsk);
		return null;
	}
	// 글 삭제
	public int deleteAdminAsk(long adminAsk, String username) {
		if(!username.equals(askDao.findUsernameById(adminAsk)))
			new IllegalAccessException();
		return askDao.delete(adminAsk);
	}
}
