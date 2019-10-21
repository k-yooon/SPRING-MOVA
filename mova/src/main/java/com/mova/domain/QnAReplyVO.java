package com.mova.domain;

import java.util.Date;
import lombok.Data;

@Data
public class QnAReplyVO {
	private int qreno;
	private int qno;
	private String userid;
	private String content;
	private Date regdate;
}
