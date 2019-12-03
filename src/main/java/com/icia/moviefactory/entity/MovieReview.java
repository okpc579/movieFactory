package com.icia.moviefactory.entity;

import java.util.*;

import com.fasterxml.jackson.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieReview {
	private long mRevNo;
	private String username;
	private long mNo;
	private long rating;
	private String mRevContent;
	private long isSpo;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String genre;
	private long isBlind;
	private long likeCnt;
	private long repCnt;
	private List<MovieReviewComment> comments;
}

