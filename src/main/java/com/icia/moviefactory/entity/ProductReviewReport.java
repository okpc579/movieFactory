package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductReviewReport {
	private long pRevNo;
	private String username;
	private long pNo;
	private String licenseNo;
	private long orderNo;
	private String title;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String content;
	private String pRepCate;
}
