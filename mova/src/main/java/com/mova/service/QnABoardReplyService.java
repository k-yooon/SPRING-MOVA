package com.mova.service;

import java.util.List;
import com.mova.domain.Criteria;
import com.mova.domain.PageDTO;
import com.mova.domain.QnAReplyVO;

public interface QnABoardReplyService {
	public int register(QnAReplyVO qnareply);
	
	public QnAReplyVO get(int qno);
	
	public int remove(int qreno);
	
	public int modify(QnAReplyVO qnareply);
	
	public List<QnAReplyVO> getList(Criteria cri, int qno);
	
//	public PageDTO getListPage(Criteria cri, int qno);
	
}
