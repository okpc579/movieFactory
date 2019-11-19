package com.icia.moviefactory.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class AskDto {
	private long adminAskNo;
	private String title;
	private String content;
	private String username;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	// 글 작성자 본인여부
	private boolean isMe;
	private boolean isNotMe;
}
