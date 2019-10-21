package com.mova.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.EventVO;
import com.mova.domain.MemberVO;


public interface EventMapper {
	//이벤트 등록(관리자)
	public int insert(EventVO event);
	
	//이벤트 조회(관리자)
	public EventVO read(int eno);
	
	//이벤트 삭제 (관리자)
	public int delete(int eno);
	
	//이벤트 목록 (관리자)
	public List<EventVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	//현재 진행중인 이벤트
	public EventVO ingEvent();
	
	//이벤트 참여
	public int eventJoin(EventVO event);
	
	//이벤트 참여 확인
	public EventVO eventChk(@Param("eno") int eno, @Param("userid") String userid);
	
	//추첨할 이벤트 주회
	public EventVO pickEvent();
	
	//당첨자 랜덤 추출
	public List<EventVO> pickMember(int eno);
	
	//당첨자 테이블에 추가
	public int insertMember(@Param("eno") int eno, @Param("userid") String userid);
	
	//당첨자 조회
	public List<MemberVO> getPickMem(int eno);

}
