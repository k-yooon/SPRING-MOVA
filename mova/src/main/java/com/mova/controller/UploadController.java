package com.mova.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mova.domain.EventVO;
import com.mova.domain.MemberVO;
import com.mova.domain.MovieAttachVO;
import com.mova.domain.MovieVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	private boolean checkImageType(File file) {
		try {
			String contenType = Files.probeContentType(file.toPath());
			
			
			return contenType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PostMapping("/uploadPoster")
	@ResponseBody
	public ResponseEntity<List<MovieVO>> uploadPoster(MultipartFile[] poster) {
		
		List<MovieVO> list = new ArrayList<>();
		String uploadPath = "C:\\upload\\poster";	
		for (MultipartFile m : poster) {
			log.info("-------------------------");
			log.info("upload file name : " + m.getOriginalFilename());
			log.info("upload file size : " + m.getSize());

			String uploadFileName = m.getOriginalFilename();
			MovieVO attachVO = new MovieVO();
			attachVO.setFileName(uploadFileName);	//1.업로드 파일명 저장
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; 
	
			try {
				File saveFile = new File(uploadPath, uploadFileName);
			
				m.transferTo(saveFile);
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(uploadPath);
					if(checkImageType(saveFile)) {
						FileOutputStream thumbnail = new FileOutputStream( new File(uploadPath, "s_" + uploadFileName));	
						Thumbnailator.createThumbnail(m.getInputStream(), thumbnail, 100, 100);
						thumbnail.close();
					}
					list.add(attachVO);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//스틸컷 업로드
	@PostMapping("/uploadAjaxAction")
	@ResponseBody
	public ResponseEntity<List<MovieAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<MovieAttachVO> list = new ArrayList<>();
		String uploadPath = "C:\\upload\\still";	

		for (MultipartFile m : uploadFile) {
			log.info("-------------------------");
			log.info("upload file name : " + m.getOriginalFilename());
			log.info("upload file size : " + m.getSize());

			String uploadFileName = m.getOriginalFilename();
			MovieAttachVO attachVO = new MovieAttachVO();
			attachVO.setFileName(uploadFileName);	//1.업로드 파일명 저장
			
			uploadFileName 
			= uploadFileName.substring(
					uploadFileName.lastIndexOf("\\") + 1);
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName; 

			try {
				File saveFile = new File(uploadPath, uploadFileName);
			
				m.transferTo(saveFile);
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(uploadPath);
					if(checkImageType(saveFile)) {
						FileOutputStream thumbnail = new FileOutputStream( new File(uploadPath, "s_" + uploadFileName));	
						Thumbnailator.createThumbnail(m.getInputStream(), thumbnail, 100, 100);
						thumbnail.close();
					}
					list.add(attachVO);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File(fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", 
					   Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(
						FileCopyUtils.copyToByteArray(file),
						header,
						HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/poster")
	@ResponseBody
	public ResponseEntity<byte[]> poster(String fileName){
		File file = new File(fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", 
					   Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(
						FileCopyUtils.copyToByteArray(file),
						header,
						HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		try {
			File file = new File(URLDecoder.decode(fileName, "UTF-8"));
			File thumbfile = new File(URLDecoder.decode(fileName, "UTF-8"));
			file.delete();	//파일 삭제
			
			if(type.equals("image")) {	//이미지의 경우 원본 이미지 삭제
				//원본 파일명으로 변환
				System.out.println("fileName : " + file.getAbsolutePath());
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				String thumbFile = file.getAbsolutePath().replaceFirst("event\\\\", "event\\\\s_");
				System.out.println("thumbFile : " + thumbFile);
				file = new File(largeFileName);
				thumbfile = new File(thumbFile);
				file.delete();	//원본 이미지 삭제
				thumbfile.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	//섬네일 이미지 데이터 전송
	@GetMapping("/userimage")
	@ResponseBody
	public ResponseEntity<byte[]> getfile(String fileName){
			File file = new File(fileName);
			ResponseEntity<byte[]> result = null;
			
			try {
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type", 
						   Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(
							FileCopyUtils.copyToByteArray(file),
							header,
							HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return result;
	}	
		
	//회원 사진 업로드
	@PostMapping("/uploaduserAction")
	@ResponseBody
	public ResponseEntity<List<MemberVO>> uploaduser(MultipartFile[] uploaduser) {

		  List<MemberVO> list = new ArrayList<>();
	      String uploadPath = "C:\\upload\\user";   
 
		 for (MultipartFile m : uploaduser) {
			 log.info("-------------------------");
			 log.info("upload file name : " + m.getOriginalFilename());
			 log.info("upload file size : " + m.getSize());
	         
	         String uploadFileName = m.getOriginalFilename();
	         MemberVO mattachVO = new MemberVO();
	         mattachVO.setFileName(uploadFileName); //1. 업로드 파일명 저장

	         uploadFileName 
	         = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
	         UUID uuid = UUID.randomUUID();
	         uploadFileName = uuid.toString() + "_" + uploadFileName; 
  
	         try {
	        	File saveFile = new File(uploadPath, uploadFileName);
	        	
	            m.transferTo(saveFile);
	            mattachVO.setUuid(uuid.toString());
	            mattachVO.setUploadPath(uploadPath);
	               if(checkImageType(saveFile)) {
	                  FileOutputStream thumbnail = new FileOutputStream( new File(uploadPath, "s_" + uploadFileName));   
	                  Thumbnailator.createThumbnail(m.getInputStream(), thumbnail, 100, 100);
	                  thumbnail.close();
	               }
	               list.add(mattachVO);
	        	
	         } catch (IllegalStateException e) {
	             e.printStackTrace();
	          } catch (IOException e) {
	             e.printStackTrace();
	          }
	       }
	       return new ResponseEntity<>(list, HttpStatus.OK);    
	}//postMapping
	
	//이벤트 사진 업로드
		@PostMapping("/uploadEventAction")
		@ResponseBody
		public ResponseEntity<List<EventVO>> uploadEvent(MultipartFile[] event) {
			  List<EventVO> list = new ArrayList<>();
		      String uploadPath = "C:\\upload\\event";   
	 
		      for (MultipartFile m : event) {
				 log.info("-------------------------");
				 log.info("upload file name : " + m.getOriginalFilename());
				 log.info("upload file size : " + m.getSize());
		         
		         String uploadFileName = m.getOriginalFilename();
		         EventVO eventVO = new EventVO();
		         eventVO.setFileName(uploadFileName); //1. 업로드 파일명 저장

		         uploadFileName 
		         = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		         UUID uuid = UUID.randomUUID();
		         uploadFileName = uuid.toString() + "_" + uploadFileName; 
	  
		         try {
		        	File saveFile = new File(uploadPath, uploadFileName);
		            m.transferTo(saveFile);
		            eventVO.setUuid(uuid.toString());
		            eventVO.setUploadPath(uploadPath);
		               if(checkImageType(saveFile)) {
		                  FileOutputStream thumbnail = new FileOutputStream( new File(uploadPath, "s_" + uploadFileName));   
		                  Thumbnailator.createThumbnail(m.getInputStream(), thumbnail, 100, 100);
		                  thumbnail.close();
		               }
		               list.add(eventVO);
		         } catch (IllegalStateException e) {
		             e.printStackTrace();
		          } catch (IOException e) {
		             e.printStackTrace();
		          }
		      }  
		       return new ResponseEntity<>(list, HttpStatus.OK);    
		}
}
