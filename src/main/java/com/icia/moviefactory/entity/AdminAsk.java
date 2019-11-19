package com.icia.moviefactory.entity;

import java.util.*;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AdminAsk {
	private long adminAskNo;
	@NotBlank
	private String username;
	private String title;
	private String content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writingDate;
	private String askAnswer; // 문의 답변
	private String askStateContent; // 문의 답변상태
}
