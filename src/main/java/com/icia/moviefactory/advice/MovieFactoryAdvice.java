package com.icia.moviefactory.advice;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.exception.*;

@RestControllerAdvice
public class MovieFactoryAdvice {
	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "text/plain;charset=utf-8");
		return headers;
	}
	
	@ExceptionHandler(MemberNotFoundException.class)
	public ResponseEntity<?> MemberNotFoundExceptionHandler() {
		return new ResponseEntity<String>("사용자를 찾을 수 없습니다", getHeaders(), HttpStatus.CONFLICT);
	}
}
