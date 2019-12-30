package com.icia.moviefactory.controller.rest;

import java.net.*;
import java.security.*;

import javax.servlet.http.*;
import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.annotation.*;
import org.springframework.validation.*;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class AskRestController {
	@Autowired
	private AskService service;
	
	// 관리자가 전체문의글 가져오기
	@Secured("ROLE_ADMIN")
	@GetMapping("/adminAsk/list")
	public ResponseEntity<?> findAllAdminAsk(@RequestParam(defaultValue = "1") int pageno, Principal username){
		return ResponseEntity.ok(service.findAll(pageno, username.getName()));
	}
	
	// 유저자신의 문의 목록 가져오기
	@Secured("ROLE_USER")
	@GetMapping("/adminAsk/listuser")
	public ResponseEntity<?> findAllAdminAskByUsername(@RequestParam(defaultValue="1") int pageno, Principal username) {	// principal을 주어 로그인확인함
		return ResponseEntity.ok(service.findAllAdminAskByUsername(pageno, username.getName()));
	}


	// 글 쓰기
	@Secured("ROLE_USER")
	@PostMapping("/adminAsk/write")
	public ResponseEntity<?> writeAdminAsk(@Valid AdminAsk adminAsk, BindingResult results, Principal principal, HttpServletRequest req) throws BindException {
		adminAsk.setUsername(principal.getName());
		if(results.hasErrors())
			// 오류처리
			throw new BindException(results);
		// 글작성
		AdminAsk result = service.writeAdminAsk(adminAsk);
		// 이동 url 생성
		URI location = UriComponentsBuilder.newInstance().path("moviefactory/adminAsks/list").path(result.getAdminAskNo()+"").build().toUri();
		// 생성된 url로 이동
		return ResponseEntity.created(location).body(result.getAdminAskNo()); 
	}  
	

	// 글 변경
	@Secured("ROLE_USER")
	@PostMapping("/adminAsk/update")
	public ResponseEntity<?> updateAdminAsk(long adminAskNo,String content, Principal principal) {
		return ResponseEntity.ok(service.updateAdminAsk(adminAskNo,content, principal.getName()));
	}

	
	// 글 삭제
	@Secured("ROLE_USER")
	@DeleteMapping("/adminAsk/{admin_ask_no}")
	public ResponseEntity<?> deleteAdminAsk(long adminAskNo, Principal principal) {
		return ResponseEntity.ok(service.deleteAdminAsk(adminAskNo, principal.getName()));
	}
	
	// 글 읽기
	@GetMapping("/adminAsk/read")
	public ResponseEntity<?> readAdminAsk(long adminAskNo, Principal principal){
		return ResponseEntity.ok(service.readAdminAsk(adminAskNo, principal.getName()));
	}
	
	// 관리자가 답변글 작성하기(변경)
	@Secured("ROLE_ADMIN")
	@PostMapping("/adminAsk/askAnswer")
	public ResponseEntity<?> askAnswer(AdminAsk adminAsk){
		return ResponseEntity.ok(service.askAnswer(adminAsk));
	}
	
	// 아이디 검색 문의 목록 가져오기
	@GetMapping("/adminAsk/searchlist")		
	public ResponseEntity<?> findAllAdminAskByUsername(@RequestParam(defaultValue="1") int pageno, String username) {
	return ResponseEntity.ok(service.findAdminAskBySearchUsername(pageno, username));
	}
	
	// 제목 검색 문의 목록 가져오기
	@GetMapping("/adminAsk/searchlisttitle")		
	public ResponseEntity<?> findAllAdminAskByTitle(@RequestParam(defaultValue="1") int pageno, String title) {
	return ResponseEntity.ok(service.findAdminAskBySearchTitle(pageno, title));
	}
	
	// 문의상태
	@PostMapping("/adminAsk/answering")
	public ResponseEntity<?> answering(long adminAskNo){
		return ResponseEntity.ok(service.answering(adminAskNo));
	}
	
	// 로그인한 아이디 확인하기
	@GetMapping("/adminAsk/checkusername")
	public ResponseEntity<?> username(Principal principal, long adminAskNo){
		return ResponseEntity.ok(service.checkusername(principal.getName(), adminAskNo));
	}
}
