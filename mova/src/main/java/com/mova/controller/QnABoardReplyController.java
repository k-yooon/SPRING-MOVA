package com.mova.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mova.domain.Criteria;
import com.mova.domain.QnAReplyVO;
import com.mova.service.QnABoardReplyService;
import com.mova.service.QnABoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/replies/")
public class QnABoardReplyController {
	
	private QnABoardReplyService qnaRService;
	//답글 등록
	/*
	 * @GetMapping("/new") public void create() {
	 * 
	 * }
	 */
	
	@PostMapping(value="/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody QnAReplyVO qnareply){
		log.info("QnAReplyVO" + qnareply);
		
		int insertCount = qnaRService.register(qnareply);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	//댓글 목록 보기
	@GetMapping(value = "/pages/{qno}/{page}" , produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE}) 
	public ResponseEntity<List<QnAReplyVO>> getList ( @PathVariable("page") int page, @PathVariable("qno") int qno ){
		
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(qnaRService.getList(cri, qno), HttpStatus.OK);
		
	}
	
	//댓글 조회
	@GetMapping(value = "/{qreno}",  produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<QnAReplyVO> get(@PathVariable("qreno") int qreno){
		
		
		return new ResponseEntity<>(qnaRService.get(qreno), HttpStatus.OK);
		
	}
	
	//댓글 삭제
	@DeleteMapping(value = "/{qreno}",  produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<String> remove(@RequestBody QnAReplyVO vo, @PathVariable("qreno") int qreno){
			log.info("DELETE CONTROLLER");
			
			return qnaRService.remove(qreno) == 1
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			
	}
		
	//댓글수정
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
					value = "/{qreno}",
					consumes = "application/json",
				    produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody QnAReplyVO qnaboard,
								         @PathVariable("qreno") int qreno){
		log.info("modify qreno : " + qreno);
		log.info("vo : " + qnaboard);
		qnaboard.setQreno(qreno);
		int modCount = qnaRService.modify(qnaboard);	//댓글 수정
		
		if(modCount == 1) {	//modCount가 1이면 수정 성공
			return new ResponseEntity<>("success", HttpStatus.OK); //HttpStatus 200 반환
		} else {	//실패하면						   //500반환
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
//	
//	//특정 댓글 삭제
//	@DeleteMapping(value = "/{qno}",
//		    	   produces = { MediaType.TEXT_PLAIN_VALUE })
//	public ResponseEntity<String> remove(@RequestBody QnAReplyVO vo,
//										 @PathVariable("qno") int qno){
//		log.info("remove : " + qno);
//		int delCount = qnaRService.remove(qno);	//댓글 삭제
//		
//		if(delCount == 1) {	//delCount가 1이면 삭제 성공
//			return new ResponseEntity<>("success", HttpStatus.OK); //HttpStatus 200 반환
//		} else {	//실패하면						   //500반환
//			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
	
	//	//답글 삭제
//	@DeleteMapping(value = "/{rno}")
//	public String remove(){
//		return "redirect:/qna/get";
//	}
//	
//	
//	//답글 수정
//	@GetMapping(value = "/{rno}")
//	public void modify() {
//		
//	}
//	
//	@PutMapping(	value = "/{rno}")
//	public String modify(Model model){
//		return "redirect:/qna/get";
//	}
}
