package com.icia.moviefactory.controller.rest;

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
import org.springframework.security.core.*;
import org.springframework.security.web.authentication.logout.*;
import org.springframework.validation.*;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.exception.*;
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

	// 아이디 찾기 -> MemberNotFoundException
	@PreAuthorize("isAnonymous()")
	@GetMapping(path = "/member/findusername", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> findId(@NonNull String email, @RequestParam String name) {
		return ResponseEntity.ok(service.findId(email, name));
	}

	// 비밀번호 찾기 -> MemberNotFoundException
	@ResponseBody
	@PreAuthorize("isAnonymous()")
	@PostMapping(path = "/member/findpassword", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> findPassword(@NonNull String username, @NonNull String email, @NonNull String name) {
		return ResponseEntity.ok(service.findPassword(username, email, name));
	}

	// 서비스 동의 YES 확인
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "서비스 동의", notes = "비로그인한 사용자가 회원가입 하기전에 서비스 동의한지 확인")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "yes를 받지 못했습니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "yes", value = "동의", required = true, dataType = "", paramType = "query") })
	@GetMapping(path = "/member/agree", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> agree(HttpSession session) {
		session.setAttribute("yes", "yes");
		return ResponseEntity.ok(null);
	}

	// 서비스 동의 YES 제거
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "서비스 동의", notes = "yes를 받은 이후 제거하기")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "yes를 제거하지 못했습니다.") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "yes", value = "동의", required = true, dataType = "", paramType = "query") })
	@PostMapping(path = "/member/clearyes", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> clearyes(HttpSession session) {
		session.removeAttribute("yes");
		return ResponseEntity.ok(null);
	}

	// 아이디 중복 체크
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "1. 아이디 사용가능 확인", notes = "아이디를 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "사용중인 아이디입니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "username", value = "사용희망하는 아이디", required = true, dataType = "string", paramType = "path") })
	@GetMapping(path = "/member/{username}", produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> idAvailable(@PathVariable String username) {
		return ResponseEntity.ok(service.idAvailable(username));
	}

	// 닉네임 중복 체크
	@ApiOperation(value = "2. 닉네임 사용가능 확인", notes = "닉네임을 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "사용중인 닉네임입니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "nick", value = "사용희망하는 닉네임", required = true, dataType = "string", paramType = "path") })
	@GetMapping(path = "/member/nick", produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> nickAvailable(@NonNull String nick) {
		return ResponseEntity.ok(service.nickAvailable(nick));
	}

	// 이메일 중복 체크
	@ApiOperation(value = "3. 이메일 사용가능 확인", notes = "이메일을 전달받아 사용가능할 경우 200 OK, 불가능할 경우 409")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "사용중인 이메일입니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "email", value = "사용희망하는 이메일", required = true, dataType = "string", paramType = "query") })
	@GetMapping(path = "/member/email", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> emailAvailable(@NonNull String email) {
		return ResponseEntity.ok(service.emailAvailable(email));
	}

	// 회원 가입
	@PreAuthorize("isAnonymous()")
	@ApiOperation(value = "4. 회원 가입", notes = "회원 가입 처리")
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
			@ApiImplicitParam(name = "intro", value = "한줄소개", required = true, dataTypeClass = String.class), })
	@PostMapping(path = "/member/join", produces = "application/json;charset=utf-8")
	public ResponseEntity<?> join(@ModelAttribute @Valid Member member, BindingResult results,
			@Nullable MultipartFile sajin) throws BindException, IOException {
		if (results.hasErrors())
			throw new BindException(results);
		URI location = UriComponentsBuilder.newInstance().path("/moviefactory/member/login").build().toUri();
		return ResponseEntity.created(location).body(service.insert(member, sajin));
	}

	// 비밀번호 확인
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "5. 비밀번호 확인", notes = "로그인한 사용자가 자신의 정보를 보려고 할 때 비밀번호가 맞는 지 확인")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용가능할 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "비밀번호를 확인하지 못했습니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "password", value = "비밀번호", required = true, dataType = "string", paramType = "query") })
	@GetMapping(path = "/member/checkpassword", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> checkpassword(Principal principal, @NonNull String password, HttpSession session) {
		String result = service.checkpassword(principal.getName(), password);
		session.setAttribute("pwdCheck", "true");
		return ResponseEntity.ok(result);
	}

	// 내 정보 보기
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "6. 내정보 보기", notes = "자신의 정보 확인. 비밀번호를 확인하지 않은 경우 409", response = Member.class)
	@ApiResponses({ @ApiResponse(code = 200, message = "내 정보", response = Member.class),
			@ApiResponse(code = 409, message = "비밀번호 확인이 필요합니다") })
	@GetMapping(path = "/member/userinfo", produces = "application/json;charset=utf-8")
	public ResponseEntity<?> userinfo(Principal principal, HttpSession session) {
		if (session.getAttribute("pwdCheck") == null) {
			throw new CheckPasswordException();
		}
		return ResponseEntity.ok(service.userinfo(principal.getName()));
	}

	// 내 정보 수정
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "10. 사용자 정보 변경", notes = "닉네임, 이메일, 비밀번호, 전화번호, 우편번호, 기본주소, 프로필사진, 한줄소개 변경")
	@ApiResponses({ @ApiResponse(code = 200, response = Member.class, message = "회원가입한 사용자 정보"),
			@ApiResponse(code = 200, message = "사용자 정보를 변경하지 못했습니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "username", value = "아이디", required = true, dataTypeClass = String.class),
			@ApiImplicitParam(name = "nick", value = "닉네임", required = false, dataTypeClass = String.class),
			@ApiImplicitParam(name = "email", value = "이메일", required = false, dataTypeClass = String.class),
			@ApiImplicitParam(name = "zipCode", value = "우편번호", required = true, dataTypeClass = String.class),
			@ApiImplicitParam(name = "baseAddr", value = "주소", required = true, dataTypeClass = String.class),
			@ApiImplicitParam(name = "tel", value = "핸드폰번호", required = true, dataTypeClass = String.class),
			@ApiImplicitParam(name = "photo", value = "프로필 사진", required = false, dataTypeClass = MultipartFile.class),
			@ApiImplicitParam(name = "intro", value = "한줄소개", required = true, dataTypeClass = String.class), })
	@PostMapping(path = "/member/userupdate", produces = "application/json;charset=utf-8")
	public ResponseEntity<?> update(@ModelAttribute Member member, @Nullable MultipartFile sajin, Principal principal)
			throws Exception {
		member.setUsername(principal.getName());
		member.setNick((URLDecoder.decode(member.getNick(), "UTF-8")));
		member.setEmail((URLDecoder.decode(member.getEmail(), "UTF-8")));
		member.setZipCode((URLDecoder.decode(member.getZipCode(), "UTF-8")));
		member.setBaseAddr((URLDecoder.decode(member.getBaseAddr(), "UTF-8")));
		member.setTel((URLDecoder.decode(member.getTel(), "UTF-8")));
		member.setIntro((URLDecoder.decode(member.getIntro(), "UTF-8")));
		return ResponseEntity.ok(service.update(member, sajin));
	}

	// 비밀번호 변경
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "9. 비밀번호 변경", notes = "사용자 비밀번호 변경")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "비밀번호를 변경한 경우 결과 문자열 : OK"),
			@ApiResponse(code = 409, message = "비밀번호를 확인하지 못했습니다") })
	@ApiImplicitParams({
			@ApiImplicitParam(name = "password", value = "기존 비밀번호", required = true, dataType = "string", paramType = "query"),
			@ApiImplicitParam(name = "newPassword", value = "새로운 비밀번호", required = true, dataType = "string", paramType = "query") })
	@PatchMapping(path = "/member/newpassword", produces = "text/plain;charset=utf-8")
	public ResponseEntity<?> updateNewPassword(@NonNull String password, @NonNull String newPassword,
			Principal principal) {
		return ResponseEntity.ok(service.updateNewPassword(principal.getName(), password, newPassword));
	}

	// 회원 탈퇴
	@PreAuthorize("isAuthenticated()")
	@ApiOperation(value = "11. 회원탈퇴", notes = "회원 탈퇴")
	@ApiResponses({ @ApiResponse(code = 200, response = String.class, message = "사용해주셔서 감사합니다"),
			@ApiResponse(code = 409, message = "회원 탈퇴에 실패했습니다") })
	@ApiImplicitParams({ @ApiImplicitParam(required = true, dataType = "string", paramType = "query"), })
	@PostMapping(path = "/member/resign", produces = "text/plain;charset=utf-8")
	public ResponseEntity<String> resign(SecurityContextLogoutHandler handler, HttpServletRequest req,
			HttpServletResponse res, Authentication auth) {
		service.delete(auth.getName());
		handler.logout(req, res, auth);
		return ResponseEntity.ok(null);
	}

}
