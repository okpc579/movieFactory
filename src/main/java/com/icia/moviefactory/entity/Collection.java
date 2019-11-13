package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Collection {
	private long collNo;
	private String collName;
	private String username;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String collIntro;
	private List<CollectionDetail> detail;
}
