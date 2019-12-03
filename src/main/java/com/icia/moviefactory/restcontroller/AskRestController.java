package com.icia.moviefactory.restcontroller;

import java.net.*;
import java.security.*;

import javax.servlet.http.*;
import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.security.access.annotation.*;
import org.springframework.validation.*;
import org.springframework.validation.BindException;
<<<<<<< HEAD
<<<<<<< HEAD
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.*;
=======
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;
>>>>>>> 20191126_박동민똥멍청이지각3대장
=======
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.*;
>>>>>>> dongdong

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class AskRestController {
	@Autowired
	private AskService service;
	
<<<<<<< HEAD
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
=======
	// 유저의 목록 가져오기
	@GetMapping("/adminAsks")
	public ResponseEntity<?> findAllAdminAskByUsername(@RequestParam(defaultValue="1") int pageno, @RequestParam(required = false) String username) {
		return ResponseEntity.ok(service.findAllAdminAskByUsername(pageno, username));
>>>>>>> dongdong
	}

	// 글 쓰기
	@Secured("ROLE_USER")
	@PostMapping("/adminAsks")
	public ResponseEntity<?> writeAdminAsk(@Valid AdminAsk adminAsk, BindingResult results, Principal principal, HttpServletRequest req) throws BindException {
		if(results.hasErrors())
			// 오류처리
			throw new BindException(results);
		// 글작성
		AdminAsk result = service.writeAdminAsk(adminAsk);
		// 이동 url 생성
		URI location = UriComponentsBuilder.newInstance().path("moviefactory/api/adminAsks").path(result.getAdminAskNo()+"").build().toUri();
		// 생성된 url로 이동
		return ResponseEntity.created(location).body(result.getAdminAskNo()); 
	}  
	

	// 글 변경 : 글을 변경하려는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@Secured("ROLE_USER")
	@PostMapping("/adminAsk/update")
	public ResponseEntity<?> updateAdminAsk(long adminAskNo,String content, Principal principal) {
		System.out.println(adminAskNo);
		System.out.println(content);
		return ResponseEntity.ok(service.updateAdminAsk(adminAskNo,content, principal.getName()));
	}

	
	// 글 삭제: 글을 삭제하려는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@Secured("ROLE_USER")
	@DeleteMapping("/adminAsk/{admin_ask_no}")
	public ResponseEntity<?> deleteAdminAsk(long adminAskNo, Principal principal) {
		return ResponseEntity.ok(service.deleteAdminAsk(adminAskNo, principal.getName()));
	}
	
	// 관리자가 글 하나 읽기: 게시판에서 글제목을 눌러 글을 읽을때
	@GetMapping("/adminAsk/read")
	public ResponseEntity<?> readAdminAsk(long adminAskNo, Principal principal){
		return ResponseEntity.ok(service.readAdminAsk(adminAskNo, principal.getName()));
	}
	
	// 관리자가 답변글 작성하기(변경)
	@Secured("ROLE_ADMIN")
	@PostMapping("/adminAsk/askAnswer")
	public ResponseEntity<?> askAnswer(AdminAsk adminAsk){
		System.out.println(adminAsk+"왓냐!?");
		return ResponseEntity.ok(service.askAnswer(adminAsk));
	}
}
