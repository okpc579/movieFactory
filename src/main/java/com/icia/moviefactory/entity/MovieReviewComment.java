package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieReviewComment {
	private long mRevCmntNo;
	private long mRevNo;
	private String username;
	private String content;
	private long isBlind;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
}
