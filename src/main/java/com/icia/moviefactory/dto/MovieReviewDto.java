package com.icia.moviefactory.dto;

import java.util.*;

import com.fasterxml.jackson.annotation.*;
import com.icia.moviefactory.entity.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieReviewDto {
	private long mRevNo;
	private String username;
	private long mNo;
	private long rating;
	private String mRevContent;
	private long isSpo;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String genre;
	// 글쓴 사람 본인인지 여부
	private boolean isOwn;
	// 댓글 리스트
	private List<MovieReviewComment> comments;
	private long likeCnt;
	private long repCnt;
}
