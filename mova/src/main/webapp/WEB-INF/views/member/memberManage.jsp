<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ include file="../include/header.jsp" %>
<style>
	.form-control{
		width: 500px; 
		margin-left:28%; 
		display: inline-block;
	}
	.searchBtn{
		width: 80px; 
		height: 35px;
		display: inline-block;
		border-radius: 5px; 
		padding-top: 5px;
		margin-left: 5px;
		background-color: #02A388;
		color: white;
		text-align: center;
	}
	.searchBtn:hover{
		background-color: #FF5A5A;
	}
	#user{
		text-align: center;
	}
</style>

<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
         	<h3 class="w3l-inner-h-title">회원 관리</h3>
         	<p class="w3ls_head_para">회원 검색하기</p>
      	</div>
			<div class="form-group">
				<input class="form-control" name="userid" placeholder="ID를 입력해주세요">
				<div class="searchBtn">검색</div>
			</div>
			 <div class="panel-body">
				<ul id="user" style="list-style: none;">
					
				</ul>		
            </div>		
		</div>
	</div>
</div>



<script>


$(".searchBtn").on('click', function(e){
	var userid = $("input[name=userid]").val();
	console.log(userid);

	function get (userid, callback, error) {
		$.get("/member/memberManage/" + userid + ".json", function(result){
			if (callback) { callback(result);}
		}).fail(function(xhr, status, err){
			if (error) {
				error();
			}
		});
	}
	var replyUl = $('#user');
	get(userid, function(data){

		if(data == null || data.length == 0){	//회원 없을 시
				replyUl.html("존재하지 않는 회원입니다.");
				return;
		}
	
		
		var str ="";
		str += "<a href='mypage?userid=" + data.userid + "&star=5'><li> " + data.userid + "</li></a>";
		str += "<li> " + data.usernm + "</li>";
		str += "<li> " + data.tel + "</li>";
		str += "<li> " + data.email + "</li>";
		console.log(str);
		replyUl.html(str);
	});

});




</script>
