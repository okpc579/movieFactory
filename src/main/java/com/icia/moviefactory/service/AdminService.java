package com.icia.moviefactory.service;

import java.util.*;

import org.modelmapper.*;
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
	@Autowired
	private ModelMapper modelMapper;
	
	// 모든 블락된 계정 리스트 불러오기
	public Page findAllEnabledList(int pageno) {
		int count = adminDao.findEnabledCount();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Member> members = adminDao.findAllEnabledList(startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).members(members).build();
		}
	
	// 아이디로 검색한 블락 목록 불러오기
	public Page searchByUsernameEnabledList(int pageno, String search) {
		int count = adminDao.searchByUsernameEnabledCount(search);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Member> members = adminDao.searchByUsernameEnabledList(startRowNum, endRowNum, search);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).members(members).build();
		}
	
	// 블라인드 된 리뷰 전체 불러오기(블라인드 게시판)
	public Page findRevBlind(int pageno) {
		int count = adminDao.findRevBlindCount();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReview> movieReviews = adminDao.findRevBlind(startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviews(movieReviews).build();
		}
	
	// 내용으로 검색한 블라인드 리뷰 불러오기
	public Page searchByContentRevBlind(int pageno, String search) {
		int count = adminDao.searchByContentRevBlindCount(search);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReview> movieReviews = adminDao.searchByContentRevBlind(startRowNum, endRowNum, search);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviews(movieReviews).build();
		}
	
	// 아이디로 검색한 블라인드 리뷰 불러오기
	public Page searchByUsernameRevBlind(int pageno, String search) {
		int count = adminDao.searchByUsernameRevBlindCount(search);
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReview> movieReviews = adminDao.searchByUsernameRevBlind(startRowNum, endRowNum, search);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviews(movieReviews).build();
		}
	
	// 블라인드 된 댓글 전체 불러오기(블라인드 게시판)
	public Page findRevCmntBlind(int pageno) {
		int count = adminDao.findRevCmntBlindCount();
		System.out.println("pageno : " +  pageno);
		int startRowNum = ((pageno-1) * pagesize + 1);
		System.out.println("start : " +  startRowNum);
		int endRowNum = startRowNum + pagesize -1;
		System.out.println("end : " +  endRowNum);
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReviewComment> movieReviewComments = adminDao.findRevCmntBlind(startRowNum, endRowNum);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviewComments(movieReviewComments).build();
		}
	
	// 내용으로 검색한 블라인드 댓글 불러오기
	public Page searchByContentCmntBlind(int pageno, String search) {
		int count = adminDao.searchByContentCmntBlindCount(search); 
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReviewComment> movieReviewComments = adminDao.searchByContentCmntBlind(startRowNum, endRowNum, search);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviewComments(movieReviewComments).build();
	}
	
	// 아이디로 검색한 블라인드 댓글 불러오기
	public Page searchByUsernameCmntBlind(int pageno, String search) {
		int count = adminDao.searchByUsernameCmntBlindCount(search); 
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<MovieReviewComment> movieReviewComments = adminDao.searchByUsernameCmntBlind(startRowNum, endRowNum, search);
		return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).movieReviewComments(movieReviewComments).build();
	}
	
	// 블락계정 상세(블락된 유저의 블라인드된 리뷰 불러오기)
	public List<MovieReview> findRevBlindByUser(String username) {
		List<MovieReview> moviereivew = adminDao.findRevBlindByUser(username);
		return moviereivew;
	}
	
	// 블락계정 상세(블락된 유저의 블라인드된 댓글 불러오기)
	public List<MovieReviewComment> findRevCmntBlindByUser(String username) {
		List<MovieReviewComment> moviereivewcomment = adminDao.findRevCmntBlindByUser(username);
		return moviereivewcomment;
	}

	// 블라인드 된 리뷰 상세(그 리뷰에 대한 신고목록 불러오기)
	/*
	public List<MovieReviewReport> readRevBlind(long mRevNo) {
		List<MovieReviewReport> reviewreportlist = adminDao.readRevBlind(mRevNo);
		return reviewreportlist;
		
	}
	*/
	public MovieReview readRevBlind(long mRevNo) {
		System.out.println(adminDao.readRevBlind(mRevNo));
		MovieReview mr = modelMapper.map(adminDao.readRevBlind(mRevNo), MovieReview.class);
		System.out.println(mr);
		return mr;
	}
	public MovieReviewComment readRevCmntBlind(long mRevCmntNo) {
		System.out.println(adminDao.readCmntBlind(mRevCmntNo));
		MovieReviewComment mrc = modelMapper.map(adminDao.readCmntBlind(mRevCmntNo), MovieReviewComment.class);
		System.out.println(mrc);
		return mrc;	
	}
	
	// 블락 된 계정 블락여부 수정
	public long updateEnabled(String username) {
		return adminDao.updateEnabled(username);
	}
	
	// 블라인드 된 리뷰 블라인드 여부 수정
	public long updateRevBlind(long mRevNo) {
		return adminDao.updateRevBlind(mRevNo);
		
	}
	// 블라인드 된 댓글 블라인드 여부 수정
	public long updateCmntBlind(long mRevCmntNo) {
		return adminDao.updateCmntBlind(mRevCmntNo);
	}
	
	// 리뷰 블라인드
	// 신고횟수를 블러온다 - 횟수가 10회이상이면 리뷰 블라인드처리
	// 멤버 테이블에서 블라인드카운트를 1증가
	public Void reviewBlind(long mRevNo, String username) {
		long revRepCnt = adminDao.findRevRepCnt(mRevNo);
		if(revRepCnt>=10) {
			adminDao.isBlindRevUpdate(username);
			adminDao.increaseBlindCnt(username);
		}
		return null;
	}
	
	// 댓글 블라인드
	// 신고횟수를 블러온다 - 횟수가 10회이상이면 댓글 블라인드처리
	// 멤버 테이블에서 블라인드카운트를 1증가
	public Void commentBlind(long mRevCmntNo, String username) {
		long cmntRepCnt = adminDao.findCmntRepCnt(mRevCmntNo);
		if(cmntRepCnt>=10) {
			adminDao.isBlindCmntUpdate(username);
			adminDao.increaseBlindCnt(username);
		}
		return null;
	}	
	
	// 회원 블락
	// 블라인드 횟수를 불러온다 - 횟수가 5회이상이면 회원 블락처리
	// 멤버 테이블에서 enabled = 0 으로 업데이트
	public Void userBlock(String username) {
		long blindCnt = adminDao.findBlindCnt(username);
		if(blindCnt>=5) {
			adminDao.enabledUpdate(username);
		}
		return null;
	}
}
