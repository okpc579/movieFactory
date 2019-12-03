package com.icia.moviefactory.dto;

<<<<<<< HEAD
import java.util.*;
import java.util.Collection;
=======
import java.util.List;
>>>>>>> 20191126_박동민똥멍청이지각3대장

<<<<<<< HEAD
import com.icia.moviefactory.entity.AdminAsk;
import com.icia.moviefactory.entity.Member;
import com.icia.moviefactory.entity.MovieReview;
import com.icia.moviefactory.entity.MovieReviewComment;
import com.icia.moviefactory.entity.Notice;
=======
import com.icia.moviefactory.entity.*;
import com.icia.moviefactory.entity.Collection;
>>>>>>> 20191126_남동윤

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
<<<<<<< HEAD
	private List<Collection> collectionList;
	private List<Follow> follows;
=======
	private List<Collection> collections;
>>>>>>> 20191126_남동윤
}
