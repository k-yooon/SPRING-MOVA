package com.mova.domain;

import lombok.Data;

@Data
public class FollowVO {
	
	private String userid;
	private String follower;
	private MemberVO member;
	private int count;

}
