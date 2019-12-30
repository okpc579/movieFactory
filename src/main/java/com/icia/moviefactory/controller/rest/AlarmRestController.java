package com.icia.moviefactory.controller.rest;

import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api/alarm")
@RestController
public class AlarmRestController {
	@Autowired
	private AlarmService service;
	
	@GetMapping("/my")
	public ResponseEntity<?> my(Principal principal) {
		System.out.println(principal.getName());
		System.out.println(service.my(principal.getName()));
		return ResponseEntity.ok(service.my(principal.getName()));
	}
	@GetMapping("/you")
	public ResponseEntity<?> you(Principal principal) {
		System.out.println(principal.getName());
		System.out.println(service.you(principal.getName()));
		return ResponseEntity.ok(service.you(principal.getName()));
	}
}
