package com.mova.service;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.BestSceneVO;
import com.mova.domain.Criteria;
import com.mova.domain.ReportBestSceneVO;
import com.mova.mapper.BestSceneMapper;
import com.mova.mapper.MovieMapper;
import com.mova.mapper.ReportBestSceneMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BestSceneServiceImpl implements BestSceneService {
   private ReportBestSceneMapper reportbestscenemapper;
   private BestSceneMapper bestscenemapper;
   
   @Transactional
   @Override
   public int register(BestSceneVO vo) {
      log.info("등록 : " + vo);
      return bestscenemapper.insert(vo);
   }

   @Override
   public List<BestSceneVO> getList(int mno, String userid) {
      log.info("영화 번호 : " + mno);
      return bestscenemapper.getList(mno, userid);
   }

   @Transactional
   @Override
   public int remove(int bsNo) {
      log.info("삭제 : " + bsNo);
      return bestscenemapper.delete(bsNo);
   }

   @Override
   public int modify(BestSceneVO bestScene) {
      log.info("수정 : " + bestScene);
      return bestscenemapper.update(bestScene);
   }

   @Override
   public BestSceneVO get(int bsNo) {
      return bestscenemapper.get(bsNo);
   }


   @Override
   public int report(int bsNo,String reporter) {
		log.info("report : " + bsNo);
		return bestscenemapper.reportInsert(bsNo, reporter);
   }

   @Override
   public List<ReportBestSceneVO> getReportList(Criteria cri) {
      log.info("getList with criteria : " + cri);
      return reportbestscenemapper.getListWithPaging(cri);
   }
//   @Transactional
//   @Override
//   public int reportRemove(int bsno) {
//      log.info("remove..... : " + bsno);
//      return bestscenemapper.delete(bsno);
//   }

   @Override
   public int getTotal(Criteria cri) {
      log.info("get total count");   //get total count를 로그로 기록
      return reportbestscenemapper.getTotalCount(cri);
   }

}