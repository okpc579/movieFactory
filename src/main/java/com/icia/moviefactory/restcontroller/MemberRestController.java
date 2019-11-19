package com.icia.moviefactory.restcontroller;

import java.io.*;
import java.net.*;
import java.security.*;

import javax.servlet.http.*;
import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.lang.*;
import org.springframework.security.access.prepost.*;
import org.springframework.validation.*;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.service.*;

import io.swagger.annotations.*;
import lombok.NonNull;

@RequestMapping("/api")
@RestController
public class MemberRestController {
	@Autowired
	private MemberService service;
	@Value("#{config['spring.baseUri']}")
	private String baseUri;
	
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "1. 아이디 사용가능 확인", notes = "아이디를 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"), @ApiResponse(code = 409, message= "사용중인 아이디입니다") })
	@ApiImplicitParams({ @ApiImplicitParam(name = "username", value = "사용희망하는 아이디", required = true, dataType = "string", paramType = "path") })
	@GetMapping(path="/member/{username}", produces="text/plain;charset=utf-8")
	public ResponseEntity<String> idAvailable(@PathVariable String username) {
		return ResponseEntity.ok(service.idAvailable(username));
	}
	
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "2. 닉네임 사용가능 확인", notes = "닉네임을 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"), @ApiResponse(code = 409, message= "사용중인 닉네임입니다") })
	@ApiImplicitParams({ @ApiImplicitParam(name = "nick", value = "사용희망하는 닉네임", required = true, dataType = "string", paramType = "path") })
	@GetMapping(path="/member/nick", produces="text/plain;charset=utf-8")
	public ResponseEntity<String> nickAvailable(@PathVariable String nick) {
		return ResponseEntity.ok(service.nickAvailable(nick));
	}
	
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "3. 이메일 사용가능 확인", notes = "이메일을 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"), @ApiResponse(code = 409, message= "사용중인 이메일입니다") })
	@ApiImplicitParams({ @ApiImplicitParam(name = "email", value = "사용희망하는 이메일", required = true, dataType = "string", paramType = "query") })
	@GetMapping(path="/member/email", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> emailAvailable(@NonNull String email) {
		return ResponseEntity.ok(service.emailAvailable(email));
	}
	
	
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "3. 회원 가입", notes = "회원 가입 처리")
	@ApiResponses({ @ApiResponse(code = 200, response = Member.class, message = "회원가입한 사용자 정보") })
	@ApiImplicitParams({
		@ApiImplicitParam(name = "username", value = "아이디", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "password", value = "비밀번호", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "name", value = "이름", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "nick", value = "닉네임", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "email", value = "이메일", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "zipCode", value = "우편번호", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "baseAddr", value = "주소", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "tel", value = "핸드폰번호", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "birth", value = "생년월일", required = true, dataTypeClass = String.class),
		@ApiImplicitParam(name = "photo", value = "프로필 사진", required = false, dataTypeClass = MultipartFile.class),
		@ApiImplicitParam(name = "intro", value = "한줄소개", required = true, dataTypeClass = String.class),
	})
	@PostMapping(path="/member/join", produces="application/json;charset=utf-8")
	public ResponseEntity<?> join(@ModelAttribute @Valid Member member, BindingResult results, @Nullable MultipartFile sajin) throws BindException, IOException {
		if(results.hasErrors())
			throw new BindException(results);
		System.out.println(member);
		URI location = UriComponentsBuilder.newInstance().path("/moviefactory/member/login").build().toUri();
		return ResponseEntity.created(location).body(service.insert(member, sajin));
	}
	
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "6. 비밀번호 확인", notes = "로그인한 사용자가 자신의 정보를 보려고 할 때 비밀번호가 맞는 지 확인")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"), @ApiResponse(code = 409, message= "비밀번호를 확인하지 못했습니다") })
	@ApiImplicitParams({ @ApiImplicitParam(name = "password", value = "비밀번호", required = true, dataType = "string", paramType = "query") })
	@GetMapping(path="/member/username/password", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> checkpassword(Principal principal, @NonNull String password, HttpSession session) {
		String result = service.checkpassword(principal.getName(), password);
		session.setAttribute("pwdCheck", "true");
		return ResponseEntity.ok(result);
	}
	
}
