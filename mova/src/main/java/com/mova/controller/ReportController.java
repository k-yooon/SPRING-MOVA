package com.mova.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mova.domain.Criteria;
import com.mova.domain.PageDTO;
import com.mova.domain.ReportBestSceneVO;
import com.mova.service.BestSceneService;
import com.mova.service.CommentService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@AllArgsConstructor
public class ReportController {
   private BestSceneService bestsceneService;
   private CommentService commentService;

   @PreAuthorize("isAuthenticated()")
   @DeleteMapping(value = "/reportRe/{bsno}", produces = { MediaType.TEXT_PLAIN_VALUE })
   @ResponseBody
   public ResponseEntity<String> reportremove(@PathVariable("bsno") int bsno) {
      log.info("BestScene Remove No." + bsno);
      int delCount = bestsceneService.remove(bsno); // 댓글 삭제
      if (delCount == 1) { // delCount가 1이면 삭제 성공
         log.info("BestScene Remove Success !");
         return new ResponseEntity<>("success", HttpStatus.OK); // HttpStatus 200 반환
      } else { // 실패하면 //500반환
         return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
   }
   
 //명대사&명장면 신고 목록 조회
   		@PreAuthorize("isAuthenticated()")
 		@GetMapping("/bestreportList")
 		public void bestreportList(Model model, Criteria cri) {
 			
 			log.info("ReportBestScene List");
 			model.addAttribute("list", bestsceneService.getReportList(cri));
 			model.addAttribute("pageMaker", new PageDTO(cri, 123));
 										   //전체 데이터 수는 임의로 123으로 지정
 			//전체 데이터 개수를 가지고 와서 total에 저장
 			int total = bestsceneService.getTotal(cri);
 			log.info("total count : " + total);	//전체 데이터 개수 로그로 기록
 			//모델 객체 pageMaker의 값을 실제 총 데이터 개수로 지정해서 저장
 			model.addAttribute("pageMaker", new PageDTO(cri, total));
 		
 		}
   		
 		//코멘트 신고 목록 조회
   		@PreAuthorize("isAuthenticated()")
 		@GetMapping("/commreportList")
 		public void reportlist(Model model, Criteria cri) {
 			log.info("ReportCommentScene List");
 			model.addAttribute("list2", commentService.getReportList(cri));
 			model.addAttribute("pageMaker", new PageDTO(cri, 123));
 			int total2 = commentService.getReportCommTotal(cri);
 			log.info("total count : " + total2);	//전체 데이터 개수 로그로 기록
 			//모델 객체 pageMaker의 값을 실제 총 데이터 개수로 지정해서 저장
 			model.addAttribute("pageMaker", new PageDTO(cri, total2));
 		}
   		
   	 //코멘트 삭제	
   	 @PreAuthorize("isAuthenticated()")
     @DeleteMapping(value = "/reportComm/{cno}", produces = { MediaType.TEXT_PLAIN_VALUE })
     @ResponseBody
     public ResponseEntity<String> reportRemove(@PathVariable("cno") int cno) {
        log.info("Comment Remove No." + cno);
        int delCount = commentService.remove(cno); 
        if (delCount == 1) { // delCount가 1이면 삭제 성공
           log.info("Comment Remove Success !");
           return new ResponseEntity<>("success", HttpStatus.OK); // HttpStatus 200 반환
        } else { // 실패하면 //500반환
           return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
     }
   	 
   	 //신고된 코멘트 목록에서만 삭제
   	@PreAuthorize("isAuthenticated()")
    @DeleteMapping(value = "/deleteReport/{rcno}", produces = { MediaType.TEXT_PLAIN_VALUE })
    @ResponseBody
    public ResponseEntity<String> deleteReport(@PathVariable("rcno") int rcno) {
       log.info("Comment Remove No." + rcno);
       if (commentService.deleteInList(rcno) == 1) { // delCount가 1이면 삭제 성공
          log.info("ReportList Remove Success !");
          return new ResponseEntity<>("success", HttpStatus.OK); // HttpStatus 200 반환
       } else { // 실패하면 //500반환
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
       }
    }
}