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
	// 그 유저의 목록을 가져온다 페이징
	public Page findAllAdminAskByUsername(int pageno, String username) {
		System.out.println(username+"유저네임을 확인하니");
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
			System.out.println(username+"들어왔니? - 서비스");
			// 여기로 안들어오고 있거든
			// 해결 후 들어옵니다
			int count = askDao.findCountByUsername(username);
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<AdminAsk> adminAsks = askDao.findAllByUsername(startRowNum, endRowNum,username);
			System.out.println(adminAsks+"리턴으로 가? 리스트를 받아왔니? -서비스");
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
	
	// 관리자 답변 작성


	// 글 삭제
	public int deleteAdminAsk(long adminAsk, String username) {
		if(!username.equals(askDao.findUsernameById(adminAsk)))
			new IllegalAccessException();
		return askDao.delete(adminAsk);
	}
}
