package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cart {
	private long cartNo;
	private String username;
	private long pNo;
	private String licenseNo;
	private long cnt;
}
