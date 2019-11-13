package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Follow {
	private String followerUsername;
	private String followingUsername;
}
