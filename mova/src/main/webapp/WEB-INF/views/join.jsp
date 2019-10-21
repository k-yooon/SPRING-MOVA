<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<%@include file = "include/header.jsp" %>  
    
<style>
h1 {margin-top: 30px; text-align: center;}
.modal-content {width : 60%; margin-left: 300px; margin-bottom: 50px; margin-top: 50px;} 
.label {float: left; width: 80px; box-sizing: border-box;}
input {margin-bottom: 10px;}
#inputbox{width:550px; margin-left: 150px;}
</style>

<h1>Register</h1>
<div class="modal-content">
	
		<div class="login-form">
		<div id="inputbox">
			<form role='form' action="/join" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
			<label for="userid">ID</label>
			<input type="text" class="input" id="inputId" name="userid" placeholder="ID" value="" maxlength="15" autofocus="autofocus" required="required">
			<button id="idSameChk">중복확인</button><br>
			
			<label for="userpw">PW</label>
			<input type="password" name="userpw" class="input" id="pw" placeholder="Password" maxlength="15" autofocus="autofocus" required="required" value=""><br>
			
			<label for="confirm password">PW 확인</label><input type="password" name="confirm password" id="pwchk" class="input" placeholder="Password" value="" maxlength="15" autofocus="autofocus" required="required"><br>
			
			<label for="usernm">이름</label><input type="text" name="usernm" class="input" required="required"><br>
			<label for="tel">연락처</label><input type="text" name="tel" class="input" placeholder="-없이 번호만 입력해주세요" maxlength="11" required="required"><br>
			<label for="birth">주민등록번호</label><input type="text" name="birth" class="input" placeholder="-없이 숫자만 입력해주세요" maxlength="13"><br>
			<label for="email">이메일</label><input type="email" name="email" class="input" placeholder="E-mail" required="required"><br>
			
			성별 <input type="radio" name="gender" id="genderF" value="F" required="required">
					   <label for="genderF">여자</label>
			   <input type="radio" name="gender" id="genderM" value="M" required="required">
		    		   <label for="genderM">남자</label><br>
		  
		   <div class = 'uploadDiv'>    
		       사진<input type="file" name="uploaduser">	
		    </div>   	  
			<div id="uploadResult">
				<ul>
				</ul>
			</div>
		 
			<div class="signin-rit">
			<span class="agree-checkbox"></span>
			</div>
			
			<div class="tp">
				<input type="submit" value="가입하기" id="uploadBtn" data-toggle="modal" data-target="#myModal4">
			</div>
			</form>
			</div>
		</div>
</div>
 	 
<script>	
$(document).ready(function(){
	var sameBtnClick = false; 
	var result = false;
	
	//아이디 중복 확인
	function idChk(callback, error){
		$.getJSON("/idChk" + ".json",function(data){
				if(callback){
					callback(data);	
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}//end idChk
	
	//중복체크 버튼 클릭시
	$("#idSameChk").on("click", function(e){
		sameBtnClick = true;
		var idChkFlag = false;
		var inputId = $("#inputId").val()
		console.log("inputId" + inputId);
		idChk(function(list){
		     for(var i = 0; i < list.length; i++){
		    	 console.log("id" + list[i].userid);
		    	 if(inputId == list[i].userid){
		    		 idChkFlag = true;
		    		 alert("중복된 아이디입니다. 다시 입력해주세요.");
		    		 $("#inputId").val("");
		    	 }//end if
		     }//end for
		     if(idChkFlag == false){
		    	 result = confirm("사용 가능한 아이디입니다. 사용하시겠습니까?");
		     }//end if	 
		}, function(xhr, status, error){
		           
		   }
		);
	});//end idSameChk function
	
	//가입 버튼 클릭시
	 $("#uploadBtn").on("click", function(e){
		var pw = $("#pw").val();
		var pwchk = $("#pwchk").val();
		if(sameBtnClick == false){
			alert("아이디 중복확인을 해주세요.");
			return;
		} else if(pw !== pwchk){
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
			$("#pw").val("");
			$("#pwchk").val("");
			$("#pw").focus();
		} else if(result == true && sameBtnClick == true) {
			alert("MOVA의 가족이 되신 걸 축하드립니다~")
		//	form.submit();
		}
	});//end uploadBtn click 
	
});// end id 중복체크

//사진 업로드 /////////////////////////////////
$(function(e){
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	//확장자 제한 정규표현식
var maxSize = 5242880;	//파일 최대 업로드 크기 제한 5MB

	//확장자 및 파일 크기 확인 함수
	function checkExension(fileName, fileSize){
		if(fileSize >= maxSize) {	//파일 크기 확인
			alert("파일 사이즈 초과!");	//크기를 초과하면 알림 메시지 출력
			return false;
		}//end if
		if(regex.test(fileName)) {	//확장자 확인
			alert("업로드 불가 파일");	//제한 확장자인 경우 알림 메시지 출력
			return false;
		}//end if
		return true;	//파일 크기 및 확장자 문제가 없는 경우
	}//END checkExension()

	//업로드 영역 복사
	var cloneObj = $(".uploadDiv").clone();

	//아이디가 uploadBtn에게 click 이벤트 핸들러 등록
	$("input[name='uploaduser']").change(function(e){
		
		var formData = new FormData();	//가상의 <form> 태그
		
		var inputFile = $("input[name='uploaduser']");
		var files = inputFile[0].files;
		console.log(files);
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
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
});//end uploaduser

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
	             str += "<input type='hidden' id='uuid' value='" + obj.uuid + "'/>";
	             str += "<input type='hidden' id='fileName' value='" + obj.fileName + "'/>";
	             str += "<input type='hidden' id='uploadPath' value='" + obj.uploadPath + "'/>" +
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
	   
	   var formObj = $("form[role='form']");
	   $("input[type='submit']").on('click', function(e){
	       e.preventDefault();
	      
	        var str = "";
	        var uuid = $("#uuid").val();
	        var fileName = $("#fileName").val();
	        var uploadPath = $("#uploadPath").val();
	        
	        console.log(uuid);
	        console.log(fileName);
	        console.log(uploadPath);
	        str += "<input type='hidden' name='uuid' value='" + uuid + "'/>";
	        str += "<input type='hidden' name='fileName' value='" + fileName + "'/>";
	        str += "<input type='hidden' name='uploadPath' value='" + uploadPath + "'/>";

			 console.log("attach : " + str);
			 formObj.append(str).submit();  
	   });
	//'x'버튼 클릭시 프로필 사진 삭제 처리
	   $('.uploadResult').on('click', 'button', function(e){
	      console.log("delete file");
	      var targetFile = $(this).data('file');
	      var type      = $(this).data('type');
	      var targetLi   = $(this).closest('li');
	      var csrfHeaderName = "${_csrf.headerName}";
		   var csrfTokenValue = "${_csrf.token}";
	      $.ajax({
	         type : 'post',
	         url :'/deletefile',
	         data : {fileName:targetFile, type:type} ,
	         dataType : 'text',
	         beforeSend  : function(xhr){   //전송 전 csrf 헤더 지정
		            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		         },
	         success : function(result){
	            alert(result);      //성공하면
	            targetLi.remove();   //해당 li 삭제
	         }
	      })//END .ajax() 
	   });
	
}); //END showUploadResult()
</script> 	 
	
