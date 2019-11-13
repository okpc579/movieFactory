package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieReviewReport {
	private String username;
	private long mRevNo;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String mRepCate;
}
