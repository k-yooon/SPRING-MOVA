package com.mova.mapper;

import java.util.List;

import com.mova.domain.MovieAttachVO;

public interface MovieAttachMapper {
	public void insert(MovieAttachVO vo);
	
	public void delete(String uuid);
	
	public List<MovieAttachVO> findByMno(int mno);
	
	//첨부파일삭제처리
	public void deleteAll(int mno);
}
