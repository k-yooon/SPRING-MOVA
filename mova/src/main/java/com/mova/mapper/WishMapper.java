package com.mova.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mova.domain.WishVO;

public interface WishMapper {
	public int wishInsert(WishVO wish);    //영화 찜하기
	public WishVO read(@Param("mno") int mno, @Param("userid") String userid); //찜한 영화인지 아닌지 체크
	public int wishDelete(@Param("mno") int mno, @Param("userid") String userid);    //영화 찜하기 취소
	public List<WishVO> readMy(String userid);
}
