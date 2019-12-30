package com.icia.moviefactory.controller.rest;

import java.net.URI;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.icia.moviefactory.entity.Notice;
import com.icia.moviefactory.service.NoticeService;

@RequestMapping("/api")
@RestController
public class NoticeRestController {
	@Autowired
	private NoticeService service;

	// 관리자 전체공지글 가져오기
	@GetMapping("/notice/list")
	public ResponseEntity<?> findAllNotice(@RequestParam(defaultValue = "1") int pageno) {
		return ResponseEntity.ok(service.findAll(pageno));
	}

	// 관리자가 공지글 쓰기
	@Secured("ROLE_ADMIN")
	@PostMapping("/notice/write")
	public ResponseEntity<?> writeNotice(@Valid Notice notice, BindingResult results, Principal principal,HttpServletRequest req) throws BindException {
		if (results.hasErrors())
			// 오류처리
			throw new BindException(results);
		// 글작성
		Notice result = service.writeNotice(notice);
		// 이동 url 생성
		URI location = UriComponentsBuilder.newInstance().path("moviefactory/notices/list").path(result.getNoticeNo()+"").build().toUri();
		// 생성된 url로 이동
		return ResponseEntity.created(location).body(result.getNoticeNo());
	}

	// 글 변경 : 글을 변경하려는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@Secured("ROLE_ADMIN")
	@PostMapping("/notice/update")
	public ResponseEntity<?> updateNotice(long noticeNo, String content, Principal principal) {
		return ResponseEntity.ok(service.updateNotice(noticeNo, content, principal.getName()));
	}

	// 글 삭제: 글을 삭제하려는 사람이 글쓴 사람인지 여부를 확인하기 위해 principal 필요
	@Secured("ROLE_ADMIN")
	@DeleteMapping("/notice/{notice_no}")
	public ResponseEntity<?> deleteNotice(long noticeNo, Principal principal) {
		return ResponseEntity.ok(service.deleteNotice(noticeNo, principal.getName()));
	}

	// 글 하나 읽기
	@GetMapping("/notice/read")
	public ResponseEntity<?> readNotice(long noticeNo) {
		return ResponseEntity.ok(service.readNotice(noticeNo));
	}
	// 제목 검색 문의 목록 가져오기
	@GetMapping("/notice/searchlisttitle")		
	public ResponseEntity<?> findAllNoticeByTitle(@RequestParam(defaultValue="1") int pageno, String title) {
	return ResponseEntity.ok(service.findNoticeBySearchTitle(pageno, title));
	}
}
