package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.CommJoaVO;
import com.mova.domain.CommentVO;
import com.mova.domain.MovieVO;
import com.mova.domain.ReportCommentVO;

public interface CommentMapper {
	//코멘트 목록
	public List<CommentVO> getList(@Param("mno") int mno, @Param("keyword") String keyword);	
	//코멘트 총 갯수(영화 번호);
	public int getTotalComm(int mno);		
	//코멘트 등록하기
	public int insert(CommentVO comment);		
	//코멘트 삭제하기
	public int delete(int cno);			
	//코멘트 수정하기
	public int update(CommentVO comment);			
	//코멘트 신고하기
	public int reportInsert(@Param("cno") int cno, @Param("reporter") String reporter);	
	//신고 코멘트 목록
	public List<ReportCommentVO> getReportList();		
	//신고 코멘트 삭제하기
	public int reportDelete(int rcno);		
	//내가 준 별점별 영화 조회
	public List<MovieVO> ReadMyMovie(String userid);		
	//나의 코멘트 조회
	public CommentVO getMyComm(@Param("mno") int mno, @Param("userid") String userid);
	//나의 모든 코멘트 조회
	public List<CommentVO> getMyAllComm(@Param("userid") String userid, @Param("keyword") String keyword);
	//별점별 코멘트 갯수 조회
	public List<CommentVO> getStarCount(String userid);
	//코멘트 총 갯수(아이디)
	public int getTotalCommById(String userid);
	//나의 평균 별점
	public double getStarAvgById(String userid);
	//나의 가장 많이 준 별점
	public int getMuchStarById(String userid);
	//코멘트 좋아요 추가
	public int addCommJoa(@Param("userid") String userid, @Param("cno") int cno);
	//코멘트 좋아요 체크
	public List<CommJoaVO> chkCommJoa(@Param("userid") String userid, @Param("mno") int mno);
	//코멘트 좋아요 삭제
	public int deleteCommjoa(@Param("userid") String userid, @Param("cno") int cno);
	//코멘트 좋아요 수 업데이트
	public void updateJoaCnt(@Param("cno") int cno, @Param("amount") int amount);
}
