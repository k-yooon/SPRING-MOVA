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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.EventVO;
import com.mova.domain.MemberVO;
import com.mova.domain.MovieAttachVO;
import com.mova.domain.PageDTO;
import com.mova.domain.WishVO;
import com.mova.service.EventService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/event/*")
@AllArgsConstructor
public class EventController {
	private EventService eventService;
	
	//이벤트 리스트
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/eventList")
	public void eventList(Criteria cri, Model model) {
		log.info("list" + cri);
		model.addAttribute("list", eventService.getList(cri));
		int total = eventService.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/eventRegister")
	public void eventRegister(Model model) {
	}
	
	//이벤트 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/eventRegister")
	public String movieregister(RedirectAttributes rttr, EventVO event) {
		log.info("register : " + event);
		eventService.register(event);
		rttr.addFlashAttribute("result", event.getEno());
		return "redirect:/event/ingEvent";
	}
	
	//현재 진행중인 이벤트 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/ingEvent")
	public void ingEvent(Model model) {
		log.info("ingEvent");
		model.addAttribute("event", eventService.ingEvent());
	}
	
	//이벤트 삭제
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/eventRemove/{eno}")
	@ResponseBody
	public ResponseEntity<String> wishremove(@PathVariable("eno") int eno) {
		log.info("remove : " + eno);
		return eventService.remove(eno)? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//이벤트 참여
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/eventJoin", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> eventJoin(@RequestBody EventVO event) {
		return eventService.eventJoin(event) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//이벤트 참여 확인 
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/eventChk/{eno}/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<EventVO> eventChk(@PathVariable("eno") int eno, @PathVariable("userid") String userid) {
		log.info("eventChk..........");
		return new ResponseEntity<>(eventService.eventChk(eno, userid), HttpStatus.OK);
	}
	
	//추첨할 이벤트 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/eventPick")
	public void evnetPick(Model model) {
		log.info("evnetPick");
		model.addAttribute("event", eventService.pickEvent());
	}
	
	//당첨자 추첨
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/pickMember/{eno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> pickMember(@PathVariable("eno") int eno) {
		log.info("pickMember..........");
		return eventService.pickMember(eno) == true? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//당첨자 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/getPickMem/{eno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<MemberVO>> getPickMem(@PathVariable("eno") int eno) {
		log.info("getPickMem..........");
		return new ResponseEntity<>(eventService.getPickMem(eno), HttpStatus.OK);
	}
	
	//추첨된 이벤트 게시글 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/eventGet")
	public void eventget(@RequestParam("eno") int eno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("eventGet");
		model.addAttribute("event", eventService.get(eno));
		List<MemberVO> member = eventService.getPickMem(eno);
		for(int i = 0; i < member.size(); i++) {
			member.get(i).setTel(member.get(i).getTel().substring(7));
		}
		model.addAttribute("member", member);
	}
	
}
