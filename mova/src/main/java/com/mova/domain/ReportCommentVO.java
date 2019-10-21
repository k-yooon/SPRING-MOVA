package com.mova.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportCommentVO {

	private int rcno;
	private int cno;
	private String reporter;
	private CommentVO comm;
	
}
