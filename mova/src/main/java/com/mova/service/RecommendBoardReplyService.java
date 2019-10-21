package com.mova.service;

import java.util.List;

import com.mova.domain.RecommendBoardReplyVO;
import com.mova.domain.ReplyPageDTO;
import com.mova.domain.Criteria;
import com.mova.domain.PageDTO;

public interface RecommendBoardReplyService {
	
	public int register(RecommendBoardReplyVO rereplyboard);
	public RecommendBoardReplyVO get(int rereno);
	public int remove(int rereno);
	public int modify(RecommendBoardReplyVO rereplyboard);
	public List<RecommendBoardReplyVO> getList(Criteria cri, int reno);
	public ReplyPageDTO getListPage(Criteria cri, int reno);
}
