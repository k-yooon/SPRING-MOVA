package com.mova.domain;

import java.util.Date;
import java.util.List;


import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String tel;
	private String usernm;
	private String birth;
	private String email;
	private String gender;
	private Date regDate;
	private String uuid;
	private String uploadPath;
	private String fileName;
	private List<AuthVO> authList;
	private List<CommentVO> commList;
	private List<MovieVO> movieList;
}













