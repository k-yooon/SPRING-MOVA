<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/header.jsp" %>
<style>
	.content-area{
		width: 110%;
		word-break:break-all;
	}
	.mname, .genre{
		 display: inline-block;
	}
	.movieImg{
		width: 250px;
		margin-left: 20px;
	}
	#selector1{
   	  width: 170px;
   	  margin-left: 50px;
   }
   #readmore{
   	 height: 40px; 
   	 color: white;
   	 background-color: #02A388;
   	 margin-right: 130px;
     margin-left: 130px;
     margin-top: 10px;
     text-align: center;
     font-size: 25px;
   }
   #readmore:hover{
   	 background-color: #FF5A5A;
   }
</style>

<!-- 코멘트 출력 -->
	<div class="agile_featured_movies">
			 <div class="inner-agile-w3l-part-head">
				<h3 class="w3l-inner-h-title">My Comment List</h3>
				<p class="w3ls_head_para">코멘트 목록</p>
			</div>
			<div>
				<select name="type" id="selector1" class="form-control1">
      	 			<option value="date" selected>등록순</option>
         			<option value="starD">별점 높은순</option>
         			<option value="starA">별점 낮은순</option>
    			</select> 
			</div> 
		<div class="latest-news-agile-info" id="commbox">
			<div class="col-md-8 latest-news-agile-left-content" id="commbox">
			</div>
		</div>
	</div>

<script>
$(function(){
	var keyword = $("#selector1").val();
	showComm(keyword);
	var check = 0;
	var str = "";
	var vlist = ""
	//코멘트 목록 가져오기
	function getList(userid, keyword, callback, error){
		console.log("commgetList");
		$.getJSON("/member/allMyCommentList/" + userid + "/" + keyword + ".json", function(response){
				if(callback){
					callback(response);		
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	function showComm(keyword){
		var userid = "${param.userid}";
	      getList(userid, keyword, function(list){
	            var start = check * 10;
	            var end = (check * 10) + 10;
	            var morecheck = true;
	            if(list.length < 10){
	               end = list.length;
	               morecheck = false;
	            }
	            vlist = list;
	            console.log("listlength : " + list.length);
	            for(var i=start; i<end; i++){
	               str += "<div class='w3-agileits-news-one'><div>" + (i+1) + "</div>" + 
						  "<div class='wthree-news-img'><a href='../movie/movieInfo?mno=" + list[i].mno + "'>" +
						  "<img src='../resources/images/movie/poster/" + list[i].movie.fileName + "' class='movieImg' style='width: 250px; height: 320px;'></div>" + 
						  "<div class='wthree-news-info'><h5 class='mname'>" + list[i].movie.mname + "</a></h5> " + 
						  "<h6 class='genre'> " + list[i].movie.genre + "|" + list[i].movie.year + "</h6>" + 
						  "<div class='agile-post'>" + showMyStar(list[i].star) + "</div>" + 
						  "<p class='content-area'>" + list[i].content + "</p>" +
						  "<div class='agile-post' id='datee'>" + displayTime(list[i].regdate) + "</div></div><div class='clearfix'></div><hr></div>";
	            }
	            if(morecheck){
	               str += "<div class='more1' id='readmore'>ReadMore</div><div class='comment-area2'></div>";
	            }
	            $('#commbox').html(str);
	         }, function(xhr, status, error){
	            alert(error);
	             }  
		 );
	   }
	
	function showComm2(start, end, list, check){
	      console.log(start + end);
	      var str2="";
	      var morecheck = true;
	      if(list.length < end){
	         end = list.length;
	         morecheck = false;
	      }
	      for(var i=start; i<end; i++){
	         str2 += "<div class='w3-agileits-news-one'>" + 
			  		 "<div class='wthree-news-img'><a href='../movie/movieInfo?mno=" + list[i].mno + "'>" +
			  		 "<img src='../resources/images/movie/poster/" + list[i].movie.fileName + "' class='movieImg' style='width: 250px; height: 320px;'></div>" + 
			 		 "<div class='wthree-news-info'><h5 class='mname'>" + list[i].movie.mname + "</a></h5> " + 
			  		 "<h6 class='genre'> " + list[i].movie.genre + "|" + list[i].movie.year + "</h6>" + 
			 		 "<div class='agile-post'>" + showMyStar(list[i].star) + "</div>" + 
			 		 "<p class='content-area'>" + list[i].content + "</p>" +
			 		 "<div class='agile-post' id='datee'>" + displayTime(list[i].regdate) + "</div></div><div class='clearfix'></div><hr></div>";  
	      }
	     if(morecheck){
	        str2 += "<div class='more" + String((check+1)) + "' id='readmore'>ReadMore</div><div class='comment-area" + String((check+2)) + "'></div>";
	     } 
	    var area = ".comment-area" + String((check+1));
	     $(area).html(str2);
	   }
	
	 //코멘트 더보기 클릭시 처리
	   $(document).on("click","div[class^='more']",function(e){
	       check = check + 1;
	       var start = check * 10;
	       var end = (check * 10) + 10;
	       console.log("더보기 클릭");
	       showComm2(start, end, vlist, check);
	       var button = ".more" + String(check);
	       $(button).hide();
	    });
	 
	 //코멘트 정렬
	 $("#selector1").on("change", function(e){  
	   var keyword = $(this).val();
	   str="";
	   vlist="";
	   check = 0;
	   showComm(keyword);
   });
	
	//별점 출력
	function showMyStar(astar){
	      var innerHtml = "";
	      var dbstar = Number(astar);
	      var sosu = false;
	      console.log("mystar : " + dbstar);
	      if(dbstar == 1.5 || dbstar == 2.5 || dbstar == 3.5 || dbstar == 4.5){
	         sosu = true;
	      } 
	      var star = Math.round(dbstar);   
	      
	      if(sosu){
	         for(var i =1 ; i < star; i++) {  
	              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: red"></i>';  
	         } innerHtml  += '<i class="fa fa-star-half-o" aria-hidden="true" style="color: red"></i>';
	         for(var j = 0; j < 5-star; j++){
	            innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>';  
	         }
	      } else {
	         for(var i =0 ; i < 5; i++) {  
	            if(i < star){
	              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: red"></i>';  
	            } else {
	               innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>';  
	            }
	         } 
	      } 
	      return innerHtml;
	   }
	
});
</script>
<script>
function displayTime(timeValue){
   var today = new Date();
   var dateObj = new Date(timeValue);
   var str = "";
   
   //댓글 등록일이 오늘이면  '시:분:초' 표시
   if(today.getDate() === dateObj.getDate()){
       var hh = dateObj.getHours() ;
       var mi = dateObj.getMinutes();
       var ss = dateObj.getSeconds();
       
       return [ (hh > 9 ? '' : '0') + hh, ":" ,
               (mi > 9 ? '' : '0') + mi, ":" ,
               (ss > 9 ? '' : '0') + ss ].join('');
   } else { //그렇지 않으면 '연/월/일' 표시
      var yy = dateObj.getFullYear();
      var mm = dateObj.getMonth() + 1;
      var dd = dateObj.getDate();
      
      return [ yy, '/', 
             (mm > 9 ? '' : '0') + mm, '/',
             (dd > 9 ? '' : '0') + dd].join('');         
   }
}; //END displayTime()
</script>
																		
