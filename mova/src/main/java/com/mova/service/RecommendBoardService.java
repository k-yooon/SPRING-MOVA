package com.mova.service;

import java.util.List;

import com.mova.domain.RecommendBoardVO;
import com.mova.domain.Criteria;

public interface RecommendBoardService {
	public void register(RecommendBoardVO reboard);
	
	public RecommendBoardVO get(int reno);
	
	public boolean modify(RecommendBoardVO reboard);
	
	public boolean remove(int reno);
	
	public List<RecommendBoardVO> getList(Criteria cri);
	
	//나의 게시글 조회
	public List<RecommendBoardVO> getMyList(String userid);
	
		public int getTotalCount(Criteria cri);
}
