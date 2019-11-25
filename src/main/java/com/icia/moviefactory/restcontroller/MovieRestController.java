package com.icia.moviefactory.restcontroller;

import java.net.*;
import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

import lombok.*;
@RequestMapping("/api")
@RestController
public class MovieRestController {
	@Autowired
	private MovieService service;
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(path = "/movie/review/write", produces="application/json")
	public ResponseEntity<?> insertrev(@ModelAttribute MovieReview moviereview, Principal principal) {
		moviereview.setUsername(principal.getName());
		MovieReview result = service.insertrev(moviereview);
		URI location = UriComponentsBuilder.newInstance().path("/moviefactory/api/movie/review/write").path(result.getMRevNo()+"").build().toUri();
		return ResponseEntity.created(location).body(result.getMRevNo()); 
	}
	
	// board-4. 글 읽기 : 글을 읽는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
		@GetMapping("/movie/review/read/{mRevNo}")
		public ResponseEntity<?> readBoard(@PathVariable Long mRevNo, Principal principal) {
			// 로그인하지 않아도 글을 읽을 수 있다. username은 로그인하지 않은 경우 null이 된다
			String username = principal!=null? principal.getName() : null;
			return ResponseEntity.ok(service.findReviewByIdWithComments(mRevNo, username));
		}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(path = "/movie/review/update", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> updatetrev(@ModelAttribute MovieReview moviereview, Principal principal) {
		System.out.println(moviereview);
		moviereview.setUsername(principal.getName());
		return ResponseEntity.ok(service.updaterev(moviereview,principal.getName()));
	}
	
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/review/delete")
	public ResponseEntity<?> deleterev(long mRevNo, String username) {
		return ResponseEntity.ok(service.deleterev(mRevNo,username));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/review/like")
	public ResponseEntity<?> insertrevlike(long mRevNo, String username) {
		return ResponseEntity.ok(service.updatelikecnt(mRevNo,username));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/report")
	public ResponseEntity<?> report(MovieReviewReport moviereviewreport) {
		System.out.println("---------------------------------------------------");
		System.out.println(moviereviewreport);
		return ResponseEntity.ok(service.updaterepcnt(moviereviewreport));
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/write")
	public ResponseEntity<?> insertcmnt(@ModelAttribute MovieReviewComment moviereviewcomment,Principal principal) {
		moviereviewcomment.setUsername(principal.getName());
		return ResponseEntity.ok(service.insertcmnt(moviereviewcomment));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/comment/update")
	public ResponseEntity<?> updaterevcmnt(MovieReviewComment moviereviewcomment, String username) {
		return ResponseEntity.ok(service.updaterevcmnt(moviereviewcomment,username));
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/comment/deletebyrevno")
	public ResponseEntity<?> deleterevcmnt(@NonNull Long mRevCmntNo) {
		return ResponseEntity.ok(service.deleterevcmnt(mRevCmntNo));
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/comment/deletebycmntno")
	public ResponseEntity<?> deleterevcmnt(@NonNull Long mRevCmntNo,@NonNull Long mRevNo){;
		return ResponseEntity.ok(service.deleteByCmntByMRevNo(mRevNo, mRevCmntNo));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/like")
	public ResponseEntity<?> insertcmntlike(@ModelAttribute MovieReviewCommentLike moviereviewcommentlike) {
		return ResponseEntity.ok(service.insertcmntlike(moviereviewcommentlike));
	}
	
	
}
