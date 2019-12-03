package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import com.fasterxml.jackson.annotation.*;

import lombok.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	private String username;
	private String password;
	private String name;
	private String nick;
	private String email;
	private String baseAddr;
	private String zipCode;
	private String tel;
	private String photo;
	private long birth;
	private long gender;
	private long blindCnt;
	private long enabled;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date regDate;
	private String intro;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date lastLoginDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date recentLoginDate;
	private long loginFailureCnt;
	private long isResign;
<<<<<<< HEAD
=======
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date blockDate;
>>>>>>> dongdong
}
