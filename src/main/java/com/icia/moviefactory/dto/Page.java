package com.icia.moviefactory.dto;

import java.util.List;

import com.icia.moviefactory.entity.AdminAsk;
import com.icia.moviefactory.entity.Member;
import com.icia.moviefactory.entity.MovieReview;
import com.icia.moviefactory.entity.MovieReviewComment;
import com.icia.moviefactory.entity.Notice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Page {
	private int pageno;
	private int pagesize;
	private int totalcount;
	private List<AdminAsk> adminAsks;
	private List<Notice> notices;
	private List<MovieReview> reviews;
	private List<Member> members;
	private List<MovieReview> movieReviews;
	private List<MovieReviewComment> movieReviewComments;
}
