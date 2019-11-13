package com.icia.moviefactory.entity;

import java.util.*;

import org.springframework.format.annotation.*;

import lombok.*;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {
	private long orderNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderDate;
	private long totalPrice;
	private String username;
	private String name;
	private String zipCode;
	private String tel;
	private String delAddr;
	private String request;
	private long payNo;
	private List<OrderDetail> detail;
}
