<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/header.jsp" %>
<style>
.clickable {cursor: pointer;}
</style>
<div class="w3_content_agilleinfo_inner">
   <div class="agile_featured_movies">
      <div class="inner-agile-w3l-part-head">
         <h3 class="w3l-inner-h-title">나의 글 목록</h3>
         <p class="w3ls_head_para">M Y B O A R D</p>
      </div>
      <div id="myTabContent" class="tab-content">
         <div role="tabpanel" class="tab-pane fade in active" id="home"
            aria-labelledby="home-tab">
            <div class="agile-news-table">
               <div class="w3ls-news-result">
                  <h4>문의 현황</h4>
               </div>
               <table class = "tbl paginated" id="qnaTable">
                  <thead>
                     <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>날짜</th>
                     </tr>
                  </thead>
                  <tbody id = "table" >
                  </tbody>
               </table>
            </div>
         </div>
      </div>
      
      <div id="myTabContent" class="tab-content">
         <div role="tabpanel" class="tab-pane fade in active" id="home"
            aria-labelledby="home-tab">
            <div class="agile-news-table">
               <div class="w3ls-news-result">
                  <h4>게시글 현황</h4>
               </div>
               <table class="pageme" id="recommTable">
                  <thead>
                     <tr>
                        <th>No.</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>날짜</th>
                     </tr>
                  </thead>
                  <tbody id = "table2">
                  </tbody>
               </table>
            </div>
         </div>
      </div>
   </div>
</div>

<script>
$(function(){
   
   //문의 게시글 목록
   function getList(param, callback, error){
      console.log("getList()");
      var userid = "${param.userid}";
      
      $.getJSON(
         "/member/myBoard/" + userid + ".json",
         function(list){
            console.log(list);
            
            var str = "";
            
            $(list).each(function(i, obj){
               str += "<tr><td>" + obj.qno + "</td>";
               str += "<td><a href = '#'>" + obj.title + "</a></td>";
               str += "<td>" + obj.userid + "</td>";
               str += "<td>" + displayTime(obj.regdate) + "</td>";
               str += "</tr>";
            });
            
            $("#table").html(str);
         }).fail(function(xhr, status, er){
         if(error){
            error(er);
         }
      });
   }; 
   //END getList
   
   getList(1);
   
   //추천 게시글 목록
   function getRecomm(param, callback, error){
      console.log("getList()");
      var userid = "${param.userid}";
      
      $.getJSON(
         "/member/myRecommBoard/" + userid + ".json",
         function(list){
            console.log(list);
            
            var table = list.length;
            
            console.log(table);
            console.log(page);
            
            var str = "";
            
            $(list).each(function(i, obj){
               str += "<tr><td>" + obj.reno + "</td>";
               str += "<td><a href = '#'>" + obj.title + "</a></td>";
               str += "<td>" + obj.userid + "</td>";
               str += "<td>" + displayTime(obj.regdate) + "</td>";
               str += "</tr>";
            });
            
            $("#table2").html(str);

         }).fail(function(xhr, status, er){
         if(error){
            error(er);
         }
      });
   }; 
   //END getList
   
   getRecomm(1);
   
   function page(){ 
      var reSortColors = function($table) {
        $('#table tr:odd td', $table).removeClass('even').removeClass('listtd').addClass('odd');
        $('#table tr:even td', $table).removeClass('odd').removeClass('listtd').addClass('even');
       };
       
       $('table.paginated').each(function() {
        var pagesu = 10;  //페이지 번호 갯수
        var currentPage = 0;
        var numPerPage = 10;  //목록의 수
        var $table = $(this);    
        
        //length로 원래 리스트의 전체길이구함
        var numRows = $table.find('#table tr').length;
        
        //Math.ceil를 이용하여 반올림
        var numPages = Math.ceil(numRows / numPerPage);
        //리스트가 없으면 종료
        if (numPages==0) return;
        //pager라는 클래스의 div엘리먼트 작성
        var $pager = $('<td align="center" id="remo" colspan="10"><div class="pager"></div></td>');
        
        var nowp = currentPage;
        var endp = nowp+10;
        
        //페이지를 클릭하면 다시 셋팅
        $table.bind('repaginate', function() {
        //기본적으로 모두 감춘다, 현재페이지+1 곱하기 현재페이지까지 보여준다
        
         $table.find('#table tr').hide().slice(currentPage * numPerPage, (currentPage + 1) * numPerPage).show();
         $("#remo").html("");
         
         if (numPages > 1) {     // 한페이지 이상이면
          if (currentPage < 5 && numPages-currentPage >= 5) {   // 현재 5p 이하이면
           nowp = 0;     // 1부터 
           endp = pagesu;    // 10까지
          }else{
           nowp = currentPage -5;  // 6넘어가면 2부터 찍고
           endp = nowp+pagesu;   // 10까지
           pi = 1;
          }
          
          if (numPages < endp) {   // 10페이지가 안되면
           endp = numPages;   // 마지막페이지를 갯수 만큼
           nowp = numPages-pagesu;  // 시작페이지를   갯수 -10
          }
          if (nowp < 1) {     // 시작이 음수 or 0 이면
           nowp = 0;     // 1페이지부터 시작
          }
         }else{       // 한페이지 이하이면
          nowp = 0;      // 한번만 페이징 생성
          endp = numPages;
         }
         // [처음]
         $('<br /><span class="page-number" cursor: "pointer">[처음]</span>').bind('click', {newPage: page},function(event) {
                currentPage = 0;   
                $table.trigger('repaginate');  
                $($(".page-number")[2]).addClass('active').siblings().removeClass('active');
            }).appendTo($pager).addClass('clickable');
          // [이전]
            $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[이전]&nbsp;</span>').bind('click', {newPage: page},function(event) {
                if(currentPage == 0) return; 
                currentPage = currentPage-1;
          $table.trigger('repaginate'); 
          $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
         }).appendTo($pager).addClass('clickable');
          // [1,2,3,4,5,6,7,8]
         for (var page = nowp ; page < endp; page++) {
          $('<span class="page-number" cursor: "pointer" style="margin-left: 8px;"></span>').text(page + 1).bind('click', {newPage: page}, function(event) {
           currentPage = event.data['newPage'];
           $table.trigger('repaginate');
           $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
           }).appendTo($pager).addClass('clickable');
         } 
          // [다음]
            $('<span class="page-number" cursor: "pointer">&nbsp;&nbsp;&nbsp;[다음]&nbsp;</span>').bind('click', {newPage: page},function(event) {
          if(currentPage == numPages-1) return;
              currentPage = currentPage+1;
          $table.trigger('repaginate'); 
           $($(".page-number")[(currentPage-nowp)+2]).addClass('active').siblings().removeClass('active');
         }).appendTo($pager).addClass('clickable');
          // [끝]
         $('<span class="page-number" cursor: "pointer">&nbsp;[끝]</span>').bind('click', {newPage: page},function(event) {
                 currentPage = numPages-1;
                 $table.trigger('repaginate');
                 $($(".page-number")[endp-nowp+1]).addClass('active').siblings().removeClass('active');
         }).appendTo($pager).addClass('clickable');
           
           $($(".page-number")[2]).addClass('active');
      reSortColors($table);
        });
         $pager.insertAfter($table).find('span.page-number:first').next().next().addClass('active');   
         $pager.appendTo($table);
         $table.trigger('repaginate');
       });
   }//END page()
   
   
   //댓글 목록 페이징
   /* var pageNum = 1;
   var replyPageFooter = $('.panel-footer');
   
   function showReplyPage(replyCnt){
      var endNum = Math.ceil(pageNum / 10.0) * 10;
      var startNum = endNum - 9;
      var prev = startNum != 1;
      var next = false;
      
      if(endNum * 10 >= replyCnt){   
         endNum = Math.ceil(replyCnt / 10.0);
      }
      
      if(endNum * 10 < replyCnt){
         next = true;
      }
      
      var str = "<ul class='pagination pull-right'>";
      if(prev) {   //previous link
         str += "<li class='page-item'>" + 
               "    <a class='page-link' href='" + (startNum -1) + "'>"+
               "         Previous</a></li>";
      }
      
      //페이지 번호 출력 및 링크 처리
      for(var i=startNum ; i<= endNum ; i++){   
         var active = pageNum == i ? "active" : "";
         str += "<li class='page-item " + active + " '>" +
               "    <a class='page-link' href='" + i + "'>" +
                        i + "</a></li>";
      }
      
      if(next){   //next link
         str += "<li class='page-item'>" +
                "    <a class='page-link' href='" + (endNum + 1) + "'>"+
                "         Next</a></li>";
      }
      
      str += "</ul>";
      console.log(str);
      replyPageFooter.html(str);
   }//END showReplyPage() */
   
   
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

