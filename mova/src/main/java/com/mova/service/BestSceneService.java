package com.mova.service;

import java.util.List;
import com.mova.domain.BestSceneVO;
import com.mova.domain.Criteria;
import com.mova.domain.ReportBestSceneVO;

public interface BestSceneService {
	public int register(BestSceneVO vo);
	   public List<BestSceneVO> getList(int mno, String userid);
	   public int remove(int bsNo);
	   public int modify(BestSceneVO bestScene);
	   public BestSceneVO get(int bsNo);
	public int report(int bsno, String reporter);									//명장면, 명대사 신고하기
	public List<ReportBestSceneVO> getReportList(Criteria cri);		//신고 명장면, 명대사 목록
//	public int reportRemove(int rebsno);							//신고 명장면, 명대사 삭제하기
	public int getTotal(Criteria cri);
	
}
