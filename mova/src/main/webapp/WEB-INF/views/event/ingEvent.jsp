<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@ include file="../include/header.jsp" %>
<style>
.eImg{
	width: 900px;
	margin-left: 17%;
}
.eJoin{
    background-color: #02A388;
    color: white;
    border-radius: 30px;
    width: 200px;
    height: 50px;
    text-align: center;
    margin-left: 42%;
    margin-top: 25px;
}
.eJoin:hover{
    background-color: #FF5A5A;
}
.text{
	padding-top: 15px;
	font-weight: bold;
} 
.adminBtn{
	display: inline-block;
	background-color: #02A388;
	width: 130px;
    height: 40px;
    text-align: center;
    color: white;
    padding-top: 10px;
    margin-bottom: 5px;
    border-radius: 10px;
    font-weight: bold;
}
.adminBtn:hover{
    background-color: #FF5A5A;
}
#register{margin-left: 40%;}
</style>
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">EVENT 참여</h3>
			<p class="w3ls_head_para">현재 진행중인 이벤트</p>
		</div>
		<sec:authentication property="principal" var="pinfo"/>  
		<div>
			<c:if test="${pinfo.username == 'admin'}">
				<div class='adminBtn' id='register' onclick="location.href='/event/eventRegister'">이벤트 등록</div>
				<div class='adminBtn' id='delete'>이벤트 삭제</div>
			</c:if>	
			<c:choose>
		   		<c:when test="${empty event.uploadPath || event.uploadPath eq 'undefined'}"> 
		           <div><img src="../resources/images/movie/poster/noevent.jpg" class='eImg'></div>
		        </c:when>
		    	<c:otherwise>
		    	<c:set var="fileCallPath" value='${event.uploadPath}\\${event.uuid}_${event.fileName}'/>
		            <div><img src="/poster?fileName=${str:encodeURI(fileCallPath)}" class='eImg'></div> 
		            <input type='hidden' class='file' data-file='${str:encodeURI(fileCallPath)}' data-type='image'>
					<input type='hidden' class='eno' value='${event.eno}'>
					<c:if test="${pinfo.username != 'admin'}">
						<div class='eJoin'>
							<div class='text'>이벤트 응모하기</div>
						</div>
					</c:if>	
				</c:otherwise> 
	    	</c:choose>		
	    </div>
	</div>
</div>		

<script>
$(document).ready(function(){
	 var csrfHeaderName = "${_csrf.headerName}";
	 var csrfTokenValue = "${_csrf.token}";

	 $(document).ajaxSend(function(e, xhr, options){
	   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	 });
	 
	 var userid = null; 
     <sec:authorize access="isAuthenticated()">
        userid = '<sec:authentication property="principal.username"/>';
     </sec:authorize> 
	
	//이벤트 삭제
	$("#delete").on("click", function(e){
		e.preventDefault();
		var eno = $(".eno").val();
		var targetFile = $(".file").data('file');
		var type	   = $(".file").data('type');
		var chk = confirm("해당 이벤트를 삭제하시겠습니까?");
		if(chk){
			$.ajax({
		         type : 'delete',
		         url : '/event/eventRemove/' + eno,
		         data: JSON.stringify({eno:eno}),
		         contentType: "application/json; charset=utf-8",
		         success : function(deleteResult, status, xhr){
		        	 $.ajax({
		     			type : 'post',
		     			url :'/deleteFile',
		     			data : {fileName:targetFile, type:type} ,
		     			dataType : 'text',
		     			success : function(result){
		     				alert("이벤트가 삭제되었습니다.");
		     			}
		     		});
		            location.reload();
		         },
		         error : function(xhr, status, er){
		            if(error){
		               error(er);
		            }
		         }
		      });
		}
	});
	
	//이벤트 참여
	$(".eJoin").on("click", function(e){
		e.preventDefault();
		var eno = $(".eno").val();
		console.log(userid);
		console.log(eno);
		$.get('/event/eventChk/' + eno + '/' + userid + '.json', function(response){
	        if(!response){
	            var chk = confirm("이벤트에 참여하시겠습니까?");
	        	if(chk){
	            	$.ajax({
	   		         type : 'post',
	   		         url : '/event/eventJoin',
	   		         data : JSON.stringify({eno:eno, userid:userid}),      //데이터를 json화 시킴
	   		         contentType : "application/json; charset=utf-8",
	   		         success : function(result, status, xhr){
	   		            alert("이벤트에 참여되었습니다!");
	   		         },error : function(xhr, status, er){
	   		            if(error){
	   		               error(er);
	   		            }
	   		         }
	   		      });
	        	}	
	         } else {
	            alert("이미 참여한 이벤트입니다.");
	          }
	    });
	});
	
});	
</script>