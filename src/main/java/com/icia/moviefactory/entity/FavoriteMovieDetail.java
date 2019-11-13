package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FavoriteMovieDetail {
	private long mNo;
	private long mLikeNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
}
