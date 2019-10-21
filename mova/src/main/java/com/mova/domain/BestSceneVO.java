package com.mova.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BestSceneVO {

	private int bsno;
	private int mno;
	private String userid;
	private String content;
	private int joa;
	private String uuid;
	private Date regDate;
	private String fileName;
	private String uploadPath;
}
