package com.icia.moviefactory.dto;

import java.util.List;

import com.icia.moviefactory.entity.AdminAsk;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Page {
	private int pageno;
	private int pagesize;
	private int totalcount;
	private List<AdminAsk> adminAsks;
}
