package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.QnAReplyVO;

public interface QnABoardReplyMapper {
	//등록
	public int insert(QnAReplyVO qnareply);
	
	//조회 
	public QnAReplyVO read(int qno);
	
	//삭제 (댓글번호로)
	public int delete(int qreno);
	
	//수정
	public int update(QnAReplyVO qnareply);
	
	//댓글 목록
	public List<QnAReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("qno") int qno);
//	
//	public int getCountByQno(int qno);
}
