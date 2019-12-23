package com.icia.moviefactory.controller.rest;

import java.security.*;

import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;


@RequestMapping("/api/collection")
@RestController
public class CollectionController {
   @Autowired
   private CollectionService service;
   
   @PostMapping("/add")
   public ResponseEntity<?> add(@Valid Collection collection, BindingResult results, Principal principal) {
      collection.setUsername(principal.getName());
      return ResponseEntity.ok(service.add(collection).getCollNo());
   }
   
   @ResponseBody
   @GetMapping("/read")
   public ResponseEntity<?> read(long collNo, int pageno) {
	   System.out.println("read에 들어옴");
      return ResponseEntity.ok(service.read(collNo, pageno));      
   }
   @GetMapping("/read/{collNo}")
   public ResponseEntity<?> read3(@PathVariable long collNo) {
      return ResponseEntity.ok(service.read3(collNo));      
   }
   
   @PostMapping("/addmovie")
   public ResponseEntity<?> addmovie(long mNo, String collNo, Principal principal) {
      
      return ResponseEntity.ok(service.addmovie(mNo, Long.parseLong(collNo), principal.getName()));
      
   }
   
   @PostMapping("/update")
   public ResponseEntity<?> update(@Valid Collection collection, BindingResult results, Principal principal) {
      collection.setUsername(principal.getName());
      return ResponseEntity.ok(service.update(collection).getCollNo());
   }
   
   @PostMapping("/deletemovie")
   public ResponseEntity<?> deletemovie(long mNo, long collNo, Principal principal) {
      return ResponseEntity.ok(service.deletemovie(mNo, collNo, principal.getName()));
   }
   
   @PostMapping("/delete")
   public ResponseEntity<?> delete(long collNo, Principal principal) {
      return ResponseEntity.ok(service.delete(collNo, principal.getName()));
   }

   @GetMapping("/checklike")
   public ResponseEntity<?> checklike(long collNo, Principal principal) {
      return ResponseEntity.ok(service.checklike(collNo, principal.getName()));
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
   public ResponseEntity<?> movieCollectionList(long mNo, @RequestParam(defaultValue="1") int pageno) {
      return ResponseEntity.ok(service.movieCollectionList(mNo, pageno));
   }

   @GetMapping("/userlist")
   public ResponseEntity<?> usernameCollectionList(String username, int pageno) {
      return ResponseEntity.ok(service.usernameCollectionList(username, pageno));      
   }
   
   @GetMapping("/username")
   public ResponseEntity<?> username(Principal principal){
	   System.out.println("===================");
	   System.out.println(principal.getName());
	   return ResponseEntity.ok(principal.getName());
   }
   
   @GetMapping("/collposter")
   public ResponseEntity<?> read2(long collNo) {
      return ResponseEntity.ok(service.read2(collNo));      
   }
   
}