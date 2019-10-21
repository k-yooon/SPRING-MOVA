package com.mova.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.MemberVO;
import com.mova.domain.MovieAttachVO;
import com.mova.domain.MovieVO;
import com.mova.domain.PageDTO;
import com.mova.domain.WishVO;
import com.mova.mapper.MemberMapper;
import com.mova.mapper.MovieAttachMapper;
import com.mova.mapper.MovieMapper;
import com.mova.mapper.WishMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MovieServiceImpl implements MovieService {
	private MovieMapper movieMapper;
	private MemberMapper memberMapper;
	private WishMapper wishMapper;
	private MovieAttachMapper attachMapper;
	
	//영화목록
		@Override
		public List<MovieVO> getList(Criteria cri) {
			return movieMapper.getListWithPaging(cri);
		}
		
		@Override
		public int getTotal(Criteria cri) {
			return movieMapper.getTotalCount(cri);
		}

		//영화등록
		@Override
		@Transactional
		public void register(MovieVO movie) {
			log.info("register..... : " + movie);
			movieMapper.insert(movie);
			if(movie.getMovieList() == null || movie.getMovieList().size() <= 0) {
				return;
			}
			movie.getMovieList().forEach(attach -> {
				attach.setMno(movie.getMno());
				attachMapper.insert(attach);
			});
		}
		
			
		//영화 조회
		@Override
		public MovieVO get(int mno) {
			return movieMapper.read(mno);
		}

		//첨부파일조회
		@Override
		public List<MovieAttachVO> getAttachList(int mno) {
			log.info("atttttttt");
			return attachMapper.findByMno(mno);
		}
		//영화 수정
		@Transactional
		@Override
		public boolean modify(MovieVO movie) {
			int result = movieMapper.deleteAll(movie.getMno());
			log.info("DELETE!!!!!" + movie.getMno());
			boolean modifyResult = false;
			if(result == 1) {
				log.info("result!!!!!" + result);
				attachMapper.deleteAll(movie.getMno());	//첨부파일 모두 삭제
				modifyResult = movieMapper.update(movie) == 1;//수정 처리
				if(modifyResult == true 
				   && movie.getMovieList() != null		  //수정에 성공하고
				   && movie.getMovieList().size() > 0) { //첨부파일 목록이 있으면
						movie.getMovieList().forEach(attach -> {
						attach.setMno(movie.getMno());
						attachMapper.insert(attach);	  //첨부파일 등록
					});
				}
			}	
			return modifyResult;
		}
		
		//영화 포스터 수정
		@Override
		public boolean postermodify(MovieVO movie) {
			return false;
		}

		//영화 삭제
		@Override
		public boolean remove(int mno) {
			attachMapper.deleteAll(mno);
			return movieMapper.delete(mno) == 1;
		}


	@Override
	public List<MovieVO> getRecommendMovie(String userid) {
		return movieMapper.getRecommendMovie(userid);
	}
	
	@Override
	public List<MovieVO> getMovieNation(String userid) {
		return movieMapper.getMovieNation(userid);
	}
	
	@Override
	public int getNationCt() {
		return movieMapper.getNationCt();
	}

	@Override
	public List<CommentVO> getGenre(String userid) {
		return movieMapper.getGenre(userid);
	}
	
	@Override
	public List<MovieVO> getMovieStar() {
		return movieMapper.getMovieStar();
	}

	@Override
	public List<MovieVO> getMovieGenre(String genre) {
		return movieMapper.getMovieGenre(genre);
	}

	@Override
	public MovieVO getMovie(int mno) {
		MovieVO mvo = movieMapper.readMovie(mno);
		return mvo;
	}

	@Override
	public List<MovieVO> getMovieSearch(Criteria cri) {
		return movieMapper.getMovieSearch(cri);
	}

	@Override
	public List<MemberVO> getUserSearch(Criteria cri) {
		return memberMapper.getUserSearch(cri);
	}

	@Override
	public int wish(WishVO wish) {
		log.info("wish : " + wish);
		int result = wishMapper.wishInsert(wish);
		return result;
	}

	@Override
	public int wishRemove(int mno, String userid) {
		log.info("wishRemove");
		return wishMapper.wishDelete(mno, userid);
	}

	@Override
	public WishVO wishCheck(int mno, String userid) {
		log.info("wishcheck");
		return wishMapper.read(mno, userid);
	}

	@Override
	public List<WishVO> myWish(String userid) {
		log.info("myWish" + userid);
		return wishMapper.readMy(userid);
	}

	@Override
	public List<MovieVO> genreGetByAge(int start, int end) {
		return movieMapper.genreGetByAge(start, end);
	}

	@Override
	public List<MovieVO> movieGetByAge(int start, int end) {
		return movieMapper.movieGetByAge(start, end);
	}

	

	


}
