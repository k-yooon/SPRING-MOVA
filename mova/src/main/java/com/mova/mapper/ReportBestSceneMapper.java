package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.ReportBestSceneVO;


public interface ReportBestSceneMapper {
	public List<ReportBestSceneVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	public int delete(int rebsno);
}
