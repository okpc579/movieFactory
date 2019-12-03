package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FavoriteMovie {
	private long mNo;
	private String username;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
//	private List<FavoriteMovieDetail> detail;
}
