<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class='uploadDiv'>
 <input type ="file" name="uploadFile" multiple>
</div>

<div class='uploadResult'>
	<ul>
	
	</ul>
</div>

<button id="uploadBtn">Upload</button>
<script
	src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous">
</script>
<script>
//목록보여주는 함수
	 var uploadResult = $(".uploadResult ul");
	 function showUploadedFile(uploadResultArr) {
	 	
	 	var str = "";
	 	
	 	$(uploadResultArr).each(function(i, obj) {
	 		
	 		var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
	 		
	 		
	 		
	 		str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
	 	
	 	});
	 	
	 	uploadResult.append(str);
	 }


var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	//확장자 제한 정규표현식
var maxSize = 5242880;	//파일 최대 업로드 크기 제한 5MB

function checkExtension(fileName, fileSize){
	if(fileSize >= maxSize) {	//파일 크기 확인
		alert("파일 사이즈 초과!");	//크기를 초과하면 알림 메시지 출력
		return false;
	}
	if(regex.test(fileName)) {	//확장자 확인
		alert("업로드 불가 파일");	//제한 확장자인 경우 알림 메시지 출력
		return false
	}
	return true;	//파일 크기 및 확장자 문제가 없는 경우
}//END checkExension() */

 $(document).ready(function(){
	 
	 

	 
	 
	 var cloneObj = $(".uploadDiv").clone();
	 
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files); 
		
		for(var i = 0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size) ){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		
		
	 
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
				
				showUploadedFile(result);
				
				$(".uploadDiv").html(cloneObj.html());
				
			}
		}); 

	});
  });
  

</script>
</body>
</html>