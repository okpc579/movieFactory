package com.icia.moviefactory.controller.rest;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class CaptchaRestController {
	@Autowired
	private CaptchaService service;
	
	@GetMapping("/captcha/key")
	public ResponseEntity<?> key() {
		return ResponseEntity.ok(service.captchaKey());
	}
	
	@GetMapping("/captcha/image")
	public ResponseEntity<?> image(String key, String value) {
		return ResponseEntity.ok(service.captchaImage(key, value));
	}
	
}
