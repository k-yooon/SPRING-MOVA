package com.mova.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mova.domain.AttachVO;
import com.mova.domain.BestSceneVO;
import com.mova.domain.CommentVO;
import com.mova.domain.Criteria;
import com.mova.domain.MovieAttachVO;
import com.mova.domain.MovieVO;
import com.mova.domain.PageDTO;
import com.mova.service.BestSceneService;
import com.mova.service.CommentService;
import com.mova.service.MovieService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;


@Controller
@Log4j
@RequestMapping("/movie/*")
@AllArgsConstructor
public class MovieController {
	private MovieService movieService;
	private CommentService commentService;
	private BestSceneService bestsceneService;
	
	public static String encodeURI(String value) throws UnsupportedEncodingException {
		System.out.println("encode : " + value);
		String uri = URLEncoder.encode(value, "UTF-8");
		return uri;
	}
	
	//영화검색
	@GetMapping("/movieSearch")
	public void moviesearch(Criteria cri, Model model) {
		log.info("movieSearch: " + cri);
		if(cri.getType().equals("U")) {
			model.addAttribute("member", movieService.getUserSearch(cri));
		} else {
			model.addAttribute("list", movieService.getMovieSearch(cri));
		}
		
	}
	
	//장르별 영화조회
	@GetMapping("/movieTagGet")
	public void movietagget(Model model, @RequestParam("genre") String genre) {
		log.info("movieTagGet: " + genre);
		if(genre.equals("별점")) {
			model.addAttribute("list", movieService.getMovieStar());
		} else {
			model.addAttribute("list", movieService.getMovieGenre(genre));
		}
	}
	
	//영화 정보 조회
	@GetMapping("/movieInfo")
	public void movieinfo(@RequestParam("mno") int mno, Model model) {
		log.info("movieInfo: " + mno);
		model.addAttribute("movie", movieService.getMovie(mno));
	}
	
	//명장면,명대사 조회
    @GetMapping(value = "/bestList/{mno}/{userid}",
          produces = { MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE })
    @ResponseBody
    public ResponseEntity<List<BestSceneVO>> getList(@PathVariable("mno") int mno, @PathVariable("userid") String userid){
       log.info("bestList");
       List<BestSceneVO> list = bestsceneService.getList(mno, userid);
       log.info(list);
       return new ResponseEntity<>(list, HttpStatus.OK);
    }
    
    //나의 명명 조회
    @GetMapping(value = "/get/{bsno}", 
             produces = {MediaType.APPLICATION_XML_VALUE, 
                      MediaType.APPLICATION_JSON_UTF8_VALUE})
    @ResponseBody
    public ResponseEntity<BestSceneVO> getMyComm(@PathVariable("bsno") int bsno){
       log.info("get : " + bsno);
       return new ResponseEntity<>(bestsceneService.get(bsno), HttpStatus.OK);
    }
    
    //명장면,명대사 등록
    @PreAuthorize("isAuthenticated()")
    @PostMapping(value="/bestNew",            //POST 방식
            consumes = "application/json",   //JSON 데이터
            produces = { MediaType.TEXT_PLAIN_VALUE })
    @ResponseBody
    public ResponseEntity<String> create(@RequestBody BestSceneVO vo){
       log.info("register");
       log.info("BestSceneVO : " + vo);
       
       int Count = bestsceneService.register(vo);
       log.info(Count);
       
       if(Count == 1) {
          return new ResponseEntity<String>("성공", HttpStatus.OK);
       }else {
          return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
       }
    }
    
    //명장면,명대사 삭제
    @DeleteMapping(value = "/{bsNo}",
             produces = { MediaType.TEXT_PLAIN_VALUE })
    @ResponseBody
    public ResponseEntity<String> remove(@RequestBody BestSceneVO vo, @PathVariable("bsNo") int bsNo){
       log.info("remove");
       
       int delCount = bestsceneService.remove(bsNo);
       
       if(delCount == 1) {
          return new ResponseEntity<>("success", HttpStatus.OK);
       }else {
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
       }
    }
    
    //명장면,명대사 수정
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                value = "/{bsNo}",
                consumes = "application/json",
                produces = {MediaType.TEXT_PLAIN_VALUE})
    @ResponseBody
    public ResponseEntity<String> modify(@RequestBody BestSceneVO vo, @PathVariable("bsNo") int bsNo){
    log.info("modify");
    log.info("bsno : " + bsNo);
    log.info("vo : " + vo);
    vo.setBsno(bsNo);
    int modCount = bestsceneService.modify(vo);
    
    if(modCount == 1) {
       return new ResponseEntity<>("success", HttpStatus.OK);
    }else {
       return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    }
	
	//명장면,명대사 신고
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/bestreport/{bsNo}/{reporter}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<String> bestreport(@PathVariable("bsNo") int bsNo, @PathVariable("reporter") String reporter ) {
		log.info("bestscene No." + bsNo);
		int insertcount = bestsceneService.report(bsNo, reporter);
		return insertcount == 1? new ResponseEntity<>("게시물이 신고되었습니다.", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//추천 영화 조회
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/movieRecommend")
	public void movierecommend(Model model, @RequestParam("userid") String userid) {
		log.info("movierecommend: " + userid);
		List<MovieVO> movie = movieService.getRecommendMovie(userid);	//추천 영화
		int totalNation = movieService.getNationCt();	//국가 총 개수
		String genre = movie.get(1).getGenre();		//선호하는 장르 조회
		model.addAttribute("list", movie); 
		model.addAttribute("genre", genre);
		model.addAttribute("total", commentService.getTotalCommById(userid)); //총 코멘트 개수 조회
		model.addAttribute("avgstar", commentService.getStarAvgById(userid)); //나의 평균 별점 조회 
		model.addAttribute("muchstar", commentService.getMuchStarById(userid)); //나의 가장 많이 준 별점 조회 
		//model.addAttribute("totalNation", totalNation); 
	}
	
	//선호 장르 조회
	@ResponseBody
	@GetMapping(value = "/movieRecommend/genre/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CommentVO>> getMyGenre(@PathVariable("userid") String userid){
		log.info("movieRecommend : " +  userid);
		return new ResponseEntity<>(movieService.getGenre(userid), HttpStatus.OK);
	}
	
	//별점별 코멘트 수
	@ResponseBody
	@GetMapping(value = "/movieRecommend/comm/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CommentVO>> getStarCount(@PathVariable("userid") String userid){
		log.info("getStarCount : " +  userid);
		return new ResponseEntity<>(commentService.getStarCount(userid), HttpStatus.OK);
	}
	
	//선호 국가 조회
	@ResponseBody
	@GetMapping(value = "/movieRecommend/nation/{userid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<MovieVO>> getNation(@PathVariable("userid") String userid){
		log.info("getNation : " +  userid);
		return new ResponseEntity<>(movieService.getMovieNation(userid), HttpStatus.OK);
	}
	
	//영화 목록
	@PreAuthorize("isAuthenticated()")
		@GetMapping("/movieList")
		public void movielist(Criteria cri, Model model) {
			log.info("list" + cri);
			model.addAttribute("list", movieService.getList(cri));
			//model.addAttribute("pageMaker", new MoviePageDTO(cri, 123));
			int total = movieService.getTotal(cri);
			
			model.addAttribute("pageMaker", new PageDTO(cri, total));
		}
	
	//영화 등록
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/movieRegister")
	public void movieregister(Model model) {
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/movieRegister")
	public String movieregister(RedirectAttributes rttr, MovieVO movie) {
		log.info("register : " + movie);
		movieService.register(movie);
		rttr.addFlashAttribute("result", movie.getMno());
		return "redirect:/movie/movieList";
	}
	
	//영화 조회, 수정 페이지
	@PreAuthorize("isAuthenticated()")
	@GetMapping({"/movieGet", "/movieModify"})
	public void movieget(@RequestParam("mno") int mno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("movieGet");
		model.addAttribute("movie", movieService.get(mno));
	}
	
	//영화 스틸컷
		@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public ResponseEntity<List<MovieAttachVO>> getAttachList(int mno) {
			log.info("getAttachList" + mno);
			return new ResponseEntity<>(movieService.getAttachList(mno), HttpStatus.OK);
		}
		
		//영화수정
		@PreAuthorize("isAuthenticated()")
		@PostMapping("/movieModify")
		public String moviemodify(MovieVO movie, RedirectAttributes rttr) {
			log.info("moviemodify : " + movie);
			if (movieService.modify(movie)) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/movie/movieList";
			
		}
		//영화수정
		@PostMapping("/movieModifyposter")
		public void moviemodifyposter(MovieVO movie, RedirectAttributes rttr) {
			log.info("moviemodify : " + movie);
		}
			
		//영화삭제
		@PreAuthorize("isAuthenticated()")
		@PostMapping("/movieRemove")
		public String movieremove(@RequestParam("mno") int mno, RedirectAttributes rttr) {
			List<MovieAttachVO> attachList = movieService.getAttachList(mno);
			if (movieService.remove(mno)) {	
				deleteFiles(attachList);
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/movie/movieList";
		}
		
		//첨부파일 삭제처리
		private void deleteFiles(List<MovieAttachVO> attachList) {	//첨부파일 삭제
			if(attachList == null || attachList.size() == 0) {
				return;
			}
			attachList.forEach(attach -> {
				Path file = Paths.get(attach.getUploadPath() + "\\" +
									  attach.getUuid() + "_" + attach.getFileName());
				try {
					Files.deleteIfExists(file);	//파일이 존재하면 삭제
					if(Files.probeContentType(file).startsWith("image")) {//이미지인 경우
						Path thumbNamil 
							= Paths.get(attach.getUploadPath() + "\\s_" +
										attach.getUuid() + "_" + attach.getFileName());
						Files.delete(thumbNamil);//섬네일 파일 삭제
					}
				} catch (IOException e) {
					e.printStackTrace();
				}	
			});
		}
		
		//업로드
		   @PostMapping(value = "/uploadAjaxAction", 
		             produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		     @ResponseBody
		     public ResponseEntity<List<AttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		        List<AttachVO> list = new ArrayList<>();
		     
		        log.info("upload");
		        String uploadFolder = "C:\\upload\\bestscene";   //업로드 경로
		        File uploadPath = new File(uploadFolder);
		        
		        if(uploadPath.exists() == false) {
		           uploadPath.mkdirs();
		        }
		        
		        for(MultipartFile multipartFile : uploadFile) {
		           log.info("----------------------------------------");
		           log.info("FileName : " + multipartFile.getOriginalFilename());
		           
		           String uploadFileName = multipartFile.getOriginalFilename();
		           AttachVO attach = new AttachVO();
		           attach.setFileName(uploadFileName);
		           
		           uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		           log.info("FileName : " + uploadFileName);
		           
		           //UUID 파일명 중복 방지 처리
		           UUID uuid = UUID.randomUUID();
		           uploadFileName = uuid.toString() + "_" + uploadFileName;
		           
		           try {
		             File saveFile = new File(uploadPath, uploadFileName);
		              multipartFile.transferTo(saveFile);
		              
		              attach.setUuid(uuid.toString());
		              attach.setUploadPath(uploadFolder);
		              
		   
		             if(checkImageType(saveFile)) { 
		                attach.setImage(true);
		              
		                FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
		                Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100); 
		                thumbnail.close(); 
		            }
		   
		              
		              list.add(attach);
		              log.info(list);
		           } catch (IllegalStateException e) {
		              e.printStackTrace();
		           } catch (IOException e) {
		              e.printStackTrace();
		           }
		        }
		        return new ResponseEntity<>(list, HttpStatus.OK);
		     }
		   
		      //이미지 체크
		      private boolean checkImageType(File file) {
		      try {
		         String contentType = Files.probeContentType(file.toPath());
		         return contentType.startsWith("image");
		      } catch (IOException e) {
		         e.printStackTrace();
		      }
		         return false;
		      }//END checkImageType()
		      
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
		      
		    //첨부파일 삭제
		      @PostMapping("/deleteFile")
		      @ResponseBody
		      public ResponseEntity<String> deleteFile(String fileName, String type){
		         log.info("deleteFile : " + fileName);
		         File file;
		         
		         try {
		         file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
		         file.delete();
		      } catch (UnsupportedEncodingException e) {
		         e.printStackTrace();
		      }
		         return new ResponseEntity<String>("deleted", HttpStatus.OK);
		      }
	

}
