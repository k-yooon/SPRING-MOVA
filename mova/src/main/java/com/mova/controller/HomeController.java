package com.mova.controller;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mova.domain.MemberVO;
import com.mova.domain.MovieVO;
import com.mova.service.MemberService;
import com.mova.service.MovieService;

import lombok.AllArgsConstructor;


/**
 * Handles requests for the application home page.
 */
@Controller
@AllArgsConstructor
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private MemberService memberService;
	private MovieService movieService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	//로그인
	@GetMapping("/login")
	public void login(String error, Model model) {
		if(error != null) {
			model.addAttribute("error", "error.");
		}
		
	}

	//회원가입 페이지 & 회원사진 업로드	
	@GetMapping("/join")
	public void joinGet() {
		logger.info("join!");
		logger.info("upload ajax member photo");
	}
			
		//회원가입  & 회원사진 업로드	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String join(@ModelAttribute @Validated MemberVO rVO, BindingResult result, HttpSession session){
		logger.info("join success!" + rVO);
		String hashPassword = BCrypt.hashpw(rVO.getUserpw(), BCrypt.gensalt());
		rVO.setUserpw(hashPassword);//암호화 저장
			
		//회원가입 메서드
		memberService.join(rVO);
		logger.info("join!");
		return "redirect:/login";
	}

	@PostMapping("/join/uploaduser")
	public void uploadAjaxMemberPost(File uploadFile) {
		String uploadFolder = "C:\\upload\\user";
		logger.info("-------------------");
		logger.info("Upload File Name : " + uploadFile);
	}
			
			
	//로그아웃
	@GetMapping("/logout") 
	public void logoutGet() {}
	 
	@PostMapping("/logout")
	public String logoutPost() {
		logger.info("로그아웃");
		return "redirect:/";
	}

	//ID 찾기
	@GetMapping("/idFind")
	public void idfindGet(){
		logger.info("Find Id");
	}
	
	@GetMapping(value = "/idFind/{usernm}/{tel}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<MemberVO> idFind(@PathVariable("usernm") String usernm, @PathVariable("tel") String tel) {
		logger.info("idFind");
		return new ResponseEntity<>(memberService.idFind(usernm, tel), HttpStatus.OK);	
	} 

	//PW 찾기
	@GetMapping("/pwFind")
	public void pwfindGet(){
		logger.info("Find pw");
	}
	
	@GetMapping(value = "/pwFind/{userid}/{tel}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<MemberVO> pwFind(@PathVariable("userid") String userid, @PathVariable("tel") String tel) {
		logger.info("idFind");
		return new ResponseEntity<>(memberService.pwFind(userid, tel), HttpStatus.OK);	
	} 
	
	//pw 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/pwUpdate/{userid}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> pwModify(@RequestBody MemberVO member, @PathVariable("userid") String userid){
		logger.info("pwModify : " + userid);
		String hashPassword = BCrypt.hashpw(member.getUserpw(), BCrypt.gensalt());
		member.setUserpw(hashPassword);
		return memberService.pwUpdate(member) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//아이디 중복 체크
	@GetMapping(value = "/idChk", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<MemberVO>> readAll(){
		logger.info("readAll..........");
		return new ResponseEntity<>(memberService.readAll(), HttpStatus.OK);
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		logger.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	//선호도 분석 (장르)
	@GetMapping(value = "/genre/{start}/{end}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<MovieVO>> genreGetByAge(@PathVariable("start") int start, @PathVariable("end") int end){
		logger.info("GenreGetByAge" + start + " + " + end);
		return new ResponseEntity<>(movieService.genreGetByAge(start, end), HttpStatus.OK);
	}
	
	//선호도 분석(영화)
	@GetMapping(value = "/movie/{start}/{end}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<MovieVO>> movieGetByAge(@PathVariable("start") int start, @PathVariable("end") int end){
		logger.info("GenreGetByAge" + start + " + " + end);
		return new ResponseEntity<>(movieService.movieGetByAge(start, end), HttpStatus.OK);
	}
	
}
