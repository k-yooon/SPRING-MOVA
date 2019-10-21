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
.pickBtn{
    background-color: #02A388;
    color: white;
    border-radius: 30px;
    width: 200px;
    height: 50px;
    text-align: center;
    margin-left: 42%;
    margin-top: 25px;
    padding-top: 15px;
	font-weight: bold;
}
.pickBtn:hover{
    background-color: #FF5A5A;
}
.text{
	margin-left: 43%;
} 
.space{
	width: 900px;
	margin-top: 20px;
	margin-left: 17%;
}
table caption{
	caption-side: top;
	text-align: center;
	font-weight: bold;
}

</style>
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">EVENT 추첨</h3>
		</div>
		<div>
		   <c:choose>
		   		<c:when test="${empty event.uploadPath || event.uploadPath eq 'undefined'}"> 
		           <div class='text'>추첨할 이벤트가 없습니다.</div>
		        </c:when>
		    	<c:otherwise>
		    	<c:set var="fileCallPath" value='${event.uploadPath}\\${event.uuid}_${event.fileName}'/>
		            <div><img src="/poster?fileName=${str:encodeURI(fileCallPath)}" class='eImg'></div> 
		            <input type='hidden' class='file' data-file='${str:encodeURI(fileCallPath)}' data-type='image'>
					<input type='hidden' class='eno' value='${event.eno}'>
					<div class='eJoin'></div>
					<div class='space'></div>
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
     
     function showPickMem(){
    	 var eno = $(".eno").val();
    	 var str = "";
    	 $(".pickBtn").remove();
    	 $.getJSON("/event/getPickMem/" + eno + ".json", function(list){
				if(list.length <= 0 || list == null || list[0].usernm == 'undefined'){
					str = "<p class='pickBtn'>이벤트 추첨하기</p>";
					$(".eJoin").html(str);
				} else {
					str += "<table><caption>- 당첨자 명단 -</caption><thead><tr>" +
					  	   "<th>회원 ID</th><th>회원 이름</th><th>전화번호</th><th>이메일</th></tr></thead><tbody>";
					for(var i = 0; i < list.length; i++){
						str += "<tr><td><a href='../member/mypage?userid=" + list[i].userid + "&star=5'>" + list[i].userid + "</a></td>" +
							   "<td>" + list[i].usernm + "</td><td>" + list[i].tel + "</td><td>" + list[i].email + "</td></tr>";
					}
					str += "</tbody></table>";
					$(".space").html(str);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
     }
     
     showPickMem();

   	 $(".eJoin").on("click", function(e){	
    	 var eno = $(".eno").val();
    	 var chk = confirm("당첨자를 추첨하겠습니까?");
    	 if(chk){
    		 /* pickMember(eno, function(response){
    			console.log("ok");
    			alert(response); 
    		 }); */
    		 $.ajax({
                 type : 'get',
                 url : '/event/pickMember/' + eno,
                 data : JSON.stringify(eno),      
                 contentType : "application/json; charset=utf-8",
                 success : function(result, status, xhr){
                	 showPickMem();  
                 },error : function(xhr, status, er){
                    if(error){
                       error(er);
                    }
                 }
              })
    	 }
     });
	
});	
</script>