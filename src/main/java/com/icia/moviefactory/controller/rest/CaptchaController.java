package com.icia.moviefactory.controller.rest;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class CaptchaController {
	@Autowired
	private CaptchaService service;
	
	@GetMapping("/captcha/key")
	public ResponseEntity<?> key() {
		return ResponseEntity.ok(service.captchaKey());
	}
	
	@GetMapping("/captcha/image")
	public ResponseEntity<?> image(String key, String value) {
		System.out.println("controller 내려옴");
		System.out.println(key);
		System.out.println(value);
		return ResponseEntity.ok(service.captchaImage(key, value));
	}
	
}
