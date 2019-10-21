package com.mova.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.Criteria;
import com.mova.domain.RecommendBoardVO;
import com.mova.mapper.RecommendBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RecommendBoardServiceImpl implements RecommendBoardService{
	private RecommendBoardMapper recommendBoardMapper;
	
	@Transactional
	@Override
	public void register(RecommendBoardVO reboard) {
		log.info("register..... : " + reboard);
		recommendBoardMapper.insert(reboard);

	}

	@Override
	public RecommendBoardVO get(int reno) {
		return recommendBoardMapper.read(reno);
	}

	@Transactional
	@Override
	public boolean modify(RecommendBoardVO reboard) {
		log.info("modify..... : " + reboard);
		boolean modifyResult = recommendBoardMapper.update(reboard) == 1;//수정 처리
		return modifyResult;
		
	}

	@Transactional
	@Override
	public boolean remove(int reno) {
		log.info("remove..... : " + reno);
		return recommendBoardMapper.delete(reno) == 1;
	}

	@Override
	public List<RecommendBoardVO> getList(Criteria cri) {
			log.info("getList with criteria : " + cri);
			return recommendBoardMapper.getListWithPaging(cri);
	}
	
	//나의 게시글 조회
	   @Override
	   public List<RecommendBoardVO> getMyList(String userid) {
	      return recommendBoardMapper.getMyList(userid);
	   }
	   
	   @Override
		public int getTotalCount(Criteria cri) {
			log.info("get total count" + cri);	//get total count를 로그로 기록
			return recommendBoardMapper.getTotalCount(cri);
			
		}

	
}
