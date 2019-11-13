package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductReview {
	private long pRevNo;
	private String licenseNo;
	private long pNo;
	private long orderNo;
	private String username;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private long isBlind;
	private String photo;
}
