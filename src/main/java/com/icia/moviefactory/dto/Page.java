package com.icia.moviefactory.dto;


import java.util.*;

import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.entity.Collection;

import lombok.*;

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
	private List<Follow> follows;
	private List<Collection> collections;
}
