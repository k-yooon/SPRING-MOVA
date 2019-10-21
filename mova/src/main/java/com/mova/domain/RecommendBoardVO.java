package com.mova.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RecommendBoardVO {

	private int reno;
	private String userid;
	private String title;
	private String content;
	private Date regdate;
}
