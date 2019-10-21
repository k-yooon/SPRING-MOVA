package com.mova.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.Criteria;
import com.mova.domain.EventVO;
import com.mova.domain.MemberVO;
import com.mova.mapper.EventMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class EventServiceimpl implements EventService {
	private EventMapper eventMapper;

	@Override
	public void register(EventVO event) {
		log.info("register..... : " + event);
		eventMapper.insert(event);
	}

	@Override
	public List<EventVO> getList(Criteria cri) {
		return eventMapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return eventMapper.getTotalCount(cri);
	}

	@Override
	public EventVO get(int eno) {
		return eventMapper.read(eno);
	}

	@Override
	public boolean remove(int eno) {
		return eventMapper.delete(eno) == 1;
	}

	@Override
	public EventVO ingEvent() {
		return eventMapper.ingEvent();
	}

	@Override
	public int eventJoin(EventVO event) {
		return eventMapper.eventJoin(event);
	}

	@Override
	public EventVO eventChk(int eno, String userid) {
		return eventMapper.eventChk(eno, userid);
	}

	@Override
	public EventVO pickEvent() {
		return eventMapper.pickEvent();
	}

	@Transactional
	@Override
	public boolean pickMember(int eno) {
		List<EventVO> pickMem = eventMapper.pickMember(eno);
		int insertChk = 0;
		for(int i = 0; i < pickMem.size(); i++) {
			insertChk = eventMapper.insertMember(pickMem.get(i).getEno(), pickMem.get(i).getUserid());
		}
		System.out.println("insertChk : " + insertChk);
		return insertChk == 1;
	}

	@Override
	public List<MemberVO> getPickMem(int eno) {
		return eventMapper.getPickMem(eno);
	}

}
