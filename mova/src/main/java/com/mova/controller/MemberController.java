package com.mova.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
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

import com.mova.domain.CommJoaVO;
import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.FollowVO;
import com.mova.domain.MemberVO;
import com.mova.domain.PageDTO;
import com.mova.domain.QnABoardVO;
import com.mova.domain.RecommendBoardVO;
import com.mova.domain.WishVO;
import com.mova.service.CommentService;
import com.mova.service.MemberService;
import com.mova.service.MovieService;
import com.mova.service.QnABoardService;
import com.mova.service.RecommendBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller	
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MovieService movieService;
	private CommentService commentService;
	private MemberService memberService;
	private QnABoardService qnaboardService;
	private RecommendBoardService recommendBoardService;
	//찜하기 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/wish", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> wish(@RequestBody WishVO wish) {
		log.info(wish);
		int insertcount = movieService.wish(wish);
		log.info("insertcount : " + insertcount);
		return insertcount == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//찜하기 체크
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/wish/{mno}/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<WishVO> wishCheck(@PathVariable("mno") int mno, @PathVariable("userid") String userid){
		log.info("get : " + mno + userid);
		return new ResponseEntity<>(movieService.wishCheck(mno, userid), HttpStatus.OK);
	}
	
	//찜하기 삭제
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/wish/{mno}/{userid}")
	@ResponseBody
	public ResponseEntity<String> wishremove(@PathVariable("mno") int mno, @PathVariable("userid") String userid) {
		log.info("remove : " + mno + userid);
		return movieService.wishRemove(mno, userid) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//코멘트 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/commentList/{mno}/{keyword}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<CommentVO>> commentlist(@PathVariable("mno") int mno, @PathVariable("keyword") String keyword) {
		log.info("commentList..........");
		return new ResponseEntity<>(commentService.getList(mno, keyword), HttpStatus.OK);
	}
	
	//코멘트 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/commentRegister", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<String> commentregister(@RequestBody CommentVO comment) {
		log.info("commentregister : " + comment);
		int insertcount = commentService.register(comment);
		return insertcount == 1? new ResponseEntity<>("코멘트가 등록되었습니다.", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//코멘트 신고
    @PostMapping(value = "/commreport/{cno}/{reporter}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
    @ResponseBody
    public ResponseEntity<String> commentreport(@PathVariable("cno") int cno, @PathVariable("reporter") String reporter ) {
       log.info("Comment No." + cno);
       int insertcount = commentService.report(cno, reporter);
       return insertcount == 1? new ResponseEntity<>("코멘트가 신고되었습니다.", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
	//나의 코멘트 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/myCommentList/{mno}/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<CommentVO> getMyComm(@PathVariable("mno") int mno, @PathVariable("userid") String userid){
		log.info("get : " + mno + userid);
		return new ResponseEntity<>(commentService.getMyComm(mno, userid), HttpStatus.OK);
	}
	
	//코멘트삭제
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/commentRemove/{cno}")
	@ResponseBody
	public ResponseEntity<String> commentremove(@PathVariable("cno") int cno) {
		log.info("commentremove : " + cno);
		return commentService.remove(cno) == 1? new ResponseEntity<>("코멘트를 삭제했습니다.", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//코멘트수정
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/commentModify/{cno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> commentmodify(@RequestBody CommentVO comment, @PathVariable("cno") int cno) {
		comment.setCno(cno);
		log.info("modify cno : " + cno);
		log.info("modify : " + comment);
		return commentService.modify(comment) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//코멘트 좋아요 추가
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/addJoa/{cno}/{userid}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> addCommJoa(@PathVariable("cno") int cno, @PathVariable("userid") String userid) {
		return commentService.addCommJoa(userid, cno) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//코멘트 좋아요 체크
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/chkJoa/{mno}/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<CommJoaVO>> chkCommJoa(@PathVariable("mno") int mno, @PathVariable("userid") String userid){
		return new ResponseEntity<>(commentService.chkCommJoa(userid, mno), HttpStatus.OK);
	}
	
	//코멘트 좋아요 삭제
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/removeJoa/{cno}/{userid}")
	@ResponseBody
	public ResponseEntity<String> deleteCommjoa(@PathVariable("cno") int cno, @PathVariable("userid") String userid) {
		return commentService.deleteCommjoa(userid, cno) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
		
	//팔로우 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/followRegister", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE}) 
	@ResponseBody
	public  ResponseEntity<String> followregister(@RequestBody FollowVO follow) {
		log.info(follow);
		int insertcount = commentService.follow(follow);
		return insertcount == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//팔로우 체크
	@GetMapping(value = "/follow/{follower}/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<FollowVO> followCheck(@PathVariable("follower") String follower, @PathVariable("userid") String userid){
		log.info("followCheck : " + userid + follower);
		return new ResponseEntity<>(commentService.followCheck(userid, follower), HttpStatus.OK);
	}
	
	//팔로우 삭제
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping("/follow/{follower}/{userid}") 
	@ResponseBody
	public ResponseEntity<String> followremove(@PathVariable("follower") String follower, @PathVariable("userid") String userid) {
		log.info("followremove : " + userid + follower);
		return commentService.followRemove(userid, follower) == 1? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//팔로잉, 팔로워 조회
	@GetMapping(value = "/followList/{userid}/{no}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<FollowVO>> followList(@PathVariable("userid") String userid, @PathVariable("no") int no) {
		log.info("followList..........");
		if(no == 1) {
			return new ResponseEntity<>(commentService.getFollowing(userid), HttpStatus.OK);
		} else if(no == 2) {
			return new ResponseEntity<>(commentService.getFollower(userid), HttpStatus.OK);
		}
		return null;
	}
	
	//팔로잉 총 개수
	@GetMapping(value = "/following/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<FollowVO> followingCount(@PathVariable("userid") String userid){
		log.info("followingCount : " + userid);
		return new ResponseEntity<>(commentService.followingCount(userid), HttpStatus.OK);
	}
	
	//팔로워 총 개수
	@GetMapping(value = "/follower/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<FollowVO> followerCount(@PathVariable("userid") String userid){
		log.info("followerCount : " + userid);
		return new ResponseEntity<>(commentService.followerCount(userid), HttpStatus.OK);
	}
		
	
	//회원 정보 및 별점별 영화 조회
	   @PreAuthorize("isAuthenticated()")
	   @GetMapping("/mypage")
	   public void mypage(@RequestParam("userid") String userid, @RequestParam("star") int star, Model model) {
	      model.addAttribute("user", memberService.getmember(userid));
	   }
		
	//나의 영화 목록
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/mymovie/{userid}/{star}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public ResponseEntity<List<MemberVO>> mymovie(@PathVariable("userid") String userid, @PathVariable("star") int star){
	   log.info("mymovie");
	   log.info("userid : " + userid);
	   log.info("star : " + star);
	         
	   List<MemberVO> list = memberService.memberInfo(userid, star);
	   return  new ResponseEntity<>(list, HttpStatus.OK);
	  }
	   
	  //회원 정보 수정페이지 이동
	@PreAuthorize("isAuthenticated()")
    @GetMapping( {"/infoModify"} )
    public void infoModify(@RequestParam("userid") String userid, Model model, MemberVO vo) {
       
       log.info("infoModify");
       
       model.addAttribute("vo", memberService.memberInfo2(userid));
       
       log.info("이름 : " + memberService.memberInfo2(userid).getUsernm());
       
    }
   //회원 정보 수정
    @PreAuthorize("isAuthenticated()")
   @PostMapping("/infoModify")
   public String infoModify(MemberVO vo, RedirectAttributes rttr) {
      log.info("postMapping modify : " + vo);

      String hashPassword = BCrypt.hashpw(vo.getUserpw(), BCrypt.gensalt());
      vo.setUserpw(hashPassword);//암호화 저장
      
      if (memberService.memberModify(vo)) {
         rttr.addFlashAttribute("result", "success");
      }

     return "redirect:/member/mypage?userid=" + vo.getUserid() + "&star=5";
    }
    
    // 회원 정보 삭제(탈퇴)
    @GetMapping("/remove")
 	public String remove(@RequestParam("userid") String userid, RedirectAttributes rttr) {
 		log.info("잘 가시게 " + userid);
 		if(memberService.memberRemove(userid)) {
 			rttr.addFlashAttribute("result", "success");
 		}
 		log.info( userid + " : 만나서 반가웠고 다시는 만나지 말자~~");
 		return "redirect:/logout";
 	}
 	
 	// 회원 정보 삭제(관리자 탈퇴)
  	@GetMapping("/remove2")
  	public String remove2(@RequestParam("userid") String userid, RedirectAttributes rttr) {
  		
  		log.info("잘 가시게 " + userid);

  		if(memberService.memberRemove(userid)) {
  			rttr.addFlashAttribute("result", "success");
  		}
  		log.info( userid + " : 만나서 반가웠고 다시는 만나지 말자~~");
  		return "redirect:/";
  	}
	
	
	//나의 게시글 조회
	@PreAuthorize("isAuthenticated()")
	   @GetMapping("/myBoardList")
	   public void myBoardList() {
	            
	   }
	         
	   //문의 게시글 조회
	   @GetMapping(value = "/myBoard/{userid}",
	            produces = { MediaType.APPLICATION_XML_VALUE,
	                      MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public ResponseEntity<List<QnABoardVO>> myBoardList(@PathVariable("userid") String userid){
	      log.info("QNAboard");
	      List<QnABoardVO> list = qnaboardService.getMyList(userid);
	      return new ResponseEntity<>(list, HttpStatus.OK);
	   }
	      
	      
	   //추천 게시글 조회
	   @GetMapping(value = "/myRecommBoard/{userid}",
	            produces = { MediaType.APPLICATION_XML_VALUE,
	                      MediaType.APPLICATION_JSON_UTF8_VALUE })
	   @ResponseBody
	   public ResponseEntity<List<RecommendBoardVO>> myRecommList(@PathVariable("userid") String userid){
	      log.info("Recommboard");
	      List<RecommendBoardVO> list = recommendBoardService.getMyList(userid);
	         
	         
	      return new ResponseEntity<>(list, HttpStatus.OK);
	   }
	
	//찜한 영화 조회
	@GetMapping("/wishList")
	public void wishlist(@RequestParam("userid") String userid, Model model) {
		log.info("wishlist: " + userid);
		model.addAttribute("wish", movieService.myWish(userid));
	}
	
	//나의 코멘트 조회 페이지(마이리스트)
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/commentList")
	public void commentList() {
		
	}
	
	//나의 코멘트 조회(마이리스트)
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/allMyCommentList/{userid}/{keyword}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<CommentVO>> myCommentList(@PathVariable("userid") String userid, @PathVariable("keyword") String keyword) {
		log.info("myCommentList..........");
		return new ResponseEntity<>(commentService.getMyAllComm(userid, keyword), HttpStatus.OK);
	}
	
	//팔로잉,팔로워조회
	@GetMapping("/followList")
	public void followlist(Model model) {
		
	}
	
	//회원 정보 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/memberManage")
	public void membermanage(Model model) {
		
	}
	
	//회원 정보 조회(관리자)
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/memberManage/{userid}" , produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<MemberVO> get(@PathVariable("userid") String userid) {
			log.info(userid);
			return new ResponseEntity<>(memberService.get(userid), HttpStatus.OK);	
		}
	
	//데이터 전송
    @GetMapping("/display")
    @ResponseBody
    public ResponseEntity<byte[]> getFile(String fileName){
       log.info("fileName : " + fileName);
       
       File file = new File(fileName);
       
       ResponseEntity<byte[]> result = null;
       
       try {
          HttpHeaders header = new HttpHeaders();
          header.add("Content-Type", Files.probeContentType(file.toPath()));
          result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
       } catch (IOException e) {
          e.printStackTrace();
       }
       
       return result;
    }
	
}
