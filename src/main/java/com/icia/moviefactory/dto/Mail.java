package com.icia.moviefactory.dto;

import lombok.*;

@Data
@AllArgsConstructor
@Builder
public class Mail {
	private String sender;
	private String receiver;
	private String title;
	private String content;
}
