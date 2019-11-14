package com.icia.moviefactory.controller;

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
		//return ResponseEntity.ok(service.read(collNo));
		return null;
	}
	@PostMapping("/addmovie")
	public ResponseEntity<?> addmovie(long collNo, long movieNo) {
		//return ResponseEntity.ok(service.addmovie(collNo, movieNo));
		return null;
	}
	@PostMapping("/update")
	public ResponseEntity<?> update(@Valid Collection collection, BindingResult results, Principal principal) {
		//collection.setUsername(principal.getName());
		//return ResponseEntity.ok(service.add(collection));
		return null;
	}
	@PostMapping("/delete")
	public ResponseEntity<?> delete(@Valid Collection collection, BindingResult results, Principal principal) {
		//collection.setUsername(principal.getName());
		//return ResponseEntity.ok(service.add(collection));
		return null;
	}
	@PostMapping("/like")
	public ResponseEntity<?> like(@Valid Collection collection, BindingResult results, Principal principal) {
		//collection.setUsername(principal.getName());
		//return ResponseEntity.ok(service.add(collection));
		return null;
	}
}
