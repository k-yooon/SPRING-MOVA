<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<%@ include file="../include/header.jsp"%>

<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
   <div class="agile_featured_movies">
      <div class="inner-agile-w3l-part-head">
         <h3 class="w3l-inner-h-title">게시물 등록</h3>
         <p class="w3ls_head_para">R E G I S T E S R</p>
      </div>
      <div class="w3_mail_grids">
         <!-- 게시물 등록 폼 -->
         <form role="form" method="post" action="/recommend/register" >
            <input type="hidden" name="${_csrf.parameterName }"
               value="${_csrf.token }">
               <div class="form-group">
                  <label>제목</label>
                  <input class="form-control" name="title">
               </div>      
               <div class="form-group">
                  <label>내용</label>
                  <textarea rows="3" class="form-control" name="content"></textarea>
               </div>         
               <div class="form-group">
                  <label>작성자</label>
                  <input class="form-control" name="userid"
                        value='<sec:authentication property="principal.username"/>'      
                        readonly="readonly">
               </div>   
               
               <button class="login" type="submit" value="저장">저장</button> 
               <button class="login" type="reset"value="취소">취소</button>
               
         </form>
      </div>
   </div>
</div>
<script>
//CSRF 처리
var csrfHeaderName = "${_csrf.headerName }";
var csrfTokenValue = "${_csrf.token }";
</script>
