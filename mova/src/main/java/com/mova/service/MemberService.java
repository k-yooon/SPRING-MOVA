package com.mova.service;

import java.util.List;

import com.mova.domain.MemberVO;

public interface MemberService{
	public void join(MemberVO rVO);				//회원가입
	public MemberVO idFind(String usernm, String tel);	//아이디 찾기
	public MemberVO pwFind(String userid, String tel);	//비밀번호 찾기
	public int pwUpdate(MemberVO member);					//비밀번호 업데이트
	public List<MemberVO> readAll();						//아이디 중복 체크
	public List<MemberVO> memberInfo(String userid, int star);//회원 정보 조회		//회원 정보 조회
	public boolean memberModify(MemberVO member);	//회원 정보 수정
	public boolean memberRemove(String userid);		//회원 정보 삭제
	public MemberVO get(String userid);
	public MemberVO memberInfo2(String userid); 
	public MemberVO getmember(String userid);
}