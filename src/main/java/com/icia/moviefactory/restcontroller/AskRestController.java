package com.icia.moviefactory.restcontroller;

import java.net.URI;
import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.icia.moviefactory.entity.AdminAsk;
import com.icia.moviefactory.service.AskService;

@RequestMapping("/api")
@RestController
public class AskRestController {
	@Autowired
	private AskService service;
	
	// 유저의 목록 가져오기
	@GetMapping("/adminAsks")
	public ResponseEntity<?> findAllAdminAskByUsername(@RequestParam(defaultValue="1") int pageno, @RequestParam(required = false) String username) {
		return ResponseEntity.ok(service.findAllAdminAskByUsername(pageno, username));
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
	@PutMapping("/ask/update")
	public ResponseEntity<?> updateAdminAsk(@Valid AdminAsk adminask, BindingResult results, Principal principal) {
		return ResponseEntity.ok(service.updateAdminAsk(adminask, principal.getName()));
	}
	
	// 글 삭제: 글을 삭제하려는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@Secured("ROLE_USER")
	@DeleteMapping("/ask/{admin_ask_no}")
	public ResponseEntity<?> deleteAdminAsk(@PathVariable long adminAskNo, Principal principal) {
		return ResponseEntity.ok(service.deleteAdminAsk(adminAskNo, principal.getName()));
	}
}
