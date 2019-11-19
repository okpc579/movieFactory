package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

<<<<<<< HEAD:src/main/java/com/icia/moviefactory/entity/Member.java
=======
import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
>>>>>>> soonsim:src/main/java/com/icia/moviefactory/entity/Member.java
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
<<<<<<< HEAD:src/main/java/com/icia/moviefactory/entity/Member.java
	private long isBlock;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
=======
	private long enabled;
	private long regDate;
>>>>>>> soonsim:src/main/java/com/icia/moviefactory/entity/Member.java
	private String intro;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date lastLoginDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date recentloginDate;
	private long loginFailureCnt;
	private long isResign;
	
}
