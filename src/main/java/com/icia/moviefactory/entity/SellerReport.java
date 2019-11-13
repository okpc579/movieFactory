package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SellerReport {
	private String username;
	private String licenseNo;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
}
