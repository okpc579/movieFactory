package com.icia.moviefactory.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.entity.*;

@Service
public class AdminService {
	@Autowired
	private AdminDao adminDao; 
	@Value("10")
	private int pagesize;
	// 모든 블락된 계정 리스트 불러오기
	/* public List<Member> findAllEnabledList() {
		List<Member> memberlist = dao.findAllEnabledList();
		return memberlist;
		return dao.findallEnabledlist();
	}*/	
	
	public Page findAllEnabledList(int pageno) {
		int count = adminDao.findEnabledCount();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Member> members = adminDao.findAllEnabledList(startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).members(members).build();
		}

	public Page findRevBlind(int pageno) {
		int count = adminDao.findRevBlindCount();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReview> movieReviews = adminDao.findRevBlind(startRowNum, endRowNum);
//		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).members(members)(movieReviews).build();
		return null;
		}
	
	public Page findRevCmntBlind(int pageno) {
//		int count = adminDao.findRevCmntBlind();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
//		if(endRowNum >= count)
//			endRowNum = count;
		List<Member> members = adminDao.findAllEnabledList(startRowNum, endRowNum);
//		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).members(members).build();
		return null;
		}
	
	
	// 블락계정 상세(블락된 유저의 블라인드된 댓글과 리뷰 불러오기)
	public Object findBlindListByUser() {
		
		return null;
	}
	// 블라인드 된 리뷰 전체 불러오기(블라인드 게시판)
	public List<MovieReview> findRevBlind() {
		//List<MovieReview> moviereviewlist = dao.findRevBlind();
		//return moviereviewlist;
		return null;
	}
	// 블라인드 된 댓글 전체 불러오기(블라인드 게시판)
	public List<MovieReviewComment> findRevCmntBlind() {
		//List<MovieReviewComment> commentlist = dao.findRevCmntBlind(1);
		//return commentlist;
		return null;
	}
	// 블라인드 된 리뷰 상세(그 리뷰에 대한 신고목록 불러오기)
	public List<MovieReviewReport> readRevBlind() {
		//List<MovieReviewReport> reviewreportlist = dao.readRevBlind(0);
		//return reviewreportlist;
		return null;
	}
	// 블라인드 된 댓글 상세(그 댓글에 대한 신고목록 불러오기)
	public List<MovieReviewCommentReport> readRevCmntBlind() {
		//List<MovieReviewCommentReport> commentreportlist = dao.readCmntBlind(0);
		//return commentreportlist;
		return null;
	}
	
	// 블락 된 계정 블락여부 수정
	public Object updateEnabled() {
		
		//return ResponseEntity.ok(dao.updateEnabled());
		return null;
	}
	
	
	// 블라인드 된 리뷰나 댓글 블라인드 여부 수정
	public long updateRevBlind(long mRevNo) {
	//	return dao.updateRevBlind(mRevNo);
		return 0;
	}
	public long updateCmntBlind(long mRevCmntNo) {
//		return	dao.updateCmntBlind(mRevCmntNo);
		return 0;
		 
	}
		
}
