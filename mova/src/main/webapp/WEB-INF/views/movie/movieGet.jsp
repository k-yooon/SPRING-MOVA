<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ include file="../include/header.jsp" %>
<style>
	.page-header{margin-left: 30px;}
	.box{margin-left: 30px; margin-right: 30px;}
	.row{margin-top: 30px;}
	ul{list-style-type: none;}
</style>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">MOVIE GET</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<div class="box">
					<input type="hidden" name="mno" value="${movie.mno}" >
					<div id="PosterResult">
							<ul>	
								<li>
								</li>
							</ul>
					</div>	
						<input type="hidden" name="uploadPath" value="${movie.uploadPath}" >
						
					<div class="form-group">
						<label>mname</label>
						<input class="form-control" name="mname" value="${movie.mname}" readonly="readonly">
					</div>		
						<div class="form-group">
						<label>year</label>
						<input class="form-control" name="year" value="${movie.year}" readonly="readonly">
					</div>	
						<div class="form-group">
						<label>nation</label>
						<input class="form-control" name="nation" value="${movie.nation}" readonly="readonly">
					</div>	
						<div class="form-group">
						<label>genre</label>
						<input class="form-control" name="genre" value="${movie.genre}" readonly="readonly">
					</div>	
						<div class="form-group">
						<label>summary</label>
						<input class="form-control" name="summary" value="${movie.summary}" readonly="readonly">
					</div>	
						<div class="form-group">
						<label>director</label>
						<input class="form-control" name="director" value="${movie.director}" readonly="readonly">
					</div>	
						<div class="form-group">
						<label>actor</label>
						<input class="form-control" name="actor" value="${movie.actor}" readonly="readonly">
					</div>	
	
					<button data-oper='modify' class="btn btn-default" onclick="location.href='/movie/movieModify?mno=<c:out value="${movie.mno }"/>'">
						modify</button>
					<button data-oper='list' class="btn btn-info" onclick="location.href='/movie/movieList'">
						List</button> 					
									
					<!-- 폼 태그 추가 -->
					<form id="operForm" action="/movie/movieModify">
						<input type="hidden" id="mno" 
							   name="mno" value="${movie.mno }">
						<!-- 페이지 번호와 페이지 당 표시 개수 파라미터 추가 -->
						<input type="hidden"  
							   name="pageNum" value="${cri.pageNum }">
						<input type="hidden"  
							   name="amount" value="${cri.amount }">	
					</form>
					
<div class="row">
	<div class="col-1g-12">
		<div class="panel panel-default">
				<div class="panel panel-heading">File attach</div>	
					
					<div class="panel-body">
		            	<div id='uploadDiv'> 
							
						</div>
						
						<!-- 섬네일 이미지 원본 표시 -->
						<div class="bigPictureWrapper">
							<div class="bigPicture">
							</div>	
						</div>
						<!-- END 섬네일 이미지 원본 표시 -->
						
						<!-- 업로드 결과 출력 -->
					
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
 </div>

<script>
(function(){	//첨부파일 목록 가져오기
	var mno = '<c:out value="${movie.mno}"/>';
	console.log("mno : " + mno);
	$.getJSON("/movie/getAttachList", {mno:mno}, function(arr){
		console.log(arr);	
	
		var str = "";
		$(arr).each(function(i, obj){
			//업로드 파일명 <li>추가
			if(obj.fileType){	//이미지인 경우
				var fileCallPath 
				= encodeURIComponent(obj.uploadPath + 
									 "/" + obj.uuid  + "_" +
									 obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");			
				str += "<li data-path='" + obj.uploadPath + "' " 	+
					   "    data-uuid='" + obj.uuid + "' " 			+
					   "    data-filename='" + obj.fileName + "'>" 	+
					   "    <div><span>" + obj.fileName + "</span><br>"	+  
					   "    <img src='/resources/img/attach.png'></div></li>";
			
			} else {		//이미지가 아닌 경우		
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid  + "_" + obj.fileName);

				str += "<li data-path='" + obj.uploadPath + "' " 			+
						   "data-uuid='" + obj.uuid + "' " 					+
						   "data-filename='" + obj.fileName + "'>" 			+
					       "<div><img src='/display?fileName="+ fileCallPath + "'>" +
					       "    </div></li>";
			}
		});	
		$("#uploadResult ul").html(str);
	});
	
		var uuid = '<c:out value="${movie.uuid}"/>';
		var uploadPath = $("input[name='uploadPath']").val();
		var fileName = '<c:out value="${movie.fileName}"/>';
		console.log("uuid : " + uuid);
		console.log("uploadPath : " + uploadPath);
		console.log("fileName : " + fileName);
		
		var fileCallPath = encodeURIComponent(uploadPath + "\\" + uuid  + "_" + fileName);
		console.log(fileCallPath);
		
		var str = "";
		str += "<div><img src='/poster?fileName="+ fileCallPath + "'>" +
	           "</div></li>";
		
	     console.log(str);
	     $("#PosterResult ul li").html(str);

})();
</script>