package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.RecommendBoardReplyVO;

public interface RecommendBoardReplyMapper {

	public int insert(RecommendBoardReplyVO rereplyboard);
	public RecommendBoardReplyVO read(int rereno);
	public int delete(int rereno);
	public int update(RecommendBoardReplyVO rereplyboard);
	public List<RecommendBoardReplyVO> getListWithPaging
	(@Param("cri") Criteria cri, 
	 @Param("reno") int reno);
	public int getCountByReno(int reno);
}
