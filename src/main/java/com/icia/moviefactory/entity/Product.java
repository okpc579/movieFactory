package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Product {
	private long p_no;
	private String licenseNo;
	private String pName;
	private long pPrice;
	private long pStock;
	private String origin;
	private String pMainPhoto;
	private String pInfoPhoto;
	private String pInfoExplain;
	private List<String> cateName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regDate;
	private String vendor;
	private long isPBuy;
	private long delCost;
	private long isBlind;
}
