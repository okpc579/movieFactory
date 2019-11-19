package com.icia.moviefactory.restcontroller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;
@RequestMapping("/api")
@CrossOrigin("*")
@RestController
public class MovieRestController {
	@Autowired
	private MovieService service;
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/review/write")
	public ResponseEntity<?> insertrev(@ModelAttribute MovieReview moviereview) {
		return ResponseEntity.ok(service.insertrev(moviereview));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/review/update")
	public ResponseEntity<?> updaterev(@ModelAttribute MovieReview moviereview) {
		return ResponseEntity.ok(service.updaterev(moviereview));
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/review/delete")
	public ResponseEntity<?> deleterev(long mRevNo) {
		return ResponseEntity.ok(service.deleterev(mRevNo));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/review/like")
	public ResponseEntity<?> insertrevlike(@ModelAttribute MovieReviewLike moviereviewlike) {
		return ResponseEntity.ok(service.insertrevlike(moviereviewlike));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/report")
	public ResponseEntity<?> insertrevrep(@ModelAttribute MovieReviewReport moviereviewreport,@ModelAttribute MovieReviewCommentReport moviereviewcommentreport) {
		service.insertcmntrep(moviereviewcommentreport);
		return ResponseEntity.ok(service.insertrevrep(moviereviewreport));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/write")
	public ResponseEntity<?> insertcmnt(@ModelAttribute MovieReviewComment moviereviewcomment) {
		return ResponseEntity.ok(service.insertcmnt(moviereviewcomment));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/comment/update")
	public ResponseEntity<?> updaterevcmnt(@ModelAttribute MovieReviewComment moviereviewcomment) {
		return ResponseEntity.ok(service.updaterevcmnt(moviereviewcomment));
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/comment/delete")
	public ResponseEntity<?> deleterevcmnt(long mRevCmntNo) {
		return ResponseEntity.ok(service.deleterevcmnt(mRevCmntNo));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/like")
	public ResponseEntity<?> insertcmntlike(@ModelAttribute MovieReviewCommentLike moviereviewcommentlike) {
		return ResponseEntity.ok(service.insertcmntlike(moviereviewcommentlike));
	}
	
	
}
