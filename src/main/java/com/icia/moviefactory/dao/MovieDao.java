package com.icia.moviefactory.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class MovieDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	// 리뷰 등록
	public int insertrev(MovieReview moviereview) {
		return tpl.insert("movieMapper.insertrev",moviereview);
	}
	
	// 리뷰 수정
	public int updaterev(MovieReview moviereview) {
		return tpl.update("movieMapper.updaterev",moviereview);
	}
	
	// 리뷰 삭제
	public int deleterev(long mRevNo) {
		return tpl.delete("movieMapper.deleterev",mRevNo);
	}
	
	// 리뷰 좋아요 증가
	public int updatelikecnt(long mRevNo) {
		return tpl.update("movieMapper.updatelikecnt",mRevNo);
	}
	
	// 좋아요 수 읽어오기
	public int findLikeCnt(long mRevNo) {
		return tpl.selectOne("movieMapper.findLikeCnt",mRevNo);
	}
	
	// 리뷰 신고수 증가
	public int updaterepcnt(long mRevNo) {
		return tpl.update("movieMapper.updaterepcnt",mRevNo);
	}
	
	// 신고 수 읽어오기
	public int findReportCnt(long mRevNo) {
		return tpl.selectOne("movieMapper.findReportCnt",mRevNo);
	}
	
	// 댓글 등록
	public int insertcmnt(MovieReviewComment moviereviewcomment) {
		return tpl.insert("movieMapper.insertcmnt",moviereviewcomment);
	}
	
	// 댓글 수정
	public int updaterevcmnt(MovieReviewComment moviereviewcomment) {
		return tpl.update("movieMapper.updaterevcmnt",moviereviewcomment);
	}
	
	// 리뷰번호로 댓글 불러오기
	public MovieReviewComment findByCmntByMRevNo(long mRevNo) {
		return tpl.selectOne("movieMapper.findByCmntByMRevNo", mRevNo);
		
	}
	
	// 리뷰 댓글번호로 댓글 삭제
	public int deleterevcmnt(long mRevCmntNo) {
		return tpl.delete("movieMapper.deleterevcmnt",mRevCmntNo);
	}
	
	// 리뷰번호로 댓글 삭제
	
	public int deleteByMRevNo(long mRevNo) {
		return tpl.delete("movieMapper.deleteByMRevNo", mRevNo);
	}
	
	// 댓글 좋아요
	public int insertcmntlike(MovieReviewCommentLike moviereviewcommentlike) {
		return tpl.insert("movieMapper.insertcmntlike",moviereviewcommentlike);
	}
	
	// 댓글 좋아요 카운트
	public int cmntlikecnt(long cmntLikeNo) {
		return tpl.selectOne("movieMapper.cmntlikecnt",cmntLikeNo);
	}
	
	// 댓글 신고 등록
	public int insertcmntrep(MovieReviewCommentReport moviereviewcommentreport) {
		return tpl.insert("movieMapper.insertcmntrep",moviereviewcommentreport);
	}

	// 전체 리뷰 개수
	public int findCount() {
		return tpl.selectOne("movieMapper.findCount");
	}
	
	// 전체 리뷰의 개수를 이용한 페이징
	public List<MovieReview> findAll(int startRowNum, int endRowNum){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		return tpl.selectList("movieBapper.findAll",map);
		
	}
	
	// 작성자로 검색해 리뷰 글 개수 읽어오기
	public int findCountByUsername(String username) {
		return tpl.selectOne("movieMapper.findCountByUsername",username);
	}
	
	// 작성자로 검색해 리뷰 페이징
	public List<MovieReview> findAllByUsername (int startRowNum, int endRowNum, String username){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRowNum", startRowNum);
		map.put("endRowNum", endRowNum);
		map.put("username", username);
		return tpl.selectList("movieMapper.findAllByUsername",map);
	}
	
	// 댓글을 포함해 리뷰 불러오기
	public Map findByIdWithComments(long mRevNo) {
		return tpl.selectOne("movieMapper.findByIdWithComments",mRevNo);
	}
	
	// 리뷰 작성자 읽어오기
	public String findUsernameById(long mRevNo) {
		return tpl.selectOne("movieMapper.findUsernameById", mRevNo);
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
}
