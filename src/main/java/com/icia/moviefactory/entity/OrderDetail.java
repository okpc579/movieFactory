package com.icia.moviefactory.entity;

import java.util.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderDetail {
	private long orderNo;
	private long pNo;
	private String licenseNo;
	private long cnt;
	private long price;
	private List<String> orderState;
	private long delNo;
}
