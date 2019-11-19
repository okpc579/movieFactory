package com.icia.moviefactory.restcontroller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.prepost.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

import lombok.*;

@RestController("/")
public class MemberRestController {
	@Autowired
	private MemberService service;
	
	// 아이디 찾기 -> MemberNotFoundException
	@PreAuthorize("isAnonymous()")
	@GetMapping(path="/members/username",produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> findId(@NonNull String email, @RequestParam String name) {
		return ResponseEntity.ok(service.findId(email,name));
	}
	
	// 비밀번호 찾기 -> MemberNotFoundException
	@PreAuthorize("isAnonymous()")
	@PatchMapping(path="/members/user/{username}",produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> resetPassword(@PathVariable String username, @RequestParam String email, @RequestParam String name) {
		return ResponseEntity.ok(service.findPassword(username, email,name));
	}
}
