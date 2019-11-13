package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Pay {
	private long payNo;
	private long orderNo;
}
