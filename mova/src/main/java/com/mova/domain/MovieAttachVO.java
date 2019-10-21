package com.mova.domain;

import lombok.Data;

@Data
public class MovieAttachVO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private int mno;
	
}
