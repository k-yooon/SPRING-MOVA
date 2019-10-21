package com.mova.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	
	private int cno;
	private int mno;
	private String userid;
	private int star;
	private String content;
	private Date regdate;
	private String genre;
	private int joa;
	private MovieVO movie;
	private int count;
	

}
