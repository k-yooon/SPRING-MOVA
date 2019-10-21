package com.mova.domain;


import java.util.List;

import lombok.Data;

@Data
public class MovieVO {
   
   private int mno;
   private String mname;
   private String year;
   private String nation;
   private String genre;
   private String summary;
   private String director;
   private String actor;
   private double avgstar;
   private String uuid;
   private String uploadPath;
   private String fileName;
   private Long count; 
   private CommentVO comment;
   
   private List<MovieAttachVO> movieList;
   
}