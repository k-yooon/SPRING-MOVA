package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.QnABoardVO;
import com.mova.domain.RecommendBoardVO;

public interface RecommendBoardMapper {
		public List<RecommendBoardVO> getMyList(@Param("userid") String userid);   //나의 게시글 조회

	   public List<RecommendBoardVO> getList();
	   
	   public void insert(RecommendBoardVO reboard);
	   
	   public RecommendBoardVO read(int reno);
	   
	   public int delete(int reno);
	   
	   public int update(RecommendBoardVO reboard);
	   
	   public List<RecommendBoardVO> getListWithPaging(Criteria cri);
	   
	   public int getTotalCount(Criteria cri);
}
