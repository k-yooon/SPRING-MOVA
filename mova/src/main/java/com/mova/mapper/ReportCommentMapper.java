package com.mova.mapper;

import java.util.List;

import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.ReportCommentVO;

public interface ReportCommentMapper {
	public List<ReportCommentVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	public int deleteInList(int rcno);
}
