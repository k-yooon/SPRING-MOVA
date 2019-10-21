package com.mova.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.CommJoaVO;
import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.FollowVO;
import com.mova.domain.MovieVO;
import com.mova.domain.ReportCommentVO;
import com.mova.domain.WishVO;

public interface CommentService {
	public List<CommentVO> getList(int mno, String keyword);//코멘트 목록
	public int getTotalComm(int mno);						//코멘트 총 갯수
	public int register(CommentVO comment);					//코멘트 등록하기
	public int remove(int cno);								//코멘트 삭제하기
	public int modify(CommentVO comment);					//코멘트 수정하기
	public int report(int cno, String reporter);			//코멘트 신고하기
	public List<ReportCommentVO> getReportList(Criteria cri);//신고 코멘트 목록
	public int follow(FollowVO follow);						//팔로우하기
	public FollowVO followCheck(String userid, String follower); 		//팔로우 체크
	public int followRemove(String userid, String follower);//팔로우 취소하기
	public List<FollowVO> getFollowing(String userid);		//팔로잉 조회
	public List<FollowVO> getFollower(String userid);		//팔로워 조회
	public FollowVO followingCount(String userid);				//팔로잉 총 개수 조회
	public FollowVO followerCount(String userid); 				//팔로워 총 개수 조회
	//내가 준 별점별 영화 조회
	public List<MovieVO> getMyMovie(String userid);
	//나의 코멘트 조회
	public CommentVO getMyComm(int mno, String userid);
	//나의 모든 코멘트 조회
	public List<CommentVO> getMyAllComm(String userid, String keyword);
	//별점별 코멘트 갯수 조회
	public List<CommentVO> getStarCount(String userid);
	//코멘트 총 갯수(아이디)
	public int getTotalCommById(String userid);
	//나의 별점 평균
	public double getStarAvgById(String userid);
	//나의 가장 많이 준 별점
	public int getMuchStarById(String userid);
	//신고 코멘트 개수 저장
	public int getReportCommTotal(Criteria cri);	
	//신고된 코멘트 목록만 삭제
	public int deleteInList(int rcno);
	//코멘트 좋아요 추가
	public int addCommJoa(String userid, int cno);
	//코멘트 좋아요 체크
	public List<CommJoaVO> chkCommJoa(String userid, int mno);
	//코멘트 좋아요 삭제
	public int deleteCommjoa(String userid, int cno);
}
