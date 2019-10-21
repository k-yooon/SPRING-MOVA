<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@include file = "include/header.jsp" %>  

 <style>
h1 {margin-top: 30px; text-align: center; margin-left: 50%;}
.modal-content {width : 60%; margin-left: 350px; margin-bottom: 50px; margin-top: 50px;}
#findModal{width: 500px; height: 300px; margin-left: 130px;}
.label {float: left; width: 80px; box-sizing: border-box;}
label {margin-top: 10px;}
input {margin-bottom: 10px;}
#myModal4 {height: 300px;}
#result {height : 150px;}
.inputBox {margin-left : -10px;}
#inbox{width:550px; margin-left: 150px;}
#content{text-align: center;}
.tp{margin-left: 20px; margin-right: 20px;}
</style>

 
<!--  <form action="/idFind" method="post"> -->
 	<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>  --%>
<h1>ID찾기</h1>
<div class="modal-content">
   
   <div class="login-form" id="aaaa">
   <div id="inbox">
      <label for="usernm">이름</label>
      <input type="text" class="input" id="namechk" name="usernm" placeholder="name" value=""  maxlength="15" autofocus="autofocus" required="required">
      <label for="tel">연락처</label>
      <input type="text" id="telchk" name="tel" class="input" placeholder="-없이 번호만 입력해주세요" value="" maxlength="11" required="required"><br>
      
      <div class="signin-rit">
      <span class="agree-checkbox"></span>
      </div>
      
      <div class="tp">
         <input type="submit" value="ID 찾기" id="searchBtn" data-toggle="modal" data-target="#myModal4">
      </div>
   </div>
   </div>
</div>
<!-- </form> -->
<!-- Modal1 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content"  id="findModal">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>ID 찾기</h4>
                  </div>
                  <div class="login-form" id="b">
                
                        <div id = "box">
                           <div id="content">
 
                           </div>
                           <div class="tp">
                              <input type="submit" id="modalRegisterBtn" value="PW 찾기" onclick="location.href='/pwFind'">
                              <input type="submit" id="modalRegisterBtn" value="LOGIN" onclick="location.href='/login'">
                           </div>   
                        </div>
                
                      <div class="forgot-grid">
                        <div class="clearfix"></div>
                    </div> 
               </div>
            </div>
           </div> 
</div>

<!-- //Modal1 -->

<script>

$(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	   //ajax 전송 시 CSRF 토큰 전송 처리
	   $(document).ajaxSend(function(e, xhr, options){
	      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	   });
	   
	
	function idfind(usernm, tel, callback, error){
		console.log("idfind");
		console.log(usernm);
		console.log(tel);
		$.get('/idFind/' + usernm + '/' + tel + '.json', function(response){
            if(callback){
               callback(response);      
            }
         }).fail(function(xhr, status, err){
            if(error){
               error();
            }
         });
	}
	
	$("#searchBtn").click(function(){
		/* var usernm = $(".login-form").find("input[name='usernm']").attr("value");
		var tel = $(".login-form").find("input[name='tel']").attr("value"); */
		var usernm = $("#namechk").val();
		var tel = $("#telchk").val();
		console.log(usernm);
		console.log(tel);
		idfind(usernm, tel, 
			function(response){
				if(response == null || response.length < 0 || response.userid == undefined){
					alert("이름 혹은 연락처가 정보와 일치하지 않습니다.");
					location.reload();
				} else {
					$("#myModal").modal();
					$("#content").html("ID는 " + response.userid + "입니다.");
				}	
			}	
		);
		
	});
});
</script>
