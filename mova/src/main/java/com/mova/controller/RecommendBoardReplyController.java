package com.mova.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.mova.domain.Criteria;
import com.mova.domain.RecommendBoardReplyVO;
import com.mova.domain.ReplyPageDTO;
import com.mova.service.RecommendBoardReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RequestMapping("/rereplies/")
@RestController
@Log4j
@AllArgsConstructor
public class RecommendBoardReplyController {
	
	private RecommendBoardReplyService reservice;
	
	//특정 게시물의 댓글 목록
	@GetMapping(value = "/pages/{reno}/{page}",
			    produces = { MediaType.APPLICATION_XML_VALUE,
			    		     MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<RecommendBoardReplyVO>> getList(
	public ResponseEntity<ReplyPageDTO> getList(
							@PathVariable("page") int page,
							@PathVariable("reno") int reno){
		log.info("getList...............");
		Criteria cri = new Criteria(page, 10);
		log.info("cri : " + cri);
		
		return  new ResponseEntity<>(reservice.getListPage(cri, reno), HttpStatus.OK);
//		return  new ResponseEntity<>(reservice.getListPage(cri, reno), HttpStatus.OK);
	}

	
	//특정 댓글 조회
	@GetMapping(value = "/{rereno}",
		    produces = { MediaType.APPLICATION_XML_VALUE,
		    		     MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<RecommendBoardReplyVO> get(
							@PathVariable("rereno") int rereno){
		log.info("get......... : " + rereno);
		return  new ResponseEntity<>(reservice.get(rereno),
					                 HttpStatus.OK);
	}

	
	
	  //댓글 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody RecommendBoardReplyVO vo){
		log.info("ReplyVO : " + vo);
		
	int insertCount = reservice.register(vo);	//댓글 등록
		
		log.info("Reply INSERT COUNT : " + insertCount);
	
		if(insertCount == 1) {	//insertCount가 1이면 등록 성공
												   //HttpStatus 200 반환
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {	//실패하면						   //500반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	
	//댓글 수정
	
	@PutMapping(value = "/{rereno}")
	public ResponseEntity<String> modify(@RequestBody RecommendBoardReplyVO vo,
	         							@PathVariable("rereno") int rereno){
		log.info("modify rereno : " + rereno);
		log.info("vo : " + vo);
		vo.setReno(rereno);
		int modCount = reservice.modify(vo);	//댓글 수정
		
		if(modCount == 1) {	//modCount가 1이면 수정 성공
			return new ResponseEntity<>("success", HttpStatus.OK); //HttpStatus 200 반환
		} else {	//실패하면						   //500반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
			}
	
	
	//특정 댓글 삭제
	
	@DeleteMapping(value = "/{rereno}",
	    	   produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove( @RequestBody RecommendBoardReplyVO vo,
			 @PathVariable("rereno") int rereno){
			log.info("remove : " + rereno);
			int delCount = reservice.remove(rereno);	//댓글 삭제
			
			if(delCount == 1) {	//delCount가 1이면 삭제 성공
				return new ResponseEntity<>("success", HttpStatus.OK); //HttpStatus 200 반환
			} else {	//실패하면						   //500반환
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
		// return "redirect:/recommend/get";
	}
	
	
	
	
}
