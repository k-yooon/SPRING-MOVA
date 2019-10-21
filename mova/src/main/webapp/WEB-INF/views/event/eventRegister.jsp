<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ include file="../include/header.jsp" %>
<style>
.uploadResult { width:100%;	background-color:gray; }
.uploadResult ul { 	display:flex; 	justify-content:center;
					flex-flow:row;	align-items: center; list-style: none;}	
.uploadResult ul li { list-style: none;		padding:10px; }						
.uploadResult ul li img { width:300px; }

.uploadResult ul li span { color: white; }
.bigPictureWrapper {	position:absolute;	justify-content: center;		
						display: none;		align-items:center;
						top: 0%;			z-index: 100;
						width:100%;			height:100%;
						background-color: lightgray; 
						background:rgba(255 255 255 0.5);}
.bigPicture {	position: relative;			display: flex;
				justify-content: center;	align-items: center;}						 
.bigPicture img { width: 600px; }	
.page-header{margin-left: 40%;}
label{margin-top: 10px;}
#eImg{width: 300px;}
ul{list-style: none;}
</style>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">EVENT REGISTER</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
		  <div class="panel-body">
		  <form role='form' method="post" action="/event/eventRegister">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
					<div>
						<label>이벤트 사진</label>
						<input type='file' name='uploadposter'>
					</div>
					<div id="PosterResult">
						<ul>	
						</ul>
					</div>	
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name="title">
					</div>		
						<div class="form-group">
						<label>시작일</label>
						<input class="form-control" name="startdate">
					</div>	
					<div class="form-group">
						<label>종료일</label>
						<input class="form-control" name="enddate">
					</div>		
					<button type="submit" class="btn btn-default">Submit</button>
					<button type="reset" class="btn btn-default">Reset</button> 
			</form>
			</div>
		 </div>
    <!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

//ajax 전송 시 CSRF 토큰 전송 처리
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

	var cloneObj = $("#uploadDiv").clone();
	

	//이벤트 사진 업로드ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
 	$("input[name='uploadposter']").change(function(e){
		var formData = new FormData();	//가상의 <form> 태그
		
		var inputFile = $("input[name='uploadposter']");
		var files = inputFile[0].files;
		console.log(files);
		
		//formData 객체에 선택한 파일 추가
		for(var i=0 ; i<files.length ; i++){
			//확장자 및 파일 크기 확인
			if(!checkExension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("event", files[i]);
		}
		
		$.ajax({
			type : 'POST',
			url :'/uploadEventAction',
			data : formData,
			dataType : 'json',
			contentType : false,
			processData : false,
			success : function(result){
				console.log(result);	//콘솔로 결과 확인
				showUploadPoster(result); 
			}
		})//END .ajax()
	});//END uploadBtn 이벤트 처리 
 
	//포스터 이미지 보여주기
	function showUploadPoster(PosterResultArr){
		if(!PosterResultArr || PosterResultArr.length == 0){
			return;
		}

		 var uploadUL = $('#PosterResult ul');
		 var str = "";
		 $(PosterResultArr).each(function(i, obj){
             console.log(obj.uploadPath);
             console.log(obj.uuid);
             console.log(obj.fileName);
            
             var fileCallPath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName);
             
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
				    "    <img src='/poster?fileName="+ fileCallPath + "' id='eImg'>" +
				    "    </div></li>";
          });
          uploadUL.append(str);	
	}
	
	var formObj = $("form[role='form']");
	$("button[type='submit']").on('click', function(e){
		e.preventDefault();
	  	var str = "";
		
		//이벤트 사진 보내기
	  	var uuidd = $("#uuid").val();
        var fileNamee = $("#fileName").val();
        var uploadPathh = $("#uploadPath").val();
        
        console.log(uuid);
        console.log(fileName);
        console.log(uploadPath);
          str += "<input type='hidden' name='uuid' value='" + uuidd + "'/>";
          str += "<input type='hidden' name='fileName' value='" + fileNamee + "'/>";
          str += "<input type='hidden' name='uploadPath' value='" + uploadPathh + "'/>";
   
		 console.log("attach : " + str);
		 formObj.append(str).submit();  
	});
	
	//사진 삭제 처리
	$('#PosterResult').on('click', 'button', function(e){
		console.log("delete file");
		var targetFile = $(this).data('file');
		var type	   = $(this).data('type');
		var targetLi   = $(this).closest('li');
		
		$.ajax({
			type : 'post',
			url :'/deleteFile',
			data : {fileName:targetFile, type:type} ,
			dataType : 'text',
			success : function(result){
				alert("사진이 삭제되었습니다.");		//성공하면
				targetLi.remove();	//해당 li 삭제
			}
		})//END .ajax() 
	});
	
</script>
					

 
