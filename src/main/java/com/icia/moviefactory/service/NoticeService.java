package com.icia.moviefactory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.icia.moviefactory.dao.NoticeDao;
import com.icia.moviefactory.dto.Page;
import com.icia.moviefactory.entity.Notice;

@Service
public class NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	@Value("10")
	private int pagesize;
	
	// 관리자가 모든 공지글을 가져오기
		public Page findAll(int pageno, String username) {
			int count = noticeDao.findAllCount();
			int startRowNum = (pageno-1) * pagesize + 1;
			int endRowNum = startRowNum + pagesize - 1;
			
			if(endRowNum >= count)
				endRowNum = count;
			List<Notice> notices = noticeDao.findAll(startRowNum, endRowNum);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).notices(notices).build();
		}
		// 관리자가 공지글 작성
		public Notice writeNotice(Notice notice) {
			noticeDao.insert(notice);
			return notice;
		}
		// 관리자가 공지글 변경
		public Integer updateNotice(Long noticeNo, String content ,String username) {
			return noticeDao.update(noticeNo,content);
		}
		// 공지글 삭제
		public Integer deleteNotice(Long noticeNo, String username) {
			return noticeDao.delete(noticeNo);
		}
		// 공지글 읽기
		public Notice readNotice(long noticeNo) {
			System.out.println(noticeNo + "서비스로 옵니까???");
			return noticeDao.findByNotice(noticeNo);
		}
}
