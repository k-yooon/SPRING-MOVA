<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@include file = "include/header.jsp" %>  
   
<style>
h1 {margin-top: 30px; text-align: center; margin-left: 50%;}
.modal-content {width : 60%; margin-left: 350px; margin-bottom: 50px; margin-top: 50px;}
#findModal{width: 500px; height: 450px; margin-left: 130px;}
.label {float: left; width: 80px; box-sizing: border-box;}
label {margin-top: 10px;}
input {margin-bottom: 10px;}
#inbox{width:550px; margin-left: 150px;}
h4{text-align: center;}
.inputBox{margin-left: 20px; margin-right: 20px;}
</style>

<h1>PW찾기</h1>
<div class="modal-content">
   
      <div class="login-form" id="ff">
      <!-- <form action="/pwFind" method="post"> -->
       <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%> 
      <div id="inbox">
      <label for="userid">ID</label>
      <input type="text" class="input" id="idchk" name="userid" placeholder="ID" value=""  maxlength="15" autofocus="autofocus" required="required">
      <label for="tel">연락처</label>
      <input type="text" name="tel" id="telchk" class="input" value="" placeholder="-없이 번호만 입력해주세요" maxlength="11" required="required"><br>
      
      <div class="signin-rit">
      <span class="agree-checkbox"></span>
      </div>
      
      <div class="tp">
         <!-- <input type="button" value="PW 찾기" id="searchBtn2"> -->
         <input type="submit" value="PW 찾기" id="searchBtn2" data-toggle="modal" data-target="#myModal4">
      </div>
      <!-- </form> -->
      </div>
      </div>
</div>

<!-- Modal1 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content" id="findModal">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>PW 찾기</h4>
                  </div>
                  <div class="login-form" id = "ee">
                     <div class="inputBox" id = "dd">
                        <div id = "box">
                           <h4>새로운 비밀번호를 입력해주세요</h4><br>
                           <div id="content">
                         <label for="userpw">새로운 PW</label>
                           <input type="password" id="newpw" name="userpw" class="input" placeholder="Password" value="" maxlength="15" autofocus="autofocus" required="required"><br>
      
                        <label for="confirm password">새로운 PW 확인
                        </label><input type="password"  id="renewpw" name="confirm-password" class="input" value="" placeholder="Password"  maxlength="15" autofocus="autofocus" required="required"><br>
                           </div>
                           <div class="tp">
                           <input type="submit" value="변경하기" id="modalRegisterBtn" data-toggle="modal" data-target="#myModal4">
                           </div>   
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
	  
	function pwfind(userid, tel, callback, error){
		console.log("pwfind");
		console.log(userid);
		console.log(tel);
		$.get('/pwFind/' + userid + '/' + tel + '.json', function(response){
            if(callback){
               callback(response);      
            }
         }).fail(function(xhr, status, err){
            if(error){
               error();
            }
         });
	}
	
	function pwUpdate(member, callback, error){
		console.log("userid : " + member.userid);
		$.ajax({
			type : 'put',
			url : '/pwUpdate/' + member.userid,
			data : JSON.stringify(member),		//데이터를 json화 시킴
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	var userid = "";
	$("#searchBtn2").click(function(){
		userid = $("#idchk").val();
		var tel = $("#telchk").val();
		console.log(userid);
		console.log(tel);
		pwfind(userid, tel, 
			function(response){
			console.log(response);
				if(response == null || response.length < 0 || response.userid == undefined){
					alert("아이디 혹은 연락처가 정보와 일치하지 않습니다.");
					location.reload();
				} else {
					$("#myModal").modal();
				}	
				
			}		
		);
		
	});
	
	$("#modalRegisterBtn").on("click", function(e){
		var pw = $("#newpw").val();
		var repw = $("#renewpw").val();
		console.log("pw : " + pw + "repw" + repw + "userid" + userid);
		var member = {userid:userid, userpw:pw};
		pwUpdate(member, function(result){
			$("#myModal").modal("hide");
			alert("비밀번호가 수정되었습니다.");
			location.href="/login";
		});
	});
	
});
</script>
