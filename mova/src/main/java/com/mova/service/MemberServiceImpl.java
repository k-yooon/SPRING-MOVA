package com.mova.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mova.domain.MemberVO;
import com.mova.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper memberMapper;
	 
	//회원가입
	@Override
	public void join(MemberVO rVO) {
		log.info("join " + rVO);
		memberMapper.join(rVO);	
	}
	
	//ID찾기
	@Override
	public MemberVO idFind(String usernm, String tel){
		//System.out.println("36");
		log.info("find " + usernm + " " + tel);
		return memberMapper.idFind(usernm, tel);

	}

	//pw찾기
	@Override
	public MemberVO pwFind(String userid, String tel) {
		return memberMapper.pwFind(userid, tel);
	}
	
	//pw 업데이트
	@Override
	public int pwUpdate(MemberVO member) {
		log.info("pwUpdate " + member);
		return memberMapper.pwNew(member);
	}
	
	//아이디 중복 체크
	@Override
	public List<MemberVO> readAll() {
		log.info("idchk");
		return memberMapper.readAll();
	}
	
	 @Override
	   public List<MemberVO> memberInfo(String userid, int star) {
	      System.out.println("11");
	      log.info("ID : " + userid);
	      System.out.println("22");
	      //log.info("star : " + star);
	      return memberMapper.memberInfoRead(userid, star);
	   }

	@Override
	public boolean memberModify(MemberVO member) {
		return memberMapper.memberUpdate(member) == 1;
	}

	@Override
	public boolean memberRemove(String userid) {
		log.info(userid + "님 탈퇴각");
		return memberMapper.memberDelete(userid) == 1;
	}
	
	@Override
	public MemberVO get(String userid) {
		return memberMapper.get(userid);
	}

	 @Override
     public MemberVO memberInfo2(String userid) {
        return memberMapper.memberInfoRead2(userid);
     }
	 
	 @Override
	   public MemberVO getmember(String userid) {
	      
	      return memberMapper.getmember(userid);
	   }


}
