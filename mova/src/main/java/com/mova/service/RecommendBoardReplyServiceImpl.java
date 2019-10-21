package com.mova.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.Criteria;
import com.mova.domain.PageDTO;
import com.mova.domain.RecommendBoardReplyVO;
import com.mova.domain.ReplyPageDTO;
import com.mova.mapper.RecommendBoardMapper;
import com.mova.mapper.RecommendBoardReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class RecommendBoardReplyServiceImpl implements RecommendBoardReplyService {
	private RecommendBoardReplyMapper mapper;
	private RecommendBoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(RecommendBoardReplyVO rereplyboard) {
		log.info("register....." + rereplyboard);
		return mapper.insert(rereplyboard);
	}

	@Override
	public RecommendBoardReplyVO get(int rereno) {
		log.info("get....." + rereno);
		return mapper.read(rereno);
	}
	@Transactional
	@Override
	public int remove(int rereno) {
		log.info("remove....." + rereno);
		RecommendBoardReplyVO vo = mapper.read(rereno);
		return mapper.delete(rereno);
	}

	@Override
	public int modify(RecommendBoardReplyVO rereplyboard) {
		log.info("modify....." + rereplyboard);
		return mapper.update(rereplyboard);
	}

	@Override
	public List<RecommendBoardReplyVO> getList(Criteria cri, int reno) {
		log.info("getList....." + reno);
		return mapper.getListWithPaging(cri, reno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int reno) {
		//특정 게시물의 전체 댓글 개수와 댓글 목록 반환
		System.out.println("333");
		return new ReplyPageDTO(mapper.getCountByReno(reno),
						   mapper.getListWithPaging(cri, reno));
	}

}
