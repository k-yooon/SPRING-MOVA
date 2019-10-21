package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.Criteria;
import com.mova.domain.MemberVO;

public interface MemberMapper {
	public void join(MemberVO rVO);				
	
	public MemberVO idFind(@Param("usernm") String usernm, @Param("tel") String tel);   
	public MemberVO pwFind(@Param("userid") String userid,@Param("tel") String tel);   
	public int pwNew(MemberVO member);
	
	public int memberUpdate(MemberVO member);		
	public int memberDelete(String userid);			
	
	public MemberVO read(String userid);
	public List<MemberVO> readAll();
	
	
	public List<MemberVO> memberInfoRead(@Param("userid") String userid, @Param("star") int star);   //회원 정보 조회
	//사용자 검색(홈)
	public List<MemberVO> getUserSearch(Criteria cri);
	//관리자가 회원아이디검색시 정보나오기
	public MemberVO get(String userid);
	
	   public MemberVO memberInfoRead2(@Param("userid") String userid);
	   public MemberVO getmember(String userid);
	   
}
