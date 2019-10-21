package com.mova.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RecommendBoardReplyVO {

	private int rereno;
	private int reno;
	private String userid;
	private String content;
	private Date regdate;
	
}
