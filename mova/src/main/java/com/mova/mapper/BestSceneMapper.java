package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.BestSceneVO;
import com.mova.domain.ReportBestSceneVO;

public interface BestSceneMapper {

	public int insert(BestSceneVO vo);
	public List<BestSceneVO> getList(@Param("mno") int mno, @Param("userid") String userid);
	public int delete(int bsNo);
	public int update(BestSceneVO bestScene);   
	public BestSceneVO get(int bsNo);
	
	public int reportInsert(@Param("bsNo") int bsNo, @Param("reporter") String reporter); 						// 명장면, 명대사 신고하기

	public List<ReportBestSceneVO> getReportList(); 	// 신고 명장면, 명대사 목록

	public int reportDelete(int rebsno); 				// 신고 명장면, 명대사 삭제하기
}
