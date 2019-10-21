package com.mova.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.MemberVO;
import com.mova.domain.MovieAttachVO;
import com.mova.domain.MovieVO;
import com.mova.domain.PageDTO;
import com.mova.domain.WishVO;

public interface MovieService {
	//영화 등록(관리자)
	public void register(MovieVO movie);
	
	//영화 조회(관리자)
	public MovieVO get(int mno);
	public int getTotal(Criteria cri);
	
	//영화 수정(관리자)
	public boolean modify(MovieVO movie);
	public boolean postermodify(MovieVO movie);
	
	//영화 삭제(관리자)
	public boolean remove(int mno);
	
	//영화 목록(관리자)
	public List<MovieVO> getList(Criteria cri);
	
	//영화 스틸컷
	public List<MovieAttachVO> getAttachList(int mno);
	
	//추천 영화 조회
	public List<MovieVO> getRecommendMovie(String userid);
	
	//영화 국가 조회
	public List<MovieVO> getMovieNation(String userid);
	
	//국가 총 갯수
	public int getNationCt();
	
	//선호 장르 조회
	public List<CommentVO> getGenre(String userid);
	
	//별점별 영화 조회
	public List<MovieVO> getMovieStar();
	
	//장르별 영화 조회
	public List<MovieVO> getMovieGenre(String genre);
	
	//영화 상세 정보
	public MovieVO getMovie(int mno);
	
	//영화 검색(홈)
	public List<MovieVO> getMovieSearch(Criteria cri);
	
	//사용자 검색(홈)
	public List<MemberVO> getUserSearch(Criteria cri);
	
	public int wish(WishVO wish);				//영화 찜하기
	public WishVO wishCheck(int mno, String userid); //찜한 영화인지 체크
	public int wishRemove(int mno, String userid);	//영화 찜하기 취소
	public List<WishVO> myWish(String userid);
	//선호도 분석(장르 조회)
	public List<MovieVO> genreGetByAge(int start, int end);
	//선호도 분석(영화 조회)
	public List<MovieVO> movieGetByAge(int start, int end);
}
