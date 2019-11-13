package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Seller {
	private String username;
	private String password;
	private String comName;
	private String ceo;
	private String email;
	private String comTel;
	private String account;
	private String photo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
	private long warningCnt;
	private long isBlock;
}
