package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CollectionLike {
	private long collLikeNo;
	private long collNo;
	private String username;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date likeRegDate;
}
