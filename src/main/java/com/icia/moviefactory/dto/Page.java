package com.icia.moviefactory.dto;

import java.util.*;
import java.util.Collection;

import com.icia.moviefactory.entity.*;

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
	private List<MovieReview> reviews;
	private List<Member> members;
	private List<MovieReview> movieReviews;
	private List<MovieReviewComment> movieReviewComments;
	private List<Collection> collectionList;
	private List<Follow> follows;
}
