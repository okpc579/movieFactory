package com.icia.moviefactory.entity;

import java.util.*;

import com.fasterxml.jackson.annotation.*;

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
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date writingDate;
	private long cmntLikeCnt;
	private long cmntRepCnt;
	private List<MovieReviewCommentReport> commentReports;
}
