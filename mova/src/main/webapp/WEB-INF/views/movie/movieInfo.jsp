<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/header.jsp" %>
<style>
button{
   margin-right: 5px;
}

#modContent{
   width: 700px;
   margin-top: -50px;
   margin-left: 280px;
}
   .bsMod{
      background-color: black;
      position: relative;
      color: white;
      border: 1px solid black;
      left: 290px;
      height: 38px;
   }
   #file{
      margin-left: 20px;
   }
   #modImg{
      margin-left: 20px;
   }
   .bM{
      clear: both;
      box-sizing: border-box;
      position: relative;
      top: -70px;
   }
   .report{
      float: right;
   }
   .poster{
      float: left;
      position: relative;
   }
   .joa{
      display: inline-block;
      margin-left: 15px;
      margin-top: 15px;
      width: 30px;
   }
   #mname{
   	  font-size: 30px;
   }
   h2, #year, .fexi_header, .userid, .userphoto, .content, .mystar, .starRev, .btnArea{
      display: inline-block;
   }
   .poster{
      padding-right: 25px;
   }
   .player-text{
      padding: 10px;
   }
   .admin-text{
   	  height: 145px;
      background-color: #BDBDBD;
      margin-right: 130px;
      margin-left: 130px;
      margin-top: 10px;
      padding-bottom: 10px;
   }
   .admin-text-right{
   	  height: 90px;
   }
.starR, .starR2{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on, .starR2.on{background-position:0 0;}
.commWrite{
   width: 400px;
   height: 200px;
}
#userid{
   font-size: 10px;
   margin-top: -40px;
}
.mystar{
   font-size: 20px;
}

#time{
   text-align: right;
}

#star{
   margin-left: 150px;
   margin-top: 20px;
   float: left;
}

.col-sm-8{
   margin-top: 10px;
}

#comment{
   clear: both;
}

#submit{
   float: right;
   margin-top: 10px;
}

.form-group{
   display: inline-block;
}

.w3_content_agilleinfo_inner{
   height: 50px;
   margin-top: -40px;
}
.comReg-area{
   margin-left: 20%;
   margin-top: 30px;
}


#modalRegBtn{
      width: 80px; 
      border-radius: 0px;
      height: 45px;
   }
   
   .bestSD{
      clear: both;
      width: 100%;
   }
   
   #file{
      font-size: 10px;
      margin-left: 60px;
      margin-top: -30px;
   }

   #uploadResult{
       box-sizing: border-box;
       float: left;
       margin-top: -30px;
       margin-left: 10px;
   } 
   .modal-dialog{
      width: 1000px;
   }
   ul{ list-style: none;
   }
   
   #uploadResult ul{
         width: 100px;
   }
    
   .contentBox{
      border-radius : 3px;
      height: 100px;
      background-color: lightgray;
      box-sizing: border-box;
      margin: 20px 40px;
      margin-left: 160px;
      width: 80%;
      padding-left: 10px;
      position: static;
   }
   .content{
   	width: 850px;
   	height: 55px;
   }
   .scene{
      width: 10%;
      height: 100px;
      margin-left: 40px;
      float: left;
      box-sizing: border-box;
   }
   .bsUserId{
      font-size: 20px;
      width: 50%;
      float: left;
      box-sizing: border-box;
      height: 30px;
   }
   .bsReport{
      color:blue;
      box-sizing: border-box;
      padding: 5px;
      padding-right: 10px;
      text-align: right;
   }
   
   .bsContent{
      clear: both;
      background-color: white;
      box-sizing: border-box;
   }
   .date{
      float: right;
      width: 78%;
      margin-top: 26px;
      margin-bottom: 0px;
   }
   #btn{
      float: right;
   }  
   #bsContent{
      width: 60%;
      margin-right: -200px;
   }
   #bsContent, #tp{
      display: inline-block;
      margin-top: -50px;
      margin-left: 200px;
   }
   .btn-warning{
     float: right;
     padding: -10px;
     box-sizing: border-box;
   }
   #modContent{
      float: left;
   }
   #modalModBtn{
      background-color: #02a388;
      color: white;
      width: 970px;
      box-sizing: border-box;
      margin: 10px;
   }
   #myModal4{
      height: 2000px;
   }
   #selector1{
   	  width: 170px;
   	  margin-left: 130px;
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
   .thumb{
   	 display: inline-block;
   	 float: left;
   	 margin-top: 26px;
   }
   .thumbIcon{
   	 display: inline-block;
   	 margin-right: 10px;
   } 
</style>
<h3 class="agile_w3_title"> Movie <span>Info</span></h3>
<!-- 영화 정보  -->
      <div class="player-text">
        <div class="poster">
            <img src="../resources/images/movie/poster/${movie.fileName}" style="width: 250px; height: 350px">
         </div> 

         <div class="textbox">
            <p class="fexi_header" id="mname">${movie.mname} &nbsp&nbsp </p>
            <p class="fexi_header_para" id="year">${movie.year} | ${movie.nation} | ${movie.genre}</p>
            <!-- 로그인 여부 확인 -->
         <sec:authorize access="isAuthenticated()">
               <h2><div class="joa"></div></h2>
            </sec:authorize>      
            <hr>
            <p class="fexi_header_para fexi_header_para1"><span>평균 별점</span>
               <div class="star"></div>
            </p>
            <hr>
            <p class="fexi_header_para" style="font-weight: bold;"><span>배우 및 감독</span>${movie.director}(감독) | ${movie.actor}</p>
            <br>
            <p class="fexi_header_para">${movie.summary}</p>
         
            <!-- 스틸컷 -->
         </div>
              <div id="uploadResult">
            <ul>   
                        
            </ul>
      </div>
         
      <!--    <div class="still">
            <p class="fexi_header_para"><span>스틸컷</span></p>
         </div> -->
         <div class="clearfix"> </div>
      </div>   

<sec:authorize access="isAuthenticated()">
<div class="comReg-area">
      <div class="starRev">
        <span class="starR">별1</span>
        <span class="starR">별2</span>
        <span class="starR">별3</span>
        <span class="starR">별4</span>
        <span class="starR">별5</span>
     </div>
        <div class="form-group">
            <input type="text" class="form-control1 input-lg" id="largeinput" placeholder="comment"  style="width: 600px;">
            <div class="btnArea"><button type="button" class="btn btn-primary" id="commRegBtn">등록</button></div>
         </div>
</div>

<!-- 코멘트 출력 -->
<div id = "comment"><h4 class="side-t-w3l-agile"><span>COMMENT</span></h4></div>
<div>
	<select name="type" id="selector1" class="form-control1">
      	 <option value="date" selected>등록순</option>
         <option value="starD">별점 높은순</option>
         <option value="starA">별점 낮은순</option>
         <option value="like">좋아요 순</option>
    </select> 
</div>      
   <div class="comment-area">
   </div>   
 </sec:authorize>     
<!-- 영화 정보 끝 -->   

<!-- Modal1 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>COMMENT 수정</h4>
                  </div>
                  <div class="login-form">
                     <div class="inputBox">
                        <div class="starRev2" style="margin-left: 220px">
                       <span class="starR2">별1</span>
                       <span class="starR2">별2</span>
                       <span class="starR2">별3</span>
                       <span class="starR2">별4</span>
                       <span class="starR2">별5</span>
                    </div>
                        <div id = "box">
                           <div id="content">
                              <input type="text" name="content" id ="modcomm" required="">
                           </div>
                           <div class="tp">
                              <input type="submit" id="modalRegisterBtn" value="등록">
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

<!-- 명명 모달 -->
      <div class="modal fade" id="myModal5" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>BESTSCENE</h4>
                  </div>
                  <div class="login-form">
                     <div class="inputBox">
                        <!-- 파일 업로드 -->
                        <div id = "uploadResult">
                           <ul></ul>
                        </div>
                        <div id = "uploadFile">
                           <input type="file" name="uploadFile" id="file">
                        </div>
                        <div id = "box">
                           <div id="bsContent">
                              <input type="text" name="bsContent" placeholder="내용을 입력해주세요." required="">
                           </div>
                           <div id="tp">
                              <input type="submit" id="modalRegBtn" value="등록">
                           </div>   
                        </div>
                        <!-- 명대사 명장면 출력 -->
                        <div class = "bestSD">
                           <ul class = "best">
                           </ul>
                        </div>
                     </div>
                     <div class="forgot-grid">
                        <div class="clearfix"></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      <!-- 명명 모달 -->
<!-- 명명 수정 모달 -->
<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" >
         <div class="modal-dialog">
            <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4>BESTSCENE 수정</h4>
                  </div>
                  <div class="login-form">
                     <div class="inputBox">
                     <div id = "box">
                           <div id = "modImg">
                           </div>
                           <div id = "file">
                              <input type="file" name="uploadFile" id="file">
                           </div>
                           <div id="modContent">
                              <input type="text" name="content" id ="content" required="">
                           </div>
                           <div class="tp">
                              <input type="submit" id="modalModBtn" value="수정하기">
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
<script src="../resources/js/comment.js"></script>
<script>
$(function(){
      <!--포스터출력 -->
   var uuid = $("input[name='uuid']").val();
   var uploadPath = $("input[name='uploadPath']").val();
   var fileName =  $("input[name='fileName']").val();
   var fileCallPath = encodeURIComponent(uploadPath + "\\" + uuid  + "_" + fileName);
   console.log(fileCallPath);

   var str = "";
   str += "<div><img src='/poster?fileName="+ fileCallPath + "'>" +
          "</div></li>";

    $("#PosterResult ul li").html(str);
      
   /* 스틸컷 출력 */
   var mno = '<c:out value="${movie.mno}"/>';
   $.getJSON("/movie/getAttachList", {mno:mno}, function(arr){
      var str = "";
      $(arr).each(function(i, obj){
         //업로드 파일명 <li>추가      
            var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid  + "_" + obj.fileName);
            str += "<li data-path='" + obj.uploadPath + "' "          +
                     "data-uuid='" + obj.uuid + "' "                +
                     "data-filename='" + obj.fileName + "'>"          +
                      "<div><img src='/display?fileName="+ fileCallPath + "'>" +
                      "    </div></li>";
      });   
      $("#uploadResult ul").html(str);
   });

   var userid = null; 
      <sec:authorize access="isAuthenticated()">
         userid = '<sec:authentication property="principal.username"/>';
      </sec:authorize>
   
   var keyword = $("#selector1").val();
   console.log("keyword : " + keyword);
   showStar("${movie.avgstar}");
   showWish();
   showComm(keyword); 
   showMyComm();
   var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";

    //ajax 전송 시 CSRF 토큰 전송 처리
    $(document).ajaxSend(function(e, xhr, options){
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
    
   var mno = "${movie.mno}";
   
   var genre = "${movie.genre}";
   var mycno = "";
   var modal = $('#myModal');
   
   //코멘트 등록
   $(document).on("click","#commRegBtn",function(e){
      var givestar = $(".starR.on").length;
      var givecomm = $("#largeinput").val();
      commentService.add(   
            { mno     : mno, 
              userid   : userid, 
              star : givestar,
              content : givecomm,
              genre : genre},
            function(result){   
                 alert("코멘트가 등록되었습니다.");
                 location.reload();
            }
         );
   });    
   
   //나의 코멘트 조회
   function showMyComm(){
      var mno = "${movie.mno}";
      commentService.getMyComm({
         mno : mno, userid : userid  
        }, function(response){
           if(response == null || response.length == 0){
              return;
           }
           $("#largeinput").attr('readonly', true);
           $("#largeinput").val(response.content);
           var star = response.star;
           mycno = response.cno;
           for(var i = 1; i <= star; i++ ){
              $('.starRev span:nth-child(' + i + ')').attr('class', 'starR on');
           }
           $("#commRegBtn").hide();
           var str = "<button type='button' class='btn btn-warning' id='modbtn'>수정</button> <button type='button' class='btn btn-danger' id='rembtn'>삭제</button>";
           $(".btnArea").html(str);
        }
      );   
   }
   //나의 코멘트 삭제
   $(document).on("click","#rembtn",function(e){
      var removeChk = confirm("코멘트를 삭제하시겠습니까?");
      if(removeChk){
         commentService.remove(mycno, function(result){
                alert("코멘트가 삭제됐습니다");
                location.reload();
             });
      }
   });  
   
   var givestar = "";
   var givecomm = "";
   var modcomm = $("#modcomm");
   var modstar = $(".starRev2 span");
   //나의 코멘트 수정
   $(document).on("click", "#modbtn", function(e){
      modal.modal('show');
      var mycomm = $("#largeinput").val();
      modcomm.val(mycomm);
      modcomm.on("click", function(e){
         modcomm.val("");
      });
      modstar.on("click", function(e){
         console.log("별 클릭");
         $(this).parent().children('span').removeClass('on');
         $(this).addClass('on').prevAll('span').addClass('on');
         givestar = $(".starR2.on").length;
      });
   }); 
   
   $("#modalRegisterBtn").on("click", function(e){
      var comment = {
            cno:mycno,
            star: givestar, 
            content: modcomm.val()
      }; 
      
      commentService.update(comment, function(result){
         modal.modal("hide");
         alert("코멘트가 수정됐습니다");
         location.reload();
      });
   });
          
   //별점 주기
  $('.starRev span').click(function(){
     $(this).parent().children('span').removeClass('on');
     $(this).addClass('on').prevAll('span').addClass('on');
     return false;
  });
   
   
   //찜하기 처리
   function wishAdd(reply, callback, error){
      $.ajax({
         type : 'post',
         url : '/member/wish',
         data : JSON.stringify(reply),      //데이터를 json화 시킴
         contentType : "application/json; charset=utf-8",
         success : function(result, status, xhr){
            if(callback){
               callback(result);
            }
         },error : function(xhr, status, er){
            if(error){
               error(er);
            }
         }
      })   
   }
   
   //찜했는지 체크
   function wishCheck(param, callback, error){
      var mno = param.mno;
      var userid = param.userid;
      console.log(mno + " : " + userid);
      $.get('/member/wish/' + mno + '/' + userid + '.json', function(response){
            if(callback){
               callback(response);      
            }
         }).fail(function(xhr, status, err){
            if(error){
               error();
            }
         });
   }
   
   //찜하기 삭제
   function wishRemove(mno, userid, callback, error){
      $.ajax({
         type : 'delete',
         url : '/member/wish/' + mno + '/' + userid,
         data: JSON.stringify({mno:mno, userid:userid}),
         contentType: "application/json; charset=utf-8",
         success : function(deleteResult, status, xhr){
            if(callback){
               callback(deleteResult);
            }
         },
         error : function(xhr, status, er){
            if(error){
               error(er);
            }
         }
      });
   }
   
   //하트 표시 및 클릭 처리
   function showWish(){
      var mno = "${movie.mno}";
      wishCheck(
         {mno:mno, userid:userid},
         function(response){
            if(response == null || response.length == 0){
               console.log("response : null");
               var innerHtml = '<i class="fa fa-heart-o" style="color: red"></i>';
               $(".joa").on("click", function(e){   
                  wishAdd(   //전송할 데이터들
                        { mno     : mno, 
                          userid  : userid },
                        function(result){   
                           var innerHtml = '<i class="fa fa-heart" style="color: red"></i>';
                           $(".joa").html(innerHtml);
                           showWish(); 
                        }
                     );
               });
            } else {
               console.log("response : " + response);
               var innerHtml = '<i class="fa fa-heart" style="color: red"></i>';
               $(".joa").on("click", function(e){   
                  wishRemove(mno, userid, function(result){
                     var innerHtml = '<i class="fa fa-heart-o" style="color: red"></i>';
                     $(".joa").html(innerHtml);
                     showWish(); 
                  });   
               });   
            }
            $(".joa").html(innerHtml);
         }
      );
   }
   
   //영화 평균 별점 출력
   function showStar(star){
      var innerHtml = "";
      var dbstar = star;
      var sosu = false;
      console.log("dbstar : " + dbstar);
      if(dbstar == 1.5 || dbstar == 2.5 || dbstar == 3.5 || dbstar == 4.5){
         sosu = true;
      } 
      var star = Math.round(dbstar);   
      
      if(sosu){
         for(var i =1 ; i < star; i++) {  
              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: yellow"></i>';  
         } innerHtml  += '<i class="fa fa-star-half-o" aria-hidden="true" style="color: yellow"></i>';
         for(var j = 0; j < 5-star; j++){
            innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: yellow"></i>';  
         }
      } else {
         for(var i =0 ; i < 5; i++) {  
            if(i < star){
              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: yellow"></i>';  
            } else {
               innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: yellow"></i>';  
            }
         } 
      } 
      $('.star').html(innerHtml);
   }
   
   //코멘트 별점 출력
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
              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: yellow"></i>';  
         } innerHtml  += '<i class="fa fa-star-half-o" aria-hidden="true" style="color: yellow"></i>';
         for(var j = 0; j < 5-star; j++){
            innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: yellow"></i>';  
         }
      } else {
         for(var i =0 ; i < 5; i++) {  
            if(i < star){
              innerHtml  +=  '<i class="fa fa-star" aria-hidden="true" style="color: yellow"></i>';  
            } else {
               innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: yellow"></i>';  
            }
         } 
      } 
      return innerHtml;
   }
   var check = 0;
   var str = "";
   var vlist = "";
   var joalist = "";
   
   //코멘트 목록 출력
      function showComm(keyword){
      var mno = "${movie.mno}";
      commentService.chkCommJoa(mno, userid, function(list){
    	  joalist = list;
      });
      commentService.getList(
         mno, keyword,
         function(list){
            console.log("list : " + list.length);
            var start = check * 10;
            var end = (check * 10) + 10;
            var morecheck = true;
            if(list.length < 10){
               end = list.length;
               morecheck = false;
            }
            vlist = list;
            for(var i=start; i<end; i++){
            	console.log("listChk" + [i] + " : " + list[i].content);
               str += "<div class='admin-text'><div class='admin-text-left'>" + 
               "<a href='../member/mypage?userid=" + list[i].userid + "&star=5'><img src='' class='userphoto'>" + 
               "<div id = 'box'><div id = 'userid'><h5 style='color: black' class='userid'>" + list[i].userid + "</h5></div></a>" + 
               "<div class='mystar'>" + showMyStar(list[i].star) + "</div></div>" +
               "<div class='thumb'><h3 class='thumbIcon'>";
    			if(joalist == null || joalist.length <= 0) {
    				str += "<i class='fa fa-thumbs-o-up' id='minusJoa' value='" + list[i].cno+ "'></i>";
    			} else {
	               	for(var j = 0; j < joalist.length; j++){
	               	  if(list[i].cno == joalist[j].cno) {
	               		str += "<i class='fa fa-thumbs-up' id='plusJoa' value='" + list[i].cno+ "'></i>";
	               	  } else {
	               		str += "<i class='fa fa-thumbs-o-up' id='minusJoa' value='" + list[i].cno+ "'></i>";
	               		}
	               	}
    			}	 
               str += "</h3>" + list[i].joa + "</div></div>" + 
               "<div class='admin-text-right'>" + 
               "<p class='content' style='color: black'>" + list[i].content + "</p>";
               if(list[i].userid != userid){
                  str += "<div class='report' id='commreport' value='" + list[i].cno + "'><a>신고</a></div>";   
               }
               str += "<div id = 'time'><span style='color: #5D5D5D'>" + displayTime(list[i].regdate) + "</span></div></div><div class='clearfix'></div></div>";
            }
            if(morecheck){
               str += "<div class='more1' id='readmore'>ReadMore</div><div class='comment-area2'></div>";
            }
            $('.comment-area').html(str);
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
         str2 += "<div class='admin-text'><div class='admin-text-left'>" + 
         "<a href='../member/mypage?userid=" + list[i].userid + "&star=5'><img src='' class='userphoto'>" + 
         "<div id = 'box'><div id = 'userid'><h5 style='color: black' class='userid'>" + list[i].userid + "</h5></div></a>" + 
         "<div class='mystar'>" + showMyStar(list[i].star) + "</div></div>" + 
         "<div class='thumb'><h3 class='thumbIcon'>"; 
         if(joalist == null || joalist.length <= 0) {
				str += "<i class='fa fa-thumbs-o-up' id='minusJoa' value='" + list[i].cno+ "'></i>";
		 } else {
	       	 for(var j = 0; j < joalist.length; j++){
	       		if(list[i].cno == joalist[j].cno) {
	       			str2 += "<i class='fa fa-thumbs-up' id='plusJoa' value='" + list[i].cno+ "'></i>";
	       		} else {
	       			str2 += "<i class='fa fa-thumbs-o-up' id='minusJoa' value='" + list[i].cno+ "'></i>";
	       		}
	       	 }
		 }  	 
         str2 += "</h3>" + list[i].joa + "</div></div>" +
         "<div class='admin-text-right'>" + 
         "<p class='content' style='color: black'>" + list[i].content + "</p>";
         if(list[i].userid != userid){
            str2 += "<div class='report' id='commreport' value='" + list[i].cno+ "'><a>신고</a></div>";   
         }
         str2 += "<div id = 'time'><span style='color: #5D5D5D'>" + displayTime(list[i].regdate) + "</span></div></div><div class='clearfix'></div></div>";
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
	   joalist = "";
	   check = 0;
	   showComm(keyword);
   });
 
   	
   //좋아요 클릭
    $(document).on("click","#plusJoa",function(e){
 	   var cno = $(this).attr("value");
 	   var keyword = $("#selector1").val();
 	   commentService.removeJoa(cno, userid, function(result){
 		   str="";
 		   vlist="";
 		   joalist = "";
 		   check = 0;
 		   showComm(keyword);
	   });
    });
   
    $(document).on("click","#minusJoa",function(e){
  	   var cno = $(this).attr("value");
  	   var keyword = $("#selector1").val();
  	   commentService.addJoa(cno, userid, function(result){
  		 str="";
  	     vlist="";
  	     joalist = "";
  	     check = 0; 
  		 showComm(keyword);
 	   });
     });
   
   
 //코멘트 신고
   function reportadd(cno, reporter, callback, error) {
       $.ajax({
          type : 'post',
          url : '/member/commreport/' + cno + '/' + reporter,
          data : JSON.stringify({
             cno : cno,
             reporter : reporter
          }), //데이터를 json화 시킴
          contentType : "application/json; charset=utf-8",
          success : function(result, status, xhr) {
             console.log(callback);
             if (callback) {
                callback(result);
             }
          },
          error : function(xhr, status, er) {
             if (error) {
                error(er);
             }
          }
       });
    }//END remove()
    
    $(document).on("click", "#commreport", function(e) {
    <sec:authorize access="isAuthenticated()">
         var userid = '<sec:authentication property="principal.username"/>';
      </sec:authorize>
       var result = confirm("코멘트를 신고하시겠습니까?");
       if(result){
          var cno = $(this).attr("value");
          reportadd(cno, userid, function(result) {
             alert("코멘트가 신고처리 되었습니다.");
          });
       }
    });
   
   
    /* 명대사 & 명장면 */
    
    //등록
    function add(bestscene, callback, error){
       console.log("add()");
       $.ajax({
          type : 'post',
          url :'/movie/bestNew',
          data : JSON.stringify(bestscene),
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
       });//END ajax
    }//END add()
    
    var chk = 0;
    
    //목록
    function bsList(param, callback, error){
       console.log("getList()");
       var mno = "${movie.mno}";
       console.log(mno);
       
       $.getJSON(
          "/movie/bestList/" + mno + "/" + userid + ".json",
          function(list){
             console.log(list);
             
             if(list == null || list.length == 0){
                return;
             }
             
             var start = chk * 5;
                var end = (chk * 5) + 5;
                var morecheck = true;
                
             var bestUl = $('.best');
             var str = "";
             
             vlist = list;
             
             for(var i = start; i < end; i++){
            	 console.log("up : " + list[i].uploadPath);
            	 console.log("up : " + list[i].uuid);
            	 console.log("up : " + list[i].fileName);
            	 
                var fileCallPath = encodeURIComponent(list[i].uploadPath + "\\" + list[i].uuid + "_" + list[i].fileName);
                   var Path = list[i].uploadPath + "\\" + list[i].uuid + "_" + list[i].fileName;
                   Path = Path.replace(new RegExp(/\\/g), "/");
                   
                   var regDate = new Date(list[i].regDate);
                   var date = regDate.toISOString().substring(0, 10);
                   
                console.log("content : " + list[i].content);
                console.log("date : " + date);
                console.log("bsno : " + list[i].bsno);
                
                str += "<li>";
               
                str += "<img class = 'scene' src = '/movie/display?fileName=" + fileCallPath + "'>";
                str += "<div class = 'contentBox'>";
                
                str += "<div class = 'bsUserId'>" + list[i].userid + "</div>";
                
                if(userid != list[i].userid){
                   str += "<div class = 'bsReport'><span>신고</span></div>"; 
                }
                
                if(userid == list[i].userid){
                   str += "<button type = 'button' class = 'btn-warning' value = '";
                    str += list[i].bsno + "'>";
                    str += "<i class = 'fa fa-times'></i></button>";
                    str += "<button type = 'button' class = 'bsMod' value = '" + list[i].bsno + "'>수정</button>";  
                 }
                
                str += "<div class = 'bM'>" + list[i].content + "</div>";
                str += "</div></li>";
                str += "<div class = 'date'>" + date + "</div>";
             }
             
             if(morecheck){
                   str += "<div class='newmore1'><a class='new-more'>Read More</a></div><div class='comment-area2'></div>";
               }

             bestUl.html(str); 
             
          }).fail(function(xhr, status, er){
             if(error){
                error(er);
             }
          });
    } 
    //END getList 
    
    function showList(start, end, list, chk){
       var str2 = "";
       var morecheck = true;
       
        if(list.length < end){
             end = list.length;
             morecheck = false;
        }
        
        for(var i = start; i < end; i++){
          var fileCallPath = encodeURIComponent(list[i].uploadPath + "\\" + list[i].uuid + "_" + list[i].fileName);
           var Path = list[i].uploadPath + "\\" + list[i].uuid + "_" + list[i].fileName;
           Path = Path.replace(new RegExp(/\\/g), "/");
           
           var regDate = new Date(list[i].regDate);
           var date = regDate.toISOString().substring(0, 10);
           
          console.log("content : " + list[i].content);
          console.log("date : " + date);
          console.log("bsno : " + list[i].bsno);
          
             str2 += "<li>";
              
              str2 += "<img class = 'scene' src = '/movie/display?fileName=" + fileCallPath + "'>";
              str2 += "<div class = 'contentBox'>";
              
              str2 += "<div class = 'bsUserId'>" + list[i].userid + "</div>";
              
              if(userid != list[i].userid){
                 str2 += "<div class = 'bsReport'><span>신고</span></div>"; 
              }
              
              if(userid == list[i].userid){
                     str2 += "<button type = 'button' class = 'btn-warning' value = '";
                  str2 += list[i].bsno + "'>";
                  str2 += "<i class = 'fa fa-times'></i></button>";
                   str2 += "<button type = 'button' class = 'bsMod' value = '" + list[i].bsno + "'>수정</button>";            }
              
              str2 += "<div class = 'bM'>" + list[i].content + "</div>";
              str2 += "</div></li>";
              str2 += "<div class = 'date'>" + date + "</div>";
       }
        
        if(morecheck){
            str2 += "<div class='newmore" + String((chk+1)) + "'><a class='new-more'>Read More</a></div><div class='comment-area" + String((chk+2)) + "'></div>";
         } 
        
        var area = ".comment-area" + String((chk+1));
        $(area).html(str2);


    }//END showList() 
    
     //명명 더보기 클릭시 처리
       $(document).on("click","div[class^='newmore']",function(e){
          chk = chk + 1;
           var start = chk * 5;
           var end = (chk * 5) + 5;
           console.log("더보기 클릭");
           showList(start, end, vlist, chk);
           var button = ".newmore" + String(chk);
           $(button).hide();
        });
    
    //삭제
    function remove(bsNo, callback, error){
       console.log("remove");
       $.ajax({
          type : 'delete',
          url : '/movie/' + bsNo,
          data : JSON.stringify({bsNo : bsNo}),
          contentType : "application/json; charset=UTF-8",
          success : function(result, status, xhr){
             if(callback){ callback(result);   }
          },
          error : function(xhr, status, er){
             if(error){    error(er);   }
          }
       }); //END ajax
    }//END remove()
          
    var bsModal = $('#myModal5');   //모달
    var modalRegBtn = $('#modalRegBtn'); //모달 버튼
    var modalInputContent = bsModal.find("input[name='bsContent']");   //입력받은 명대사
    
    //명대사 명장면 버튼 클릭시
    $('#bestBtn').click(function(){
       bsModal.modal('show');   //모달창 보이기
       bsList(1);   
    });   //END registerBtn
    
    modalRegBtn.on('click', function(e){
       console.log("click");
       
       var uuid = $("#uuid").val();
       var fileName = $("#fileName").val();
       var uploadPath = $("#uploadPath").val();
       var file = $("input[type='file']").val();
       
       if(modalInputContent.val() == ""){
          alert('명대사를 입력해주세요.');
       }
       
       console.log(uuid);
       console.log(fileName);
       console.log(uploadPath);
       
       add({ mno : mno,
          userid : userid,
            content : modalInputContent.val(),
            fileName : fileName,
            uuid : uuid,
            uploadPath : uploadPath},
               function(result){
                  console.log(result);
                  alert('등록이 완료되었습니다.');
                  modal.find(modalInputContent).val("");
                  bsList(-1);
             } //END add()
       );   //END 등록 버튼 이벤트 처리
    }); //END modalRegBtn
    
    //x버튼 이벤트 처리
    $('.bestSD').on('click', "button[class^='btn-warning']", function(e){
       var bsNo = $(this).attr("value");
       console.log(bsNo);
       
       if(confirm('해당 글을 삭제하시겠습니까?')){ 
          remove(
                bsNo,
                function(result){
                   console.log('remove   : ' + result);
                   alert('삭제가 완료되었습니다.');
                   bsList(-1);
                }, function(err){
                      alert('error');
                }
          );//END remove
       }
       
    });//END $(movieResult) 
    
    var modBest = $("#myModal4");
    
     //조회 
    function get(bsno, callback, error){
       console.log("get");
       $.get(
       "/movie/get/" + bsno + ".json",
       function(result){
          if(callback){
             callback(result);
             console.log(result);
          }
       }
       
       ).fail(
          function(xhr, status, er){
             if(error){error(er);}
          }      
       )
    }
    
    var modalModContent = modBest.find("input[name='content']");
    var bsno = "";
    
    //수정버튼 이벤트 처리
    $('.bestSD').on('click', "button[class^='bsMod']", function(e){
       bsno = $(this).attr("value");
       console.log("b : " + bsno);
       
       get(bsno, function(data){
          console.log(data);
          console.log(data.fileName);
    
          
          modalModContent.val(data.content);
          
          var fileCallPath = encodeURIComponent(data.uploadPath + "/s_" + data.uuid + "_" + data.fileName);
           
          var str5 = "";
          
           str5 += "<input type='hidden' id='uuid' value='" + data.uuid + "'/>";
           str5 += "<input type='hidden' id='fileName' value='" + data.fileName + "'/>";
           str5 += "<input type='hidden' id='uploadPath' value='" + data.uploadPath + "'/>";
           str5 += "<img src = '/movie/display?fileName=" + fileCallPath + "'  class = 'image' >";
           str5 += "<span data-file=\'" + fileCallPath + "\' data-type = 'image'> x </span>";
           
           $('#modImg').html(str5);
           
       });
      console.log('ModModal');
       modBest.modal('show');
    });
    
    console.log("bsno : " + bsno);
    
    
     //수정
    function update(bestscene, callback, error){
       console.log("modify...");
       console.log("bsno : " + bestscene.bsno);
       $.ajax({
          type : 'put',
          url : '/movie/' + bestscene.bsno,
          data : JSON.stringify(bestscene),
          contentType : "application/json; charset=utf-8",
          success : function(result, status, xhr){
             if(callback){
                callback(result);
             }
          }, error : function(xhr, status, er){
             if(error){
                error(error);
             }
          }
       });
    };
    
    $('#modalModBtn').on('click', function(e){
       update({ bsno : bsno,
                content : modalModContent.val()},
                function(result){
                     console.log('dd');
                     
                     if(result === 'success'){
                        alert('수정이 완료되었습니다.');
                     }
                     
                     modBest.modal('hide');
                     bsList(1);
                 },
                 function(err){
                     alert('error');
                 }
       )
       
    });
    
    
    
    
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");   //확장자 제한 정규표현식
    var maxSize = 5242880;   //파일 최대 업로드 크기 제한 5MB
    
    //확장자 및 파일 크기 확인 함수
    function checkExension(fileName, fileSize){
       if(fileSize >= maxSize) {   //파일 크기 확인
          alert("파일 사이즈 초과하였습니다.");   //크기를 초과하면 알림 메시지 출력
          return false;
       }
       if(regex.test(fileName)) {   //확장자 확인
          alert("이미지 파일만 등록해주세요.");   //제한 확장자인 경우 알림 메시지 출력
          return false
       }
       return true;   //파일 크기 및 확장자 문제가 없는 경우
    }//END checkExension()
    
    //첨부파일 상태 변화 이벤트 핸들러 등록
    $("input[type='file']").change(function(e){
       var formData = new FormData();   //가상의 <form> 태그
       console.log("file");
       
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
          type : 'post',
          url :'/movie/uploadAjaxAction',
          data : formData,
          dataType : 'json',
          contentType : false,
          processData : false,
          success : function(result){
             console.log("result : " + result);   
             console.log(result);
             showUploadResult(result); 
             $("#uploadFile").html(cloneObj.html());
          }
       })//END .ajax()
    }); //END  
    
    //업로드 결과 출력
    var uploadUL = $('#uploadResult ul');
    
    //업로드 영역 복사
    var cloneObj = $("#uploadFile").clone();
    
    function showUploadResult(uploadResultArr){
       console.log("-----------");
       console.log(uploadResultArr);
       var str = "";
       
       $(uploadResultArr).each(function(i, obj){
          console.log("upload : " + obj.uploadPath);
          console.log("uuid : " + obj.uuid);
          console.log("fileName : " + obj.fileName);
          
          var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
          
          str += "<li>"; 
          str += "<input type='hidden' id='uuid' value='" + obj.uuid + "'/>";
          str += "<input type='hidden' id='fileName' value='" + obj.fileName + "'/>";
          str += "<input type='hidden' id='uploadPath' value='" + obj.uploadPath + "'/>";
          str += "<img src = '/movie/display?fileName=" + fileCallPath + "'  class = 'image' >";
          str += "<span data-file=\'" + fileCallPath + "\' data-type = 'image'> x </span></li>";
       });
       
       uploadUL.append(str);
    }
    
    
    //첨부파일 삭제
    $("#uploadResult").on("click", "span", function(e){
       var targetFile = $(this).data("file");
       var type = $(this).data("type");
       var targetLi   = $(this).closest('li');
       targetLi.remove();   //해당 li 삭제
       
       console.log(targetFile);
       
       $.ajax({
          url : '/movie/deleteFile',
          data : {fileName : targetFile, type : type},
          dataType : 'text',
          type : 'post',
          success : function(result){
          }
       });   //END ajax
    });
  
   
  
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
