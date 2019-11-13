package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Authorities {
	private String username;
	private String authority;
}
