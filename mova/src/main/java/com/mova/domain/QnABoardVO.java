package com.mova.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class QnABoardVO {
	private int qno;
	private String userid;
	private String title;
	private String content;
	private String answer;
	private Date regdate;
}
