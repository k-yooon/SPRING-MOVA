package com.mova.controller;

import org.springframework.security.access.prepost.PreAuthorize;
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
import com.mova.domain.RecommendBoardVO;
import com.mova.service.RecommendBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/recommend/*")
@AllArgsConstructor
public class RecommendBoardController {

	private RecommendBoardService recommendBoardService;

	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		log.info("list");
		model.addAttribute("list", recommendBoardService.getList(cri));

		// 전체 데이터 개수를 가지고 와서 total에 저장
		int total = recommendBoardService.getTotalCount(cri);
		log.info("total count : " + total); // 전체 데이터 개수 로그로 기록
		// 모델 객체 pageMaker의 값을 실제 총 데이터 개수로 지정해서 저장
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	
	// 게시물 삭제하기
	// @PreAuthorize("principal.username == #userid")
	@PostMapping("/remove")
	public String remove(String userid, @RequestParam("reno") int reno, 
										@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		log.info("remove : " + reno);

		if (recommendBoardService.remove(reno)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/recommend/list";
	}

	// 등록창 보여주기
	@GetMapping("/register")
	public void register() {

	}

	// 등록 하기
	@PostMapping("/register")
	public String register(RecommendBoardVO reboard, RedirectAttributes rttr) {
		log.info("register : " + reboard);
		recommendBoardService.register(reboard);
		rttr.addFlashAttribute("result", reboard.getReno());
		return "redirect:/recommend/list";
	}

	// 게시물 하나 가져오기
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("reno") int reno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify : " + reno);
		model.addAttribute("recommend", recommendBoardService.get(reno));
	}

	// 게시물 수정하기
	// @PreAuthorize("principal.username == #recommend.userid")
	@PostMapping("/modify")
	public String modify(RecommendBoardVO re, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify : " + re);

		if(recommendBoardService.modify(re)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/recommend/list";
	}

}
