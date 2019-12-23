package com.icia.moviefactory.entity;

import java.util.*;

import com.fasterxml.jackson.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Collection {
	private long collNo;
	private String collName;
	private String username;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String collIntro;
	private List<CollectionDetail> detail;
	private long collLikeCnt;
}
