package com.mova.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mova.domain.Criteria;
import com.mova.domain.QnAReplyVO;
import com.mova.mapper.QnABoardMapper;
import com.mova.mapper.QnABoardReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class QnABoardReplyServiceImpl implements QnABoardReplyService{

	private QnABoardReplyMapper qnaRMapper;
	//댓글등록
	@Override
	public int register(QnAReplyVO qnareply) {
		return qnaRMapper.insert(qnareply);
	}

	@Override
	public QnAReplyVO get(int qno) {
		
		return qnaRMapper.read(qno);
	}

	@Override
	public int remove(int qreno) {
		return qnaRMapper.delete(qreno);
	}

	@Override
	public int modify(QnAReplyVO qnareply) {
		log.info("댓글수정" + qnareply);
		return qnaRMapper.update(qnareply);
	}

	@Override
	public List<QnAReplyVO> getList(Criteria cri, int qno) {
		return qnaRMapper.getListWithPaging(cri, qno);
	}

}
