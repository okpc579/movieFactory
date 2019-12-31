package com.icia.moviefactory.controller.rest;

import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api/usermovie")
@RestController
public class UserMovieRestController {
	@Autowired
	private UserMovieService service;

	// 4. 유저리뷰 목록보기
	@GetMapping("/review")
	public ResponseEntity<?> reviewlist(String username, @RequestParam(defaultValue = "1") int pageno) {
		return ResponseEntity.ok(service.findUserReview(username, pageno));
	}
	
	@GetMapping("/checkfollowing")
	public ResponseEntity<?> checkfollowing(Principal principal, String username) {
		return ResponseEntity.ok(service.checkfollowing(username, principal.getName()));		
	}
	
	// 5. 팔로잉 목록보기
	@GetMapping("/following")
	public ResponseEntity<?> followinglist(Principal principal, String username) {
		return ResponseEntity.ok(service.findFollowing(username));		
	}
	
	// 6. 팔로워 목록보기
	@GetMapping("/follower")
	public ResponseEntity<?> followerlist(Principal principal, String username) {
		return ResponseEntity.ok(service.findFollower(username));
	}
	
	@PostMapping("/addfollowing")
	public ResponseEntity<?> addfollowing(String username ,Principal principal) {
		return ResponseEntity.ok(service.addfollowing(username,principal.getName()));
	}
	@PostMapping("/deletefollowing")
	public ResponseEntity<?> deletefollowing(String username ,Principal principal) {
		return ResponseEntity.ok(service.deletefollowing(username,principal.getName()));
	}
	// 7. 평점상위 보기
	@GetMapping("/averagerating")
	public ResponseEntity<?> averagerating(Principal principal) {
		return ResponseEntity.ok(service.findAverageRating());		
	}
	
	// 8. 유저 고평점 상위보기
	@GetMapping("/usertoprating")
	public ResponseEntity<?> usertoprating(String username) {
		return ResponseEntity.ok(service.findUserTopRating(username));		
	}
	
	// 9. 장르별 평점 상위 보기
	@GetMapping("/genretoprating")
	public ResponseEntity<?> genretoprating(Principal principal, String genre) {
		return ResponseEntity.ok(service.findGenretoprating(genre));		
	}
	
	// 10. 좋아하는 영화 추가
	@PostMapping("/addfavoritemovie")
	public ResponseEntity<?> insertfavoritemovie(Long mNo,Principal principal){
		return ResponseEntity.ok(service.insertFavoriteMovie(mNo, principal.getName()));
	}
	
	// 11. 좋아하는 영화 삭제
	@PostMapping("/deletefavoritemovie")
	public ResponseEntity<?> deletefavoritemovie(Long mNo ,Principal principal) {
		return ResponseEntity.ok(service.deleteFavoriteMovie(mNo,principal.getName()));
	}
	
	// db에 좋아요한 영화 있는 지 확인
	@GetMapping("/checkfavoritemovie")
	public ResponseEntity<?> checkfavoritemovie(Long mNo, Principal principal){
		return ResponseEntity.ok(service.checkFavoriteMovie(mNo,principal.getName()));
	}
	
	// 12. 좋아하는 영화 목록 보기
	@GetMapping("/favoritemovie")
	public ResponseEntity<?> readfavoritemovie(String username) {
		return ResponseEntity.ok(service.favoriteMovie(username));
	}
	
	@GetMapping(path = "/findnickname", produces ="application/text; charset=utf8")
	public ResponseEntity<?> findNickname(String username) {
		return ResponseEntity.ok(service.findNickname(username));		
	}
	
	@GetMapping("/checkmyname")
	public ResponseEntity<?> checkmyname(String username, Principal principal) {
		return ResponseEntity.ok(username.equals(principal.getName())==true?"true":"false");		
	}
	
	@GetMapping("/preferencemovie")
	public ResponseEntity<?> findPreferenceMovie(String username) {
		return ResponseEntity.ok(service.findPreferenceMovie(username));		
	}
}
