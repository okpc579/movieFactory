package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductAsk {
	private long pAskNo;
	private String licenseNo;
	private long pNo;
	private String username;
	private String title;
	private String content;
	private String answer;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date askRegDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date answerRegDate;
	private List<String> answerState;
	private List<String> pAskCate;
}
