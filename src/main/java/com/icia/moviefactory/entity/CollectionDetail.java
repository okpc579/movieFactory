package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CollectionDetail {
	private long mNo;
	private long collNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
}
