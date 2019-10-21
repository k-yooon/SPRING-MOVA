package com.mova.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mova.domain.Criteria;
import com.mova.domain.QnABoardVO;
import com.mova.mapper.QnABoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class QnABoardServiceImpl implements QnABoardService{
	private QnABoardMapper qnaBoardMapper;
	
	//문의글 등록
		@Override
		public void register(QnABoardVO qnaboard) {
			
			qnaBoardMapper.insert(qnaboard);
			
		}


		@Override
		public boolean remove(int qno) {
			
			
			return qnaBoardMapper.delete(qno) == 1;
		}


		@Override
		public QnABoardVO get(int qno) {
			
			
			return qnaBoardMapper.read(qno);
		}


		@Override
		public boolean modify(QnABoardVO qnaboard) {
			
			return qnaBoardMapper.update(qnaboard) == 1;
		}


		@Override
		public List<QnABoardVO> getList(Criteria cri) {
			
			return qnaBoardMapper.getList(cri);
		}


		@Override
		public int getTotal(Criteria cri) {
			return qnaBoardMapper.getTotalCount(cri);
		}


		@Override
		public boolean answer(QnABoardVO qnaboard) {
			
			return qnaBoardMapper.answer(qnaboard) == 1;
		}

	//나의 게시글 조회
	   @Override
	   public List<QnABoardVO> getMyList(String userid) {
	      return qnaBoardMapper.getMyList(userid);
	   }

}
