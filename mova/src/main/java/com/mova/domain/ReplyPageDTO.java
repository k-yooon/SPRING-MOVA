package com.mova.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	private int replyCnt;		//전체 댓글 갯수
	private List<RecommendBoardReplyVO> list;	//댓글 목록
}
