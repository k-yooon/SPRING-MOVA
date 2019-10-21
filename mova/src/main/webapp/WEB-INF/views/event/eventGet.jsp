<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@ include file="../include/header.jsp" %>
<style>
.eImg{
	width: 800px;
	margin-left: 19%;
	position: relative;
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
    margin-left: 69%;
}
.adminBtn:hover{
    background-color: #FF5A5A;
}
.ename{
	display: inline-block;
	font-weight: bold;
	position: absolute;
    top:100%;
    left:50%;
    transform: translate(-50%, -50%); 
	z-index:2;
	font-size: 35px;
}
p{
	display: inline-block;
	color: #02A388;
	font-size: 45px;
}
.text{
	font-weight: bold;
	position: absolute;
    top:110%;
    left:50%;
    transform: translate(-50%, -50%); 
	z-index:2;
	font-size: 30px;
}
table{
	width: 350px;
	text-align: center;
	position: absolute;
	top:160%;
    left:50%;
    transform: translate(-50%, -50%); 
	z-index:2;
}

</style>
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">EVENT 발표</h3>
			<p class="w3ls_head_para">행운의 주인공은?</p>
		</div>
		<sec:authentication property="principal" var="pinfo"/>  
		<div>
			<c:if test="${pinfo.username == 'admin'}">
				<div class='adminBtn' id='delete'>이벤트 삭제</div>
			</c:if>	
		    <c:set var="fileCallPath" value='${event.uploadPath}\\${event.uuid}_${event.fileName}'/>
		        <div>
		        	<img src="../resources/images/movie/poster/eventan.jpg" class='eImg'>
		        	<div class="ename"><p>"${event.title}"</p> 영화 예매권 이벤트</div>
		        	<div class="text">당첨자 발표</div>
		        	<table>
						<thead>
							<tr>
								<th>회원 ID</th>
								<th>전화번호 뒷자리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${member}" var="member" >
							<tr>
								<td>${member.userid}</td>
								<td>${member.tel}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
		        </div> 
		        <input type='hidden' class='file' data-file='${str:encodeURI(fileCallPath)}' data-type='image'>
				<input type='hidden' class='eno' value='${event.eno}'>	
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
});   
</script>