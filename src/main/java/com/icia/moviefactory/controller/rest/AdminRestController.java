package com.icia.moviefactory.controller.rest;

import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class AdminRestController {
	@Autowired
	private AdminService service;
	
	@GetMapping("/block/list")
	public ResponseEntity<?> findAllEnabledList(int pageno) {
		return ResponseEntity.ok(service.findAllEnabledList(pageno));
	}
	
	@GetMapping("/blind/reviewlist")
	public ResponseEntity<?> findRevBlind(int pageno) {
		return ResponseEntity.ok(service.findRevBlind(pageno));
	}
	// 내용으로 검색한 리뷰 블라인드
	@GetMapping("/blind/search/reviewbycontent")
	public ResponseEntity<?> searchByContentRevBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByContentRevBlind(pageno,search));
	}
	// 아이디로 검색한 리뷰 블라인드
	@GetMapping("/blind/search/reviewbyusername")
	public ResponseEntity<?> searchByUsernameRevBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameRevBlind(pageno,search));
	}
	
	// 내용으로 검색한 블라인드된 댓글
	@GetMapping("/blind/search/commentbycontent")
	public ResponseEntity<?> searchByContentCmntBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByContentCmntBlind(pageno,search));
	}
	
	// 아이디로 검색한 블라인드된 댓글
	@GetMapping("/blind/search/commentbyusername")
	public ResponseEntity<?> searchByUsernameCmntBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameCmntBlind(pageno,search));
	}
	
	// 아이디로 검색한 블락목록
	@GetMapping("block/search/listbyusername")
	public ResponseEntity<?> searchByUsernameEnabledList(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameEnabledList(pageno,search));
	}
	
	@GetMapping("/blind/findcomment")
	public ResponseEntity<?> findRevCmntBlind(int pageno) {
		return ResponseEntity.ok(service.findRevCmntBlind(pageno));
	}
	
	@GetMapping("/blind/readreview")
	public ResponseEntity<?> readRevBlind(long mRevNo) {
		return ResponseEntity.ok(service.readRevBlind(mRevNo));
	}
	
	@GetMapping("/blind/readcomment")
	public ResponseEntity<?> readRevCmntBlind(long mRevCmntNo) {
		System.out.println("readRevCmntBlind");
		return ResponseEntity.ok(service.readRevCmntBlind(mRevCmntNo));
	}
	
	@PostMapping("/block/update")
	public ResponseEntity<?> updateblock(String username) {
		return ResponseEntity.ok(service.updateEnabled(username));
	}
	
	@PostMapping("/blind/updatereview")
	public ResponseEntity<?> updateRevBlind(long mRevNo) {
		return ResponseEntity.ok(service.updateRevBlind(mRevNo));
	}
	
	@PostMapping("/blind/updatecomment")
	public ResponseEntity<?> updateCmntBlind(@Valid long mRevCmntNo) {
		return ResponseEntity.ok(service.updateCmntBlind(mRevCmntNo));
	}
	
	@GetMapping("/blind/findreviewbyuser")
	public ResponseEntity<?> findRevBlindByUser(String username) {
		return ResponseEntity.ok(service.findRevBlindByUser(username));
	}
	
	@GetMapping("/blind/findcommentbyuser")
	public ResponseEntity<?> findRevCmntBlindByUser(String username) {
		return ResponseEntity.ok(service.findRevCmntBlindByUser(username));
	}
	
	@PostMapping("/reviewblind")
	public ResponseEntity<?> reviewBlind(long mRevNo, String username) {
		return ResponseEntity.ok(service.reviewBlind(mRevNo, username));
	}
	
	@PostMapping("/commentBlind")
	public ResponseEntity<?> commentBlind(long mRevCmntNo, String username) {
		return ResponseEntity.ok(service.commentBlind(mRevCmntNo, username));
	}
	
	@PostMapping("/userBlock")
	public ResponseEntity<?> userBlock(String username) {
		return ResponseEntity.ok(service.userBlock(username));
	}
}
