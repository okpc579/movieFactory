package com.icia.moviefactory.entity;

import java.util.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FavoriteMovie {
	private long mLikeNo;
	private String username;
	private List<FavoriteMovieDetail> detail;
}
