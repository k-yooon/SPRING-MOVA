package com.mova.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mova.domain.Criteria;
import com.mova.domain.PageDTO;
import com.mova.domain.QnABoardVO;
import com.mova.service.QnABoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/qna/*")
public class QnABoardController {
	
	private QnABoardService qnaService;
	
	//문의게시판 목록
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		
		model.addAttribute("list", qnaService.getList(cri));
	
		int total = qnaService.getTotal(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//문의게시판 등록
	@GetMapping("/register")
	public void register() { 
		
	} 
	
	
	@PostMapping("/register")
	public String register(RedirectAttributes rttr, QnABoardVO qna) {
		
		qnaService.register(qna);
		
		rttr.addFlashAttribute("result", qna.getQno());
		
		return "redirect:/qna/list";
	}
	//문의게시판 게시글 조회
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("qno") int qno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute("qna", qnaService.get(qno));
	}
	//문의게시판 게시글 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("qno") int qno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		qnaService.remove(qno);
		
		rttr.addFlashAttribute("result", "success");
		rttr.addFlashAttribute("pageNum", cri.getPageNum());
		rttr.addFlashAttribute("amount", cri.getAmount());
		return "redirect:/qna/list";
	}

	

	@PostMapping({"/modify"})
	public String modify(QnABoardVO qnaboard, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("moviemodify : " + qnaboard);
		qnaService.modify(qnaboard);
		rttr.addFlashAttribute("result", "success");
		rttr.addFlashAttribute("pageNum", cri.getPageNum());
		rttr.addFlashAttribute("amount", cri.getAmount());
		
		return "redirect:/qna/list";
	}
	
	  @PostMapping("/answer") public String answer (QnABoardVO qnaboard,@RequestParam("qno") int qno, RedirectAttributes rttr) {
		  qnaService.answer(qnaboard);
		rttr.addFlashAttribute("result", "success");
		  log.info(qno); 
		  log.info("AAA");
	  
	  return "redirect:/qna/list"; 
	  }
	 
	
}
