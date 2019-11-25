package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class KMovie {
	private String movieCd;			// 영화 코드
	private String movieNm;			// 영화명
	private String movieNmEn;		// 영화영문명
	private String prdtYear;		// 제작년도
	private String openDt;			// 개봉년도
	private String repNationNm;		// 제작국가전체
	private String repGenreNm;			// genreNm 장르 출력, nationAlt 장르 전체 출력
	private String directors;		// 감독명을 나타냅니다
	private String peopleNm;		// 감독명을 출력합니다
	private String totCnt;
	public String getMovieNm() {
		return movieNm;
	}
	
}