package com.icia.moviefactory.controller.rest;

import java.security.*;

import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

@RequestMapping("/collection")
@RestController
public class CollectionController {
	@Autowired
	private CollectionService service;
	@PostMapping("/add")
	public ResponseEntity<?> add(@Valid Collection collection, BindingResult results, Principal principal) {
		collection.setUsername(principal.getName());
		return ResponseEntity.ok(service.add(collection));
	}
	@GetMapping("/read")
	public ResponseEntity<?> read(long collNo) {
		return ResponseEntity.ok(service.read(collNo));		
	}
	@PostMapping("/addmovie")
	public ResponseEntity<?> addmovie(long mNo, long collNo, Principal principal) {
		return ResponseEntity.ok(service.addmovie(mNo, collNo, principal.getName()));
	}
	@PostMapping("/update")
	public ResponseEntity<?> update(@Valid Collection collection, BindingResult results, Principal principal) {
		collection.setUsername(principal.getName());
		return ResponseEntity.ok(service.update(collection));
	}
	@PostMapping("/deletemovie")
	public ResponseEntity<?> deletemovie(long mNo, long collNo, Principal principal) {
		return ResponseEntity.ok(service.deletemovie(mNo, collNo, principal.getName()));
	}
	@PostMapping("/delete")
	public ResponseEntity<?> delete(long collNo, Principal principal) {
		return ResponseEntity.ok(service.delete(collNo, principal.getName()));
	}
	@PostMapping("/like")
	public ResponseEntity<?> like(long collNo, Principal principal) {
		return ResponseEntity.ok(service.like(new CollectionLike(0, collNo, principal.getName(), null)));
	}
	@PostMapping("/cancellike")
	public ResponseEntity<?> cancelLike(long collNo, Principal principal) {
		return ResponseEntity.ok(service.cancelLike(new CollectionLike(0, collNo, principal.getName(), null)));
	}
	@GetMapping("/list")
	public ResponseEntity<?> movieCollectionList(long mNo) {
		return ResponseEntity.ok(service.movieCollectionList(mNo));		
	}
	@GetMapping("/mylist")
	public ResponseEntity<?> usernameCollectionList(Principal principal) {
		return ResponseEntity.ok(service.usernameCollectionList(principal.getName()));		
	}
}
