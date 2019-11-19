package com.icia.moviefactory.dao;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.entity.*;

@Repository
public class MovieDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public int insertrev(MovieReview moviereview) {
		return tpl.insert("movieMapper.insertrev",moviereview);
	}
	
	public int updaterev(MovieReview moviereview) {
		return tpl.update("movieMapper.updaterev",moviereview);
	}
	
	public int deleterev(long mRevNo) {
		return tpl.delete("movieMapper.deleterev",mRevNo);
	}
	
	public int insertrevlike(MovieReviewLike moviereviewlike) {
		return tpl.insert("movieMapper.insertrevlike",moviereviewlike);
	}
	
	public int revlikecnt(long mRevLikeNo) {
		return tpl.selectOne("movieMapper.revlikecnt",mRevLikeNo);
	}
	
	public int insertrevrep(MovieReviewReport moviereviewreport) {
		return tpl.insert("movieMapper.insertrevrep",moviereviewreport);
	}
	
	public int insertcmnt(MovieReviewComment moviereviewcomment) {
		return tpl.insert("movieMapper.insertcmnt",moviereviewcomment);
	}
	
	public int updaterevcmnt(MovieReviewComment moviereviewcomment) {
		return tpl.update("movieMapper.updaterevcmnt",moviereviewcomment);
	}
	
	public int deleterevcmnt(long mRevCmntNo) {
		return tpl.delete("movieMapper.deleterevcmnt",mRevCmntNo);
	}
	
	public int insertcmntlike(MovieReviewCommentLike moviereviewcommentlike) {
		return tpl.insert("movieMapper.insertcmntlike",moviereviewcommentlike);
	}
	
	public int cmntlikecnt(long cmntLikeNo) {
		return tpl.selectOne("movieMapper.cmntlikecnt",cmntLikeNo);
	}
	
	public int insertcmntrep(MovieReviewCommentReport moviereviewcommentreport) {
		return tpl.insert("movieMapper.insertcmntrep",moviereviewcommentreport);
	}
	
	
	
	
	
	
	
	
	
	
}
