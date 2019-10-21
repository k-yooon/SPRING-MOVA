<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@ include file="../include/header.jsp" %>
<style>

.class, .find, .followListBtn, .followerListBtn, .followerCount, .followCount, #userimage {
   display: inline-block;
}
.class img{
   width: 70px; height: 70px; border-radius: 10px;
   padding-left: 50%;
}

.label label-info{
   display: inline-block; 
   padding-left: 50%;
}


  .w3-agileits-news-one{
      background-color: yellow;
   }
   .inner-agile-w3l-part-head{
      height : 80px;
      border-bottom-color: gray;
      border-bottom-style: solid;
      border-bottom-width: 1px;
      box-sizing: border-box;
   }
   ul{ list-style: none;}
   
   .starBtn{
      width: 100%;
      text-align: center;
   }
   
   button{
      width:100px;
      background-color: #BDBDBD;
      border: none;
      color:#353535;
      padding: 15px 0;
      
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 15px;
      margin: 4px;
      cursor: pointer;
      margin-left: 50px;
      margin-right: 50px;
      font-weight: bold;
   }
   
   button:hover{
      background-color: #FFE400; 
      -webkit-transition: all .28s ease-in-out; transition: all .28s ease-in-out;}
   
   button:focus{
      background-color: #FFE400;
      color:black;
      font-weight: bold;
   }
   
   .listBtn{
      width:400px;
      background-color: #02a388;
      border: none;
      color:white;
      padding: 15px 0;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 15px;
      margin: 4px;
      cursor: pointer;
      margin-left: 20px;
      margin-right: 20px;
      font-weight: bold;
      color: #fff;
      letter-spacing: 1px;
      text-transform: uppercase;
      font-size: 0.9em;
   }
   
   .listBtn:hover{
      background-color : #FF5A5A;
      -webkit-transition: all .28s ease-in-out; transition: all .28s ease-in-out;
   }
   
   .listBtn:focus{
      background-color : #FF5A5A;
   }
   
   .textM{
      font-weight: bold;
      font-size: 30px;
      margin-right: 100px;
   }
   
   #poster{
      width: 200px;
      height: 300px;
      margin-top : 50px;
      margin-bottom: 80px;
      margin-left : 100px;
      background-color: pink;
   }
   
   .movieNm{
      font-weight: bold;
      font-size: 20px;
   }
   
   .mName{
      margin-left: 100px;
   }
   
   .box{
      margin-top: 40px;
   }
   #my{
      width: 100%;
   }
   
   .modify{
      background-color: black;
      color: white;
      border-radius: 30px;
      width: 200px;
      float: right;
   }
   
   .showFollowBtn{
   	  background-color: skyblue;
      color: white;
      border-radius: 30px;
      width: 200px;
      float: right;
   }
   
   .showfollowerBtn{
   	  background-color: white;
      color: skyblue;
      border-radius: 30px;
      border: 2px solid skyblue;
      width: 200px;
      float: right;
   }
   
   .modify:hover{
      background-color: black;
      color:#02a388;
      -webkit-transition: all .28s ease-in-out; transition: all .28s ease-in-out;
   }
   
   .modify:focus{
      background-color: black;
      color:#02a388;
      font-weight: bold;
   }
   
   .remove{
      width: 200px;
      float: right;
      color:white;
      border-radius: 30px;
      background-color: black;
      float: right;
   }
   
   .remove:hover{
      color:#02a388;
      background-color: black;
      -webkit-transition: all .28s ease-in-out; transition: all .28s ease-in-out;
      font-weight: bold;
   }
   .remove:focus{
      color:#02a388;
      background-color: #5D5D5D;
   }
   .userid{
   	  display: inline-block;
   	  font-size: 32px;
   	  margin-right: 10px;
   }
   .userImg{
   	  width: 80px;
   	  height: 80px;
   	  border-radius: 100px;
   	  display: inline-block;
   	  margin-left: 50px;
   }
   .id{
   	  display: inline-block; 
   	  font-size: 20px;
  	  margin-left: 50px;
  	  width: 100px;
   }
   .find{
   	  margin-left:100px;
   	  width: 100px;
   }
   #follow2{
   	  background-color: skyblue;
      color: white;
      border-radius: 30px;
      width: 80px;
      height: 45px;
      display: inline-block;
   }
   #unfollow2{
   	  background-color: white;
      color: skyblue;
      border-radius: 30px;
      border: 2px solid skyblue;
      width: 80px;
      height: 50px;
      display: inline-block;
   }
    #readmore{
   	 height: 40px;
   	 width: 1100px; 
   	 color: white;
   	 background-color: #02A388;
   	 margin-right: 130px;
     margin-left: 130px;
     margin-top: 10px;
     text-align: center;
     font-size: 25px;
     float: right;
   }
   #readmore:hover{
   	 background-color: #FF5A5A;
   }
   .myMovie{
   	 margin-top: 15px;
   }
   #profile{
   	 margin-top: 30px;
   	 margin-left: 30px;
   }
  
</style>

<div class="w3_breadcrumb">
   <div class="breadcrumb-inner">   
         <ul>
            <li><a href="/">Home</a><i>//</i></li>
            <li>MyPage</li>
         </ul>
    </div>
</div>
<!-- //breadcrumb -->
         <!--/content-inner-section-->
                  <div id = "userimage">
                  	<c:choose>
	   					<c:when test="${empty user.uploadPath || user.uploadPath eq 'undefined'}"> 
	                         <div><img src="../resources/images/movie/poster/user.jpg" id="profile" style="width: 150px; height:150px; border-radius: 100px;"></div>
	                    </c:when>
	                    <c:otherwise>
	                         <c:set var="fileCallPath" value='${user.uploadPath}\\${user.uuid}_${user.fileName}'/>
	                         <div><img src="/userimage?fileName=${str:encodeURI(fileCallPath)}" id="profile" style="width: 150px; height:150px; border-radius: 100px;"></div> 
	                    </c:otherwise> 
                    </c:choose>
                  </div>
                   <div class="inner-agile-w3l-part-head">
                        <div id = 'my'>
                        <sec:authentication property="principal" var="pinfo"/>      
                        <sec:authorize access="isAuthenticated()">
                           <c:choose>
                           	 <c:when test="${pinfo.username == 'admin'}">
                           	 	<button class="remove">탈퇴</button>
                           	 </c:when>
                           	 <c:when test="${pinfo.username == param.userid }">
                           	 	<button class="modify">회원 정보 수정</button>
                           	 </c:when>
                           	 <c:otherwise>
                           	 	<div class="followBtn"></div>
                           	 </c:otherwise>
                           </c:choose>
                        </sec:authorize>

                        <!-- 팔로잉 팔로워 버튼 -->
                        <div class="userid">${param.userid}</div>        
                        <!-- <div class="followBtn"></div> -->
                       	<div class="followListBtn">팔로잉  <div class="followCount"></div></div>
                        <div class="followerListBtn">팔로워  <div class="followerCount"></div></div>
                     </div>
                  </div>
                     <div class="inner-agile-w3l-part-head">
                           <button class = "listBtn" onclick="location.href='./wishList?userid=${param.userid}'">찜한 영화</button>
                            <sec:authorize access="isAuthenticated()">
                            <c:if test="${pinfo.username == param.userid }">
                           <button class = "listBtn" onclick="location.href='./myBoardList?userid=${param.userid}'">글 목록 조회</button> 
                           	</c:if>
                        	</sec:authorize>
                           <button class = "listBtn" onclick="location.href='./commentList?userid=${param.userid}'">별점 및 코멘트</button>
                     </div>
                        <div class = "starBtn">
                           <span class = "textM">나의 영화</span>
                           <button class = "5">5점</button> 
                           <button class = "4">4점</button> 
                           <button class = "3">3점</button> 
                           <button class = "2">2점</button> 
                           <button class = "1">1점</button> 
                        </div>
                        <div class = "myMovie">
                        </div>
    
                   
 

<!-- 팔로잉 리스트 모달  -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="head">팔로잉</h4>
                  </div>
                        
                        <div class = "followList">
                           <ul class = "follow" style="list-style: none;">
                                 
                           </ul>
                        </div>
                     </div>
                     <div class="forgot-grid">
                        <div class="clearfix"></div>
                     </div>
         </div>
</div>
<!-- end 팔로잉 리스트 -->    
<!-- 팔로워 리스트 모달  -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="head">팔로워</h4>
                  </div>
                        
                        <div class = "followList">
                           <ul class = "follow2" style="list-style: none;">
                                 
                           </ul>
                        </div>
                     </div>
                     <div class="forgot-grid">
                        <div class="clearfix"></div>
                     </div>
         </div>
</div>
<!-- end 팔로워 리스트 --> 
<script src="../resources/js/follow.js"></script>     
<script>
$(function(){
   
   var userid = null; 
   <sec:authorize access="isAuthenticated()">
   	userid = '<sec:authentication property="principal.username"/>';
   </sec:authorize>
   
    var follower = "${param.userid}"; 
   if(userid != follower){
      showFollow();
   }
   
   showFollwingCnt();
   showFollwerCnt();
    
    var modal = $("#myModal");
    var modal2 = $("#myModal2");
   
     var csrfHeaderName = "${_csrf.headerName}";
     var csrfTokenValue = "${_csrf.token}";

     //ajax 전송 시 CSRF 토큰 전송 처리
     $(document).ajaxSend(function(e, xhr, options){
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
     });
      
     var flist = ""
     //팔로잉 개수 출력
     function showFollwingCnt(){
    	 var follower = "${param.userid}";
    	 followService.followingCount(
    			 follower,
                 function(response){
                    var str ="";
                    str += response.count + " | ";
                    $(".followCount").html(str);
              }     
         );
     }
     
     //팔로워 개수 출력
     function showFollwerCnt(){
    	 var follower = "${param.userid}";
    	 followService.followerCount(
    			 follower,
                 function(response){
                    var str ="";
                    str += response.count;
                    $(".followerCount").html(str);
              }     
         );
     }
     
     //팔로워 목록 출력
     $(".followerListBtn").on("click", function(e){
       modal2.modal();
       followService.getList(
               {userid : userid, no:1},
               function(list){
                 flist = list;
               }, function(xhr, status, error){
                     alert(error);
                   }
            );  
        var check = false;
        var str = "";
        followService.getList(
                {userid : follower, no:2},
                function(list){
                  console.log(list);
                  for(var i = 0; i < list.length; i++){
                     check = false;
                      str += "<li><a href=?userid=" + list[i].userid + "&star=5>" + showUserImg(list[i].member.uploadPath, list[i].member.uuid, list[i].member.fileName) +  
                              "<div class='id'>" + list[i].userid + "</div></a>";
                              if(list[i].userid == userid){
                                 str += "<hr><li>";
                                 continue;
                              }
                              for(var j = 0; j < flist.length; j++){
                                 console.log(list[i].userid + " = " + flist[j].follower);
                                 if(list[i].userid == flist[j].follower){
                                  check = true;
                                 } 
                              } if(check){
                                 str += "<div class='find'><button id='unfollow2'>팔로워</button>";
                              } else {
                                 str += "<div class='find'><button id='follow2'>팔로우</button>";
                              }
                           str += "<input type='hidden' name= 'followid' value='" + list[i].userid + "'></div><hr></li>";
                  }
                  $(".follow2").html(str);
                }, function(xhr, status, error){
                      alert(error);
                    }
             );     
     });
     
     //팔로잉 목록 출력 
    $(".followListBtn").on("click", function(e){
       modal.modal();
       followService.getList(
               {userid : userid, no:1},
               function(list){
                 flist = list;
               }, function(xhr, status, error){
                     alert(error);
                   }
            );  
       var check = false;
       var str = "";
        followService.getList(
                {userid : follower, no:1},
                function(list){
                  console.log(list);
                  for(var i = 0; i < list.length; i++){
                     check = false;
                      str += "<li><a href=?userid=" + list[i].follower + "&star=5>" + showUserImg(list[i].member.uploadPath, list[i].member.uuid, list[i].member.fileName) +
                              "<div class='id'>" + list[i].follower + "</div></a>";
                              if(list[i].follower == userid){
                                 str += "<hr></li>";
                                 continue;
                              }
                           for(var j = 0; j < flist.length; j++){
                              console.log(list[i].follower + " = " + flist[j].follower);
                               if(userid == follower){
                                  check = true;
                                } else if (list[i].follower == flist[j].follower){
                                 check = true;
                                }
                              } if(check){
                                 str += "<div class='find'><button id='unfollow2'>팔로워</button>";
                              } else {
                                 str += "<div class='find'><button id='follow2'>팔로우</button>";
                              }
                              str += "<input type='hidden' name= 'followid' value='" + list[i].follower + "'></div><hr></li>";
                  }
                  $(".follow").html(str);
                }, function(xhr, status, error){
                      alert(error);
                    }
             );     
     });
     
     //팔로잉, 팔로워 목록에서 팔로잉 버튼 클릭했을 때
    $(document).on("click",".find",function(e){
    	<sec:authorize access="isAuthenticated()">
       	var userid = '<sec:authentication property="principal.username"/>';
       </sec:authorize>
       var id = $(this).find("button").attr('id');
       if(id === "unfollow2"){
          var follower2 = $(this).find("input[name='followid']").val()
          console.log(follower2);
          var removeChk = confirm(follower2 + " 님을 더이상 팔로잉하지 않겠습니까?");
          if(removeChk){
             followService.followRemove(follower2, userid, function(result){
                  alert("팔로잉이 취소됐습니다.")   
                  modal.modal("hide");
                  modal2.modal("hide");
                  showFollwingCnt();
                  showFollwerCnt();
                });  
          }
       } else if(id === "follow2"){
          var follower2 = $(this).find("input[name='followid']").val();
          followService.addFollow(  
                    { userid  : userid, 
                    follower  : follower2 },
                    function(result){
                       alert(follower2 + " 님을 팔로잉했습니다.")   
                      modal.modal("hide");
                       modal2.modal("hide"); 
                       showFollwingCnt();
                       showFollwerCnt();
                        
                    }
             );       
       }   
    });
    
    //초기 로드시 팔로잉 체크 및 버튼 출력
    function showFollow(){
    	<sec:authorize access="isAuthenticated()">
       	var userid = '<sec:authentication property="principal.username"/>';
       </sec:authorize>   //로그인한 사람
        var follower = "${param.userid}"; 
       console.log("showFollow" + userid + follower);
       followService.followCheck(
                {follower:follower, userid:userid},
                function(response){
                   if(response == null || response.length == 0){
                     var innerHtml = '<button class="showFollowBtn" id="follow">팔로우</button>';
                      $(document).on("click","#follow",function(e){
                        followService.addFollow(  
                                  { userid  : userid, 
                                  follower  : follower },
                                  function(result){   
                                     alert(follower + " 님을 팔로우했습니다");
                                     var innerHtml = '<button class="showfollowerBtn" id="unfollow">팔로워</button>';
                                    $(".followBtn").html(innerHtml); 
                                     showFollow();
                                     showFollwingCnt();
                                     showFollwerCnt();
                                  }
                               );
                     });
                   } else {
                     var innerHtml = '<button class="showfollowerBtn" id="unfollow">팔로워</button>';
                     $(document).on("click","#unfollow",function(e){
                             var removeChk = confirm(follower + " 님을 더이상 팔로잉하지 않겠습니까?");
                             if(removeChk){
                             followService.followRemove(follower, userid, function(result){
                                   var innerHtml = '<button class="showFollowBtn" id="follow">팔로우</button>';
                                   $(".followBtn").html(innerHtml);   
                                 });  
                             }
                             showFollow();
                             showFollwingCnt();
                             showFollwerCnt();
                      });
                   }
                  $(".followBtn").html(innerHtml); 
             }     
        );        
    }
    
    
    //영화조회
    window.onload=function(){ 
      click();
   }

   function click(){
      var star = 5;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      $('.5').focus();
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   };
   
   $(".5").click(function click(){
      
      var star = 5;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   });


   
   $(".4").click(function(){
      var star = 4;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   });
   
   $(".3").click(function(){
      var star = 3;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   });
   
   $(".2").click(function(){
      var star = 2;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   });
   
   $(".1").click(function(){
      
      var star = 1;
      var str = "<input type='hidden' id='star' value='" + star + "'>";
      
      console.log(star);
      
      $('.myMovie').html(str);
      
      getList(1);
   });
   
   var check = 0;
   
   function getList(param, callback, error){
      console.log("getList()");
      var star = $("#star").val();
      var check = 0;
      var userid = "${param.userid}";
      
      console.log(star);
      
      $.getJSON(
         "/member/mymovie/" + userid + "/" + star + ".json",
         function(list){
            console.log(list);
            
            var start = check * 10;
               var end = (check * 10) + 10;
               var morecheck = true;
               var myMovie = $('.myMovie');
            var str = "";
            
            vlist = list;
            
            $(list).each(function(i, obj){
               
               console.log(obj.movieList.length);
               
               if(obj.movieList.length < 10){
                    end = obj.movieList.length;
                    morecheck = false;
                 }
               
               var movieList = obj.movieList;
               console.log(movieList);
               
               for(var i=start; i<end; i++){
                  console.log(movieList[i].mname);
                  
                  var fileCallPath = encodeURIComponent(movieList[i].uploadPath + "\\" + movieList[i].uuid + "_" + movieList[i].fileName);
                      var Path = movieList[i].uploadPath + "\\" + movieList[i].uuid + "_" + movieList[i].fileName;
                      Path = Path.replace(new RegExp(/\\/g), "/");
                      
                      str += "<div class='col-md-2 w3l-movie-gride-agile requested-movies'>" +
                      	"<a href='/movie/movieInfo?mno=" + movieList[i].mno + "'>" +
			         	"<div class='poster'><img src='../resources/images/movie/poster/" + movieList[i].fileName + "' style='width: 250px; height: 330px'>" +
			            "</div><div class='mid-1 agileits_w3layouts_mid_1_home'><div class='w3l-movie-text'>" + 
			            "<h6>" + movieList[i].mname + "</a></h6></div>" + 
			          	"<div class='clearfix'></div></div></div>";
               }
               
            });  
            
             if(morecheck){
                  str += "<div class='more1' id='readmore'>ReadMore</div><div class='comment-area2'></div>";
               }
             
             myMovie.html(str);
   
         }).fail(function(xhr, status, er){
            if(error){
               error(er);
            }
         });
   } //END getList 
   
   function showList(start, end, list, check){
      console.log(list);
      var morecheck = true;
      var str2="";
      
      $(list).each(function(i, obj){
         
         console.log("2show : " + obj.movieList.length);
         
         if(obj.movieList.length < end){
              end = obj.movieList.length;
              morecheck = false;
           }
         
         var movieList = obj.movieList;
         console.log("==========");
         console.log(movieList);
         
         for(var i=start; i<end; i++){
            console.log("222 : " + movieList[i].mname);
            
            var fileCallPath = encodeURIComponent(movieList[i].uploadPath + "\\" + movieList[i].uuid + "_" + movieList[i].fileName);
                var Path = movieList[i].uploadPath + "\\" + movieList[i].uuid + "_" + movieList[i].fileName;
                Path = Path.replace(new RegExp(/\\/g), "/");
                
                str2 += "<div class='col-md-2 w3l-movie-gride-agile requested-movies'>" +
              	"<a href='/movie/movieInfo?mno=" + movieList[i].mno + "'>" +
	         	"<div class='poster'><img src='../resources/images/movie/poster/" + movieList[i].fileName + "' style='width: 250px; height: 330px'>" +
	            "</div><div class='mid-1 agileits_w3layouts_mid_1_home'><div class='w3l-movie-text'>" + 
	            "<h6>" + movieList[i].mname + "</a></h6></div>" + 
	          	"<div class='clearfix'></div></div></div>";
         }
         
      });  
      
       if(morecheck){
          str2 += "<div class='more" + String((check+1)) + "' id='readmore'>Read More</div><div class='comment-area" + String((check+2)) + "'></div>";
         }
       
       var movie2 = ".comment-area" + String((check+1));
       $(movie2).html(str2);
   }

    //코멘트 더보기 클릭시 처리
      $(document).on("click","div[class^='more']",function(e){
          check = check + 1;
          var start = check * 10;
          var end = (check * 10) + 10;
          console.log("더보기 클릭");
          showList(start, end, vlist, check);
          var button = ".more" + String(check);
          $(button).hide();
      });
      var userid ="";
      <sec:authorize access="isAuthenticated()">
     	userid = '<sec:authentication property="principal.username"/>';
     </sec:authorize> 
     
    $(".modify").click(function(){
       self.location = "/member/infoModify?userid=" + userid; 
    });
      
      function showUserImg(uploadPath, uuid, fileName){
    	  	var str = "";
    	  	if(uploadPath == null || uploadPath.length <= 0 || uploadPath == 'undefined'){
    	  		str = "<img src='../resources/images/movie/poster/user.jpg' class='userImg'>";
    	  	} else {
    	  		var fileCallPath = encodeURIComponent(uploadPath + "\\" + uuid  + "_" + fileName);
        	    console.log(fileCallPath);
        	    str = "<img src='/userimage?fileName="+ fileCallPath + "' class='userImg'>";
    	  	}
    	     console.log(str);
    	     return str;
    	}
      
      $(".remove").on("click", function(e){
    	  var result = confirm("정말로 " + "${param.userid}" + " 님을 탈퇴시키겠습니까?");
			if(result){
				location.href= "/member/remove2?userid=${param.userid}";	
			}
      })

});
</script>
