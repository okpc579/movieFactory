package com.icia.moviefactory.restcontroller;

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
	
	@GetMapping("/enabledlist")
	public ResponseEntity<?> findAllEnabledList(int pageno) {
		return ResponseEntity.ok(service.findAllEnabledList(pageno));
	}
	
	@GetMapping("/findrevblind")
	public ResponseEntity<?> findRevBlind(int pageno) {
		return ResponseEntity.ok(service.findRevBlind(pageno));
	}
	// 내용으로 검색한 리뷰 블라인드
	@GetMapping("/searchbycontentrevblind")
	public ResponseEntity<?> searchByContentRevBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByContentRevBlind(pageno,search));
	}
	// 아이디로 검색한 리뷰 블라인드
	@GetMapping("/searchbyusernamerevblind")
	public ResponseEntity<?> searchByUsernameRevBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameRevBlind(pageno,search));
	}
	
	// 내용으로 검색한 블라인드된 댓글
	@GetMapping("/searchbycontentcmntblind")
	public ResponseEntity<?> searchByContentCmntBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByContentCmntBlind(pageno,search));
	}
	
	// 아이디로 검색한 블라인드된 댓글
	@GetMapping("/searchbyusernamecmntblind")
	public ResponseEntity<?> searchByUsernameCmntBlind(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameCmntBlind(pageno,search));
	}
	
	// 아이디로 검색한 블락목록
	@GetMapping("/searchbyusernameenabledlist")
	public ResponseEntity<?> searchByUsernameEnabledList(int pageno, String search) {
		return ResponseEntity.ok(service.searchByUsernameEnabledList(pageno,search));
	}
	
	@GetMapping("/findcmntblind")
	public ResponseEntity<?> findRevCmntBlind(int pageno) {
		return ResponseEntity.ok(service.findRevCmntBlind(pageno));
	}
	
	@GetMapping("/read/blind/review")
	public ResponseEntity<?> readRevBlind(long mRevNo) {
		return ResponseEntity.ok(service.readRevBlind(mRevNo));
	}
	
	@GetMapping("/read/blind/comment")
	public ResponseEntity<?> readRevCmntBlind(long mRevCmntNo) {
		System.out.println("readRevCmntBlind");
		return ResponseEntity.ok(service.readRevCmntBlind(mRevCmntNo));
	}
	
	@PostMapping("/update/block")
	public ResponseEntity<?> updateblock(String username) {
		return ResponseEntity.ok(service.updateEnabled(username));
	}
	
	@PostMapping("/update/blind/review")
	public ResponseEntity<?> updateRevBlind(long mRevNo) {
		return ResponseEntity.ok(service.updateRevBlind(mRevNo));
	}
	
	@PostMapping("/update/blind/comment")
	public ResponseEntity<?> updateCmntBlind(@Valid long mRevCmntNo) {
		return ResponseEntity.ok(service.updateCmntBlind(mRevCmntNo));
	}
	
	@GetMapping("/findrevblindbyuser")
	public ResponseEntity<?> findRevBlindByUser(String username) {
		return ResponseEntity.ok(service.findRevBlindByUser(username));
	}
	
	@GetMapping("/findcmntblindbyuser")
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
