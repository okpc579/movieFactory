package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NMovie {
    private String image;		// 사진
    private String subtitle;		// 영문제목
    private String pubDate;		// 제작년도
	public String getImage() {
		return image;
	}
}
