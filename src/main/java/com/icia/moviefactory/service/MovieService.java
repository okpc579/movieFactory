package com.icia.moviefactory.service;

import java.util.*;

import org.modelmapper.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;

import com.fasterxml.jackson.databind.*;
import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.dto.*;
import com.icia.moviefactory.entity.*;

@Service
public class MovieService {
	@Autowired
	private MovieDao dao;
	@Autowired
	private RecommendMapper recommendMapper;
	@Autowired
	private ModelMapper modelMapper;
	@Autowired
	private ObjectMapper objectMapper;
	@Value("10")
	private int pagesize;
	
	public Page findAllReviewByUsername(int pageno, String username) {
		if(username==null) {
			int count = dao.findCount();
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<MovieReview> reviews = dao.findAll(startRowNum, endRowNum);
			return new Page().builder().pageno(pageno).pagesize(pageno).totalcount(count).reviews(reviews).build();
		} else {
			int count = dao.findCountByUsername(username);
			int startRowNum = ((pageno-1) * pagesize + 1);
			int endRowNum = startRowNum + pagesize -1;
			if(endRowNum >= count)
				endRowNum = count;
			List<MovieReview> reviews = dao.findAllByUsername(startRowNum, endRowNum, username);
			return new Page().builder().pageno(pageno).pagesize(pagesize).totalcount(count).reviews(reviews).build();
		}
	}
	
	public MovieReview insertrev(MovieReview moviereview) {
		ResponseEntity.ok(dao.insertrev(moviereview));
		return moviereview;
	}
	
	public Void updaterev(MovieReview moviereview,String username) {
		if(!username.equals(dao.findUsernameById(moviereview.getMRevNo())))
			new IllegalAccessException();
		dao.updaterev(moviereview);
		return null;
	}
	
	public int deleterev(long mRevNo, String username) {
		if(!username.equals(dao.findUsernameById(mRevNo)))
			new IllegalAccessException();
		return dao.deleterev(mRevNo);
	}
	
	public int updatelikecnt(long mRevNo, String username) {
		// 자신의 글 추천 막기
		if(!username.equals(dao.findUsernameById(mRevNo)))
			new IllegalAccessException();
			// 이미 추천 또는 신고한 글인지 users_board 테이블에서 조회
		if(recommendMapper.findById(username, mRevNo)!=null) 
			return dao.updatelikecnt(mRevNo);
		// users_board 테이블에 글번호와 아이디 저장(추천/신고 여부는 필요없다. 하나의 글에 대해 추천/신고 중 하나만 가능)
		recommendMapper.insert(username, mRevNo);
		// 글 추천
		dao.updatelikecnt(mRevNo);
		// 추천수 가져오기
		return dao.updatelikecnt(mRevNo);
	}
	
	public int updaterepcnt(MovieReviewReport moviereviewreport) {
		String username = moviereviewreport.getUsername();
		Long mRevNo = moviereviewreport.getMRevNo();
		System.out.println("==============================================");
		System.out.println(username);
		System.out.println(mRevNo);
		if(!username.equals(dao.findUsernameById(mRevNo))) 
			new IllegalAccessException();
		if(recommendMapper.findById(username, mRevNo)!=null) 
			return dao.findReportCnt(mRevNo);
		recommendMapper.insert(username, mRevNo);
		dao.updaterepcnt(mRevNo);
		
		return dao.findReportCnt(mRevNo);
	}
	
	public MovieReviewComment insertcmnt(MovieReviewComment moviereviewcomment) {
		dao.insertcmnt(moviereviewcomment);
		long mRevNo = moviereviewcomment.getMRevCmntNo();
		return dao.findByCmntByMRevNo(mRevNo);
	}
	
	public Void updaterevcmnt(MovieReviewComment moviereviewcomment, String username) {
		if(!username.equals(dao.findUsernameById(moviereviewcomment.getMRevNo())))
			new IllegalAccessException();
		dao.updaterevcmnt(moviereviewcomment);
		return null;
	}
	
	public int deleterevcmnt(long mRevCmntNo) {
		return dao.deleterevcmnt(mRevCmntNo);
	}
	
	public MovieReviewComment deleteByCmntByMRevNo(long mRevNo, long mRevCmntNo) {
		dao.deleterevcmnt(mRevCmntNo);
		return dao.findByCmntByMRevNo(mRevNo);
	}
	
	public ResponseEntity<?> insertcmntlike(MovieReviewCommentLike moviereviewcommentlike) {
		dao.insertcmntlike(moviereviewcommentlike);
		long cmntLikeNo = moviereviewcommentlike.getCmntLikeNo();
		return ResponseEntity.ok(dao.cmntlikecnt(cmntLikeNo));
	}
	
	
	public MovieReviewDto findReviewByIdWithComments(Long mRevNo, String username) {
		MovieReviewDto dto = modelMapper.map(dao.findByIdWithComments(mRevNo), MovieReviewDto.class);
		// 글쓴이 여부를 추가
		if(username!=null) {
			dto.setOwn(username.equals(dto.getUsername()));
		} else { 
			dto.setOwn(false);
		}
		return dto;
	}
	
	
	
}
