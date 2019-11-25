package com.icia.moviefactory.restcontroller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/api")
@RestController
public class AdminRestController {
	@Autowired
	private AdminService service;
	
	@GetMapping("/admin/blocklist")
	public ResponseEntity<?> findAllBlockList() {
		//return ResponseEntity.ok(service.findAllBlockList());
		return null;
	}
	
	@GetMapping("/admin/readblock")
	public ResponseEntity<?> readBlock() {
		//return ResponseEntity.ok(service.readBlock());
		return null;
	}
	
	@PostMapping("/admin/updateblock")
	public ResponseEntity<?> updateBlock() {
		//return ResponseEntity.ok(service.updateBlock());
		return null;
	}
	
	@GetMapping("/admin/blindlist")
	public ResponseEntity<?> findAllBlindList() {
		//return ResponseEntity.ok(service.findAllBlindList());
		return null;
	}
	
	@GetMapping("/admin/readblind")
	public ResponseEntity<?> readBlind() {
		//return ResponseEntity.ok(service.readBlind());
		return null;
	}
	
	@PostMapping("/admin/blind")
	public ResponseEntity<?> updateblind() {
		//return ResponseEntity.ok(service.updateblind());
		return null;
	}
	
}
