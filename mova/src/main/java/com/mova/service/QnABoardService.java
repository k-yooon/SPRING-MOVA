package com.mova.service;

import java.util.List;

import com.mova.domain.Criteria;
import com.mova.domain.QnABoardVO;


public interface QnABoardService {
	public void register(QnABoardVO qnaboard);
	
	public QnABoardVO get(int qno);
	
	public boolean modify(QnABoardVO qnaboard);
	
	public boolean answer(QnABoardVO qnaboard);
	
	public boolean remove(int qno);
	
	public List<QnABoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	
	//나의 게시글 조회
	public List<QnABoardVO> getMyList(String userid);
	
	
}
