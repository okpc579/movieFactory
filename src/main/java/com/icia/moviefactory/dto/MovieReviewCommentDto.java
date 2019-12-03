package com.icia.moviefactory.dto;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieReviewCommentDto {
	private long mRevCmntNo;
	private long mRevNo;
	private String username;
	private String content;
	private long isBlind;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private long cmntLikeCnt;
	private long cmntRepCnt;
	private boolean isOwn;
}
