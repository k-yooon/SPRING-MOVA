package com.mova.mapper;

import java.util.List;

import com.mova.domain.Criteria;
import com.mova.domain.QnABoardVO;

public interface QnABoardMapper {
	   public List<QnABoardVO> getList(Criteria cri);
	   public int getTotalCount(Criteria cri);
	   
	   public List<QnABoardVO> getMyList(String userid);	//나의 게시글 조회
	   
	   
	   public void insert(QnABoardVO qnaboard);
	   
	   public QnABoardVO read(int qno);
	   
	   public int delete(int qno);
	   
	   public int update(QnABoardVO qnaboard);
	   
	   public int answer(QnABoardVO qnaboard);
	   
	   public List<QnABoardVO> getListWithPaging(Criteria cri);
	   
	   
}
