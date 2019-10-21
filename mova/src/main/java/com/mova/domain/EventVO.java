package com.mova.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EventVO {
	private int eno;
	private String userid;
	private String title;
	private Date startdate;
	private Date enddate;
	private String uuid;
	private String uploadPath;
	private String fileName;
}
