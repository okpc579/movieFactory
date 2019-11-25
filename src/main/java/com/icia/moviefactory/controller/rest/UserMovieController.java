package com.icia.moviefactory.controller.rest;

import java.security.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.service.*;

@RequestMapping("/usermovie")
@RestController
public class UserMovieController {
	@Autowired
	private UserMovieService service;

	@GetMapping("/usermovie/read")
	public ResponseEntity<?> read(long collNo) {
		return ResponseEntity.ok(service.read(collNo));		
	}
	
//	@PostMapping("/addmovie")
//	public ResponseEntity<?> addmovie(long mNo, long collNo, Principal principal) {
//		return ResponseEntity.ok(service.addmovie(mNo, collNo, principal.getName()));
//	}
	
//	@GetMapping("/usermovie/favorite")
//	public ResponseEntity<?> favorite(BindingResult results, Principal principal) {
//		usermovie.setUsername(principal.getName());
//		return ResponseEntity.ok(service.add(usermovie));
//	}
	
	@GetMapping("/following")
	public ResponseEntity<?> findFollowingList(Principal principal, String followingUsername) {
		return ResponseEntity.ok(service.findFollowingList(principal.getName(), followingUsername));		
	}
	
	@GetMapping("/follower")
	public ResponseEntity<?> findFollowerList(Principal principal, String followerUsername) {
		return ResponseEntity.ok(service.findFollowerList(principal.getName(), followerUsername));		
	}
}
