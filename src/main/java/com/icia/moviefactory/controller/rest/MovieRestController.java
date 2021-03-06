package com.icia.moviefactory.controller.rest;

import java.net.*;
import java.security.*;
import java.util.*;

import javax.servlet.http.*;
import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.lang.*;
import org.springframework.security.access.prepost.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class MovieRestController {
	@Autowired
	private MovieService service;
	@Autowired
	private KMovieService kservice;
	@Autowired
	private NMovieService nservice;

	@GetMapping("/movie/review/list")
	public ResponseEntity<?> findAllBoardByWriter(@RequestParam(defaultValue = "1") int pageno,
			@RequestParam(required = false) String username, long mno) {
		return ResponseEntity.ok(service.findAllReviewByUsername(pageno, username, mno));
	}

	@GetMapping("/movie/review/list/{mNo}")
	public ResponseEntity<?> reviewlist(@RequestParam(defaultValue = "1") int pageno, @PathVariable long mno,
			Principal principal) {
		String username = principal != null ? principal.getName() : null;
		return ResponseEntity.ok(service.reviewList(pageno, username, mno));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping(path = "/movie/review/write", produces = "application/json")
	public ResponseEntity<?> insertrev(@Valid MovieReview moviereview, BindingResult results, Principal principal,
			HttpServletRequest req) {
		moviereview.setUsername(principal.getName());
		MovieReview result = service.insertrev(moviereview, moviereview.getMNo(), principal.getName());
		URI location = UriComponentsBuilder.newInstance().path("/moviefactory/api/movie/review/write")
				.path(result.getMRevNo() + "").build().toUri();
		moviereview.setWritingDate(new Date());
		moviereview.setMRevNo(result.getMRevNo());
		return ResponseEntity.created(location).body(result.getMRevNo());
	}

	// board-4. 글 읽기 : 글을 읽는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@GetMapping("/movie/review/read/{mRevNo}")
	public ResponseEntity<?> readBoard(@PathVariable Long mRevNo, Principal principal) {
		// 로그인하지 않아도 글을 읽을 수 있다. username은 로그인하지 않은 경우 null이 된다
		String username = principal != null ? principal.getName() : null;
		System.out.println(service.findReviewByIdWithComments(mRevNo, username));
		service.findComment(mRevNo, username);
		return ResponseEntity.ok(service.findReviewByIdWithComments(mRevNo, username));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/review/readupdate")
	public ResponseEntity<?> updatetreadrev(@Valid MovieReview moviereview, BindingResult result, Principal principal) {
		moviereview.setUsername(principal.getName());
		return ResponseEntity.ok(service.updatereadrev(moviereview, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/review/update")
	public ResponseEntity<?> updatetrev(@Valid MovieReview moviereview, BindingResult result, Principal principal) {
		moviereview.setUsername(principal.getName());
		return ResponseEntity.ok(service.updaterev(moviereview, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/movie/review/delete/{mRevNo}")
	public ResponseEntity<?> deleterev(@PathVariable long mRevNo, Principal principal) {
		return ResponseEntity.ok(service.deleterev(mRevNo, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/review/like")
	public ResponseEntity<?> insertrevlike(@NonNull Long mRevNo, Principal principal) {
		return ResponseEntity.ok(service.updatelikecnt(mRevNo, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/report")
	public ResponseEntity<?> report(@ModelAttribute MovieReviewReport moviereviewreport, Principal principal) {
		String username = principal.getName();
		moviereviewreport.setWritingDate(new Date());
		moviereviewreport.setUsername(username);
		moviereviewreport.setTitle(moviereviewreport.getTitle());
		return ResponseEntity.ok(service.report(moviereviewreport, username));

	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/cmntreport")
	public ResponseEntity<?> cmntReport(@ModelAttribute MovieReviewCommentReport moviereviewcommentreport,
			Principal principal) {
		String username = principal.getName();
		moviereviewcommentreport.setWritingDate(new Date());
		moviereviewcommentreport.setUsername(username);
		moviereviewcommentreport.setTitle(moviereviewcommentreport.getTitle());
		return ResponseEntity.ok(service.cmntReport(moviereviewcommentreport, username));

	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/write")
	public ResponseEntity<?> insertcmnt(@Valid MovieReviewComment moviereviewcomment, BindingResult result,
			Principal principal) {
		moviereviewcomment.setUsername(principal.getName());
		return ResponseEntity.ok(service.insertcmnt(moviereviewcomment));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/update")
	public ResponseEntity<?> updaterevcmnt(MovieReviewComment moviereviewcomment, Principal principal) {
		return ResponseEntity.ok(service.updaterevcmnt(moviereviewcomment, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movie/comment/deletebyrevno")
	public ResponseEntity<?> deleterevcmnt(@NonNull Long mRevCmntNo) {
		return ResponseEntity.ok(service.deleterevcmnt(mRevCmntNo));
	}

	@DeleteMapping("/movie/comment/deletebycmntno")
	public ResponseEntity<?> deleterevcmnt(@NonNull Long mRevCmntNo, @NonNull Long mRevNo) {
		return ResponseEntity.ok(service.deleteByCmntByMRevNo(mRevNo, mRevCmntNo));
	}

	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/comment/like")
	public ResponseEntity<?> insertcmntlike(@ModelAttribute MovieReviewCommentLike moviereviewcommentlike,
			Principal principal) {
		moviereviewcommentlike.setLikeRegDate(new Date());
		moviereviewcommentlike.setUsername(principal.getName());
		return ResponseEntity.ok(service.insertcmntlike(moviereviewcommentlike, principal.getName()));
	}

	@GetMapping("/list") // read -> list
	public ResponseEntity<?> list(String query, @RequestParam(defaultValue = "1") int page) {
		return ResponseEntity.ok(kservice.searchKMovie(query, page));
	}

	@GetMapping("/image")
	public ResponseEntity<?> readImage(@RequestParam String subtitle, @RequestParam String pubData) {
		return ResponseEntity.ok(nservice.searchNMovie(subtitle, 1, 1, pubData));
	}

	@GetMapping("/read")
	public ResponseEntity<?> read(@RequestParam String mno) {
		return ResponseEntity.ok(kservice.searchKMovieRead(mno));
	}

	@GetMapping("/movie/review/myreview")
	public ResponseEntity<?> myReview(@RequestParam Long mno, Principal principal) {
		return ResponseEntity.ok(service.myReview(mno, principal.getName()));
	}

	@GetMapping("/movie/review/checkreviewlike")
	public ResponseEntity<?> checkReviewLike(@RequestParam Long mRevNo, Principal principal) {
		return ResponseEntity.ok(service.checkReviewLike(mRevNo, principal.getName()));
	}

	@GetMapping("/movie/review/checkcmntlike")
	public ResponseEntity<?> checkCmntLike(@RequestParam Long mrevCmntNo, Principal principal) {
		return ResponseEntity.ok(service.checkCmntLike(mrevCmntNo, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/review/dontlike")
	public ResponseEntity<?> deleterevlike(@NonNull Long mRevNo, Principal principal) {
		return ResponseEntity.ok(service.deleterevlike(mRevNo, principal.getName()));
	}

	@PreAuthorize("isAuthenticated()")
	@PatchMapping("/movie/comment/dontlike")
	public ResponseEntity<?> deletecmntlike(@NonNull Long mRevCmntNo, Principal principal) {
		return ResponseEntity.ok(service.deletecmntlike(mRevCmntNo, principal.getName()));
	}

	@GetMapping("/movie/review/movieavgrating")
	public ResponseEntity<?> movieavgrating(@RequestParam Long mNo) {
		return ResponseEntity.ok(service.movieavgrating(mNo));
	}
	

}
