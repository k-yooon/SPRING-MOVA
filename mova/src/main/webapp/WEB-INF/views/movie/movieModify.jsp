<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@ include file="../include/header.jsp" %>
<style>
.uploadResult { width:100%;	background-color:gray; }
.uploadResult ul { 	display:flex; 	justify-content:center;
					flex-flow:row;	align-items: center; }	
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
.page-header{margin-left: 30px;}
.row{margin-top: 30px; margin-right: 30px; margin-left: 30px;}
ul{list-style-type: none;}
</style>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
        	MOVIE MODIFY</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <!-- DataTables Advanced Tables -->
                <!-- Board Register -->
                <!-- Board Read Page -->
                MOVIE MODIFY
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
				<!-- 게시물 수정 폼 -->	
				<form role="form" method="post" action="/movie/movieModify">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
					<div class="form-group">
						<input type="hidden" name="mno" value="${movie.mno}">
					</div>
					<label>POSTER</label>
					<div class="PosterResult">
						<ul>
							<li>
								<input type='hidden' name='fileName' id='fileName' value='${movie.fileName}'/>
								<input type='hidden' name='uploadPath' id='uploadPath' value='${movie.uploadPath}'/>
								<input type='hidden' name='uuid' id='uuid' value='${movie.uuid}'/>
								<div>
									<c:set var="fileCallPath" value='${movie.uploadPath}\\${movie.uuid}_${movie.fileName}'/>
			          				<button type='button' id="nowPoster" data-file='${str:encodeURI(fileCallPath)}' data-type='image' class='btn btn-warning btn-circle'>
									<i class='fa fa-times'></i>
									</button><br>
									<img src="/poster?fileName=${str:encodeURI(fileCallPath)}" style="width:250px; height:330px;">
								</div>
							</li>	
						</ul>
					</div>
					<input type='file' name='uploadposter'>
					<div class="form-group">
						<label>mname</label>
						<input class="form-control" name="mname" value="${movie.mname}">
					</div>	
					
					<div class="form-group">
						<label>year</label>
						<input class="form-control" name="year" value="${movie.year}">
					</div>
					<div class="form-group">
						<label>nation</label>
						<input class="form-control" name="nation" value="${movie.nation}">
					</div>	
					<div class="form-group">
						<label>genre</label>
						<input class="form-control" name="genre" value="${movie.genre}">
					</div>	
					<div class="form-group">
						<label>summary</label>
						<input class="form-control" name="summary" value="${movie.summary}">
					</div>	
					<div class="form-group">
						<label>director</label>
						<input class="form-control" name="director" value="${movie.director}">
					</div>	
					<div class="form-group">
						<label>actor</label>
						<input class="form-control" name="actor" value="${movie.actor}">
					</div>		
						<button type="submit" data-oper="modify" class="btn btn-default" id="modify">Modify</button>	<!-- 수정 처리 -->
						<button type="submit" data-oper="remove" class="btn btn-danger" id="remove">Remove</button>	<!-- 삭제 처리 -->	   
						<button data-oper='list' class="btn btn-info" id="list">List</button>	<!-- 목록 페이지 이동 -->
				</form>
				<!-- END 게시물 등록 폼 -->			
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-6 -->
</div> 
<!-- /.row -->
<div class="row">
	<div class="col-1g-12">
		<div class="panel panel-default">
				<div class="panel panel-heading">File attach</div>	
					
					<div class="panel-body">
					
						<div class="form-group" id="uploadDiv">
							<input type="file" name="uploadFile" multiple="multiple">
						</div>
					
						<div id="uploadResult">
							<ul>	
								
							</ul>
						</div>	
			</div><!-- /.panel-body -->
				<!-- END 업로드 결과 출력 -->
        </div> <!-- /.panel -->
    </div><!-- /.col-lg-6 -->
</div><!-- /.row -->
 <!-- END 첨부파일 추가 영역 -->

<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

//ajax 전송 시 CSRF 토큰 전송 처리
$(document).ajaxSend(function(e, xhr, options){
    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

//포스터 x 클릭 시
$(".PosterResult").on("click", "button", function(e){
	console.log("click");
	var targetFile = $(this).data('file');
	var type	   = $(this).data('type');
	var targetLi = $(this).closest("li");
	var chk = confirm("포스터를 삭제하시겠습니까?");
	if(chk){
		$.ajax({
			type : 'post',
			url :'/deleteFile',
			data : {fileName:targetFile, type:type} ,
			dataType : 'text',
			success : function(result){
				alert("포스터가 삭제되었습니다.");	//성공하면
				targetLi.remove();	//해당 li 삭제
			}
		});
	}	
});

	//-------------------파일 업로드 처리-------------------------//
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

	//var cloneObj = $("#uploadDiv").clone();

	//포스터업로드ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
		formData.append("poster", files[i]);
	}
	$.ajax({
		type : 'POST',
		url :'/uploadPoster',
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


//스틸컷업로드ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
$("input[name='uploadFile']").change(function(e){
	var formData = new FormData();	//가상의 <form> 태그
	
	var inputFile = $("input[name='uploadFile']");
	var files = inputFile[0].files;
	console.log(files);
	
	//formData 객체에 선택한 파일 추가
	for(var i=0 ; i<files.length ; i++){
		//확장자 및 파일 크기 확인
		if(!checkExension(files[i].name, files[i].size)){
			return false;
		}
		formData.append("uploadFile", files[i]);
	}
	
	$.ajax({
		type : 'POST',
		url :'/uploadAjaxAction',
		data : formData,
		dataType : 'json',
		contentType : false,
		processData : false,
		success : function(result){
			console.log(result);	//콘솔로 결과 확인
			
			showUploadResult(result); 
			
			//복사해 둔 div를 이용하여 업로드 영역 초기화
		//	$('#uploadDiv').html(cloneObj.html());
		}
	})//END .ajax()
});//END uploadBtn 이벤트 처리 


function showUploadResult(uploadResultArr){
	if(!uploadResultArr || uploadResultArr.length == 0){
		return;
	}

	var uploadUL = $('#uploadResult ul');
	var str = "";
	$(uploadResultArr).each(function(i, obj){
		//업로드 파일명 <li>추가
		console.log("dd" + obj);
		console.log(obj.uploadPath);
		console.log(obj.uuid);
		console.log(obj.fileName);
		
			console.log("이미지맞음");
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
			str += "<li data-path='" + obj.uploadPath + "' " 			+
					   "data-uuid='" + obj.uuid + "' " 					+
					   "data-filename='" + obj.fileName + "'" 			+ 
					   "<div><span>" + obj.fileName + "</span>"			+
				       "    <button type='button' " 					+ 
				       "            data-file='" + fileCallPath + "'" 	+
				       "            data-type='image'" 					+
				       "        class='btn btn-warning btn-circle'>" 	+
				       "        <i class='fa fa-times'></i></button><br>" +
				       "    <img src='/display?fileName="+ fileCallPath + "'>" +
				       "    </div></li>";
		
		console.log("attach : " + str);
	});
	uploadUL.append(str);
	
}//END showUploadResult()


function showUploadPoster(PosterResultArr){
	if(!PosterResultArr || PosterResultArr.length == 0){
		return;
	}

	 var uploadUL = $('.PosterResult ul');
	 var str = "";
	 $(PosterResultArr).each(function(i, obj){
         console.log(obj.uploadPath);
         console.log(obj.uuid);
         console.log(obj.fileName);
        
         var fileCallPath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName);
         
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
			    "    <img src='/poster?fileName="+ fileCallPath + "' style='width:250px; height:330px;''>" +
			    "    </div></li>";
         });
      console.log(str);
      uploadUL.append(str);

}

var formObj = $("form");	
//삭제버튼
$('#remove').on("click", function(e){
	e.preventDefault();
	var chk = confirm("영화를 삭제하시겠습니까?");
	if(chk){
		formObj.attr("action", "/movie/movieRemove");
		formObj.submit();
	}
});

//목록버튼 
$('#list').on("click", function(e){
	e.preventDefault();
	self.location= "/movie/movieList";
	return;
});

//수정버튼 
$('#modify').on("click", function(e){
	var str = "";
	 $('#uploadResult ul li').each(function(i, obj){	
		 var jobj = $(obj);	//첨부 파일 정보 hidden 태그로 추가
		 console.log('jobj : ' + obj);
	 	 str += "<input type='hidden' " +
		 		"       name='movieList[" + i + "].fileName' " +
		 		"       value='" + jobj.data("filename") + "'>";

		 str += "<input type='hidden' " +
		 		"       name='movieList[" + i + "].uuid' " +
		 		"       value='" + jobj.data("uuid") + "'>";

		 str += "<input type='hidden' " +
		 		"       name='movieList[" + i + "].uploadPath' " +
		 		"       value='" + jobj.data("path") + "'>";
	 
	 });

	 formObj.submit();
});

//스틸컷파일 목록 가져오기
(function(){	
	var mno = '<c:out value="${movie.mno}"/>';
	$.getJSON("/movie/getAttachList", {mno:mno}, function(arr){	console.log(arr);	
		var str = "";
		$(arr).each(function(i, obj){
			//업로드 파일명 <li>추가
		
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid  + "_" + obj.fileName);

				str += "<li data-path='" + obj.uploadPath + "' " 			+
						   "data-uuid='" + obj.uuid + "' " 					+
						   "<div><span>" + obj.fileName + "</span>"			+
					       "    <button type='button' " 					+ 
					       "            data-file='" + fileCallPath + "'" 	+
					       "            data-type='image'" 					+
					       "        class='btn btn-warning btn-circle'>" 	+
					       "        <i class='fa fa-times'></i></button><br>" +
					       "    <img src='/display?fileName="+ fileCallPath + "'>" +
					       "    </div></li>";
			
		});	
		$("#uploadResult ul").html(str);
	});
})();


$("#uploadResult").on("click", "button", function(e){
	console.log("delete file");

	if(confirm("REMOVE THIS FILE?")) {

		var targetLi = $(this).closest("li");
		targetLi.remove();
		}
});


</script>