package com.mova.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.EventVO;
import com.mova.domain.MemberVO;


public interface EventService {
	//이벤트 등록
	public void register(EventVO event);
	
	//이벤트 목록
	public List<EventVO> getList(Criteria cri);
	
	//이벤트 조회(관리자)
	public EventVO get(int eno);
	public int getTotal(Criteria cri);
		
	//이벤트 삭제(관리자)
	public boolean remove(int eno);
	
	//현재 진행중인 이벤트
	public EventVO ingEvent();
	
	//이벤트 참여
	public int eventJoin(EventVO event);
	
	//이벤트 참여 확인
	public EventVO eventChk(int eno, String userid);
	
	//추첨할 이벤트 조회
	public EventVO pickEvent();
	
	//당첨자 랜덤 추출
	public boolean pickMember(int eno);
	
	//당첨자 조회
	public List<MemberVO> getPickMem(int eno);

		
}
