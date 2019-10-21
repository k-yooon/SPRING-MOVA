package com.mova.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.MemberVO;
import com.mova.domain.MovieVO;


public interface MovieMapper {
	//영화 등록(관리자)
	public int insert(MovieVO mvo);
	
	//영화 조회(관리자)
	public MovieVO read(int mno);
	
	//영화 삭제 (관리자)
	public int delete(int mno);
	
	//영화 수정(관리자)
	public int update(MovieVO mvo);
	
	//영화 목록 (관리자)
	public List<MovieVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	//영화 포스터 삭제
	public int deleteAll(int mno);
	
	//영화 총 갯수 가지고 오기
	public int getCountByMno(int mno);
	
	//추천 영화
	public List<MovieVO> getRecommendMovie(String userid);
	
	//별점별 영화 조회
	public List<MovieVO> getMovieStar();
	
	//장르별 영화 조회 
	public List<MovieVO> getMovieGenre(String genre);
	
	//영화 상세정보  
	public MovieVO readMovie(int mno);
	
	//영화 검색(홈)
	public List<MovieVO> getMovieSearch(Criteria cri);
	
	//영화 국가별 조회
	public List<MovieVO> getMovieNation(String userid);
	
	//국가 총 개수
	public int getNationCt();
	
	//선호하는 장르 조회
	public List<CommentVO> getGenre(String userid);
	
	//선호도 분석(장르 조회)
	public List<MovieVO> genreGetByAge(@Param("start") int start, @Param("end") int end);
	
	//선호도 분석(영화 조회)
	public List<MovieVO> movieGetByAge(@Param("start") int start, @Param("end") int end);
	

}
