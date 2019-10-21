<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@include file = "../include/header.jsp" %>    

<style>
h1 {margin-top: 30px; text-align: center; margin-left: 45%;}
.modal-content {width : 60%; margin-left: 300px; margin-bottom: 50px; margin-top: 50px;} 
.label {float: left; width: 80px; box-sizing: border-box;}
input {margin-bottom: 10px; margin-top: 10px;}
button{margin-bottom: 10px; }
#inputbox{width:550px; margin-left: 150px;}
ul{list-style-type: none;}
#userImg{width: 200px;}
h4{text-align: center;}
#findModal{width: 500px; height: 450px; margin-left: 130px;}
.inputBox{margin-left: 20px; margin-right: 20px;}
</style>

<h1>나의 정보 수정</h1>
<div class="modal-content">
	<div class="login-form">
	  <div id="inputbox">
		<form role="form" action="/member/infoModify" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		 <label for="userImg">프로필 사진</label>
				<div id="uploadResult">
				  <ul>
                    <li> 
                    	<input type='hidden' name='fileName' id='fileName' value='${vo.fileName}'/>
						<input type='hidden' name='uploadPath' id='uploadPath' value='${vo.uploadPath}'/>
						<input type='hidden' name='uuid' id='uuid' value='${vo.uuid}'/>
			          <div>
			          <c:choose>
			          	<c:when test="${empty vo.uploadPath || vo.uploadPath eq 'undefined'}">
			          		<button type='button' data-file='undefined' data-type='image' class='btn btn-warning btn-circle'>
							<i class='fa fa-times'></i>
							</button><br>
							<img src="../resources/images/movie/poster/user.jpg" id="userImg">
			          	</c:when> 
			          	<c:otherwise>
			          		<c:set var="fileCallPath" value='${vo.uploadPath}\\${vo.uuid}_${vo.fileName}'/>
			          		<button type='button' data-file='${str:encodeURI(fileCallPath)}' data-type='image' class='btn btn-warning btn-circle'>
							<i class='fa fa-times'></i>
							</button><br>
							<img src="/userimage?fileName=${str:encodeURI(fileCallPath)}" id="userImg">
			          	</c:otherwise>
					 </c:choose>	
					 </div>
					</li>
				  </ul>
			   </div>
			<input type='file' name='uploaduser'>   
				
<div>
<label for="userid">ID</label>
<input class="form-control" id='userid' name='userid' value='<c:out value="${vo.userid}"/>' readonly="readonly">
</div>

<div>
<label>PW</label>
<input class="form-control" value='********' id='changePw'>
</div>

<div>
<label for="usernm">이름</label>
<input class="form-control" name='usernm' value='<c:out value="${vo.usernm}"/>' readonly="readonly">
</div>

<div>
<label for="tel">연락처</label>
<input class="form-control" name='tel' value='<c:out value="${vo.tel}"/>'>
</div>

<div>
<label for="birth">주민등록번호</label>
<input class="form-control" name='birth' value='<c:out value="${vo.birth}"/>' readonly="readonly">
</div>

<div>
<label for="email">이메일</label>
<input class="form-control" name='email' value='<c:out value="${vo.email}"/>'>
</div>

<div>
<label for="gender">성별</label>
<input class="form-control" name='gender' value='<c:out value="${vo.gender}"/>' readonly="readonly">
</div>


<button type ="submit" data-oper='modify' class='modify'>수정</button>


		</form>
		<button data-oper='remove' class='out'>탈퇴하기</button>
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
                        <h4>PW 변경</h4>
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
	$(document).ajaxSend(function(e, xhr, options){
	    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	//확장자 제한 정규표현식
	var maxSize = 5242880;	//파일 최대 업로드 크기 제한 5MB

	function checkExension(fileName, fileSize){
		if(fileSize >= maxSize) {	//파일 크기 확인
			alert("파일 사이즈 초과!");	//크기를 초과하면 알림 메시지 출력
			return false;
		}
		if(regex.test(fileName)) {	//확장자 확인
			alert("업로드 불가 파일");	//제한 확장자인 경우 알림 메시지 출력
			return false
		}
		return true;	//파일 크기 및 확장자 문제가 없는 경우
	}//END checkExension()

	//아이디가 uploadBtn에게 click 이벤트 핸들러 등록
	$("input[name='uploaduser']").change(function(e){
		
		var formData = new FormData();	//가상의 <form> 태그
		
		var inputFile = $("input[name='uploaduser']");
		var files = inputFile[0].files;
		console.log(files);
		
		//formData 객체에 선택한 파일 추가 
		for(var i=0 ; i<files.length ; i++){
			//확장자 및 파일 크기 확인
			if(!checkExension(files[i].name, files[i].size)){
				return false;
			}//end if
			formData.append("uploaduser", files[i]);
		}//end for
	 
			$.ajax({
				type : 'post',
				url :'/uploaduserAction',
				data : formData,
				dataType : 'json',
				contentType : false,
				processData : false,
				beforeSend  : function(xhr){   //전송 전 csrf 헤더 지정
			            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			    },
				success : function(result){
				console.log("결과" + result);	//콘솔로 결과 확인
		
				   showUploadResult(result);
				
				}//end success
			});//end ajax	
	});

			function showUploadResult(uploadResultArr){
			      if(!uploadResultArr || uploadResultArr.length == 0){
			         return;
			      }

			      var uploadUL = $('#uploadResult ul');
			      var str = "";
			      $(uploadResultArr).each(function(i, obj){
			    	   console.log(obj.uploadPath);
			             console.log(obj.uuid);
			             console.log(obj.fileName);
			         //업로드 파일명 <li>추가
			 			console.log(obj);
			             var fileCallPath = encodeURIComponent(obj.uploadPath +  "/s_" + obj.uuid  + "_" + obj.fileName);

			             str += "<li>"; 
			             str += "<input type='hidden' name='uuid' id='uuid' value='" + obj.uuid + "'/>";
			             str += "<input type='hidden' name='fileName' id='fileName' value='" + obj.fileName + "'/>";
			             str += "<input type='hidden' name='uploadPath' id='uploadPath' value='" + obj.uploadPath + "'/>" +
					           "<div><span>" + obj.fileName + "</span>"			+
						    	"    <button type='button' " 					+ 
							    "            data-file='" + fileCallPath + "'" 	+
							    "            data-type='image'" 					+
							    "        class='btn btn-warning btn-circle'>" 	+
							    "        <i class='fa fa-times'></i></button><br>" +
							    "    <img src='/userimage?fileName="+ fileCallPath + "'>" +
							    "    </div></li>";			

			      });
			      console.log(str);
			      uploadUL.append(str);
			   }
	
	//탈퇴 처리
	$('.out').on("click", function(e){
		var userid = "${param.userid}";
		var formObj = $("form");
		var result = confirm("정말로 MOVA를 버리시나요?ㅠㅠ");
		if(result){
			location.href= "/member/remove?userid=" + userid;
		}
	});
	
	//수정 처리
	$('.modify').on("click", function(e){
		var formObj = $("form");
		alert("정보가 수정되었습니다.");
		formObj.submit();
	});	

	//x 클릭 시
	$("#uploadResult").on("click", "button", function(e){
		console.log("click");
		var chk = confirm("사진을 삭제하시겠습니까?")
		if(chk){
			var targetLi = $(this).closest("li")
			targetLi.remove();
		}	
	});
	
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
	
	//비밀번호 input 태그 클릭
	$("#changePw").on("click", function(e){
		var changeChk = confirm("비밀번호를 변경하시겠습니까?");
		if(changeChk){
			$("#myModal").modal();
		}
	});
	
	//비밀번호 변경 버튼 클릭시
	$("#modalRegisterBtn").on("click", function(e){
		var pw = $("#newpw").val();
		var repw = $("#renewpw").val();
		var userid = $("#userid").val();
		if(pw !== repw) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
			$("#newpw").val("");
			$("#renewpw").val("");
			$("#newpw").focus();
			return;
		}
		console.log("pw : " + pw + "repw" + repw + "userid" + userid);
		var member = {userid:userid, userpw:pw};
		pwUpdate(member, function(result){
			$("#myModal").modal("hide");
			alert("비밀번호가 수정되었습니다.");
			location.reload();
		});
	});
	
}); //end ready function()

</script>

<%-- <%@include file = "../include/footer.jsp" %>  --%>
