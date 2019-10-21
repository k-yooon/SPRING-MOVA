package com.mova.domain;

import lombok.Data;

@Data
public class WishVO {
	private int wno;
	private int mno;
	private String userid;
	private MovieVO movie;
	
}
