package com.icia.moviefactory.entity;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AddressBook {
	private long addrebookNo;
	private String username;
	private String addr;
	private String name;
	private String zipCode;
	private String tel;
	private long isBaseAddr;
	private String addrName;
}
