package com.icia.moviefactory.service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;

import com.icia.moviefactory.dao.*;
import com.icia.moviefactory.entity.*;

@Service
public class MovieService {
	@Autowired
	private MovieDao dao;
	
	public ResponseEntity<?> insertrev(MovieReview moviereview) {
		return ResponseEntity.ok(dao.insertrev(moviereview));
	}
	
	public ResponseEntity<?> updaterev(MovieReview moviereview) {
		return ResponseEntity.ok(dao.updaterev(moviereview));
	}
	
	public ResponseEntity<?> deleterev(long mRevNo) {
		return ResponseEntity.ok(dao.deleterev(mRevNo));
	}
	
	public ResponseEntity<?> insertrevlike(MovieReviewLike moviereviewlike) {
		dao.insertrevlike(moviereviewlike);
		long mRevLikeNo = moviereviewlike.getMRevLikeNo();
		return ResponseEntity.ok(dao.revlikecnt(mRevLikeNo));
	}
	
	public ResponseEntity<?> insertrevrep(MovieReviewReport moviereviewreport) {
		return ResponseEntity.ok(dao.insertrevrep(moviereviewreport));
	}
	
	public ResponseEntity<?> insertcmnt(MovieReviewComment moviereviewcomment) {
		return ResponseEntity.ok(dao.insertcmnt(moviereviewcomment));
	}
	
	public ResponseEntity<?> updaterevcmnt(MovieReviewComment moviereviewcomment) {
		return ResponseEntity.ok(dao.updaterevcmnt(moviereviewcomment));
	}
	
	public ResponseEntity<?> deleterevcmnt(long mRevCmntNo) {
		return ResponseEntity.ok(dao.deleterevcmnt(mRevCmntNo));
	}
	
	public ResponseEntity<?> insertcmntlike(MovieReviewCommentLike moviereviewcommentlike) {
		dao.insertcmntlike(moviereviewcommentlike);
		long cmntLikeNo = moviereviewcommentlike.getCmntLikeNo();
		return ResponseEntity.ok(dao.cmntlikecnt(cmntLikeNo));
	}
	
	public ResponseEntity<?> insertcmntrep(MovieReviewCommentReport moviereviewcommentreport) {
		return ResponseEntity.ok(dao.insertcmntrep(moviereviewcommentreport));
	}
	
	
	
}
