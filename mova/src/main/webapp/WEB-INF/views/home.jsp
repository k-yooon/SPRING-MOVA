<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<%@ include file="./include/hheader.jsp"%>

<div class="inner-agile-w3l-part-head">
	<h3 class="w3l-inner-h-title">연령별 영화 분석</h3>
	<p class="w3ls_head_para">MOVA 가족들의 취향 엿보기</p>
</div>


<h3 class="agile_w3_title1">
</h3>
<div id="pick1">

</div>

<h3 class="agile_w3_title2">
</h3>
<div id="pick2">

</div>

<h3 class="agile_w3_title3">
</h3>
<div id="pick3">

</div>

<h3 class="agile_w3_title4">
</h3>
<div id="pick4">

</div>

<h3 class="agile_w3_title5"> 
</h3>
<div id="pick5">

</div>						
										

<script>
$(function(){
	showGnere(100, 190, 1);	
	showGnere(20, 29, 2);	
	showGnere(30, 39, 3);
	showGnere(40, 49, 4);
	showGnere(50, 90, 5);	
		//검색 버튼 처리
		var searchForm = $("#searchForm");
		$("#searchbutton").on("click", function(e){
			if(!searchForm.find("option:selected").val()){	//검색 조건을 지정하지 않은 경우
				alert("검색 종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){	//검색어를 입력하지 않은 경우
				alert("키워드를 입력하세요");
				return false;
			}
		});
		
		//선호도 분석(장르)
		function getGenre(start, end, callback, error){
		      console.log(start + " : " + end);
		      $.getJSON('/genre/' + start + '/' + end + '.json', function(response){
		            if(callback){
		            	console.log("in");
		               callback(response);      
		            }
		         }).fail(function(xhr, status, err){
		            if(error){
		               error();
		            }
		         });
		  }
		
		//선호도 분석(영화)
		function getMovie(start, end, callback, error){
			console.log("getMovie");
			$.getJSON("/movie/" + start + '/' + end + ".json", function(response){
					if(callback){
						callback(response);		
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
		}
		
		function showGnere(start, end, check){
			getGenre(start, end, function(response){
				var str ="";
				var sttrr = "";
				console.log(response);
				if(response == null || response.length == 0){
		  			return;
		  		} 
				if(start == 100){
					str += (start/10) + "대 원픽장르는 <a href='/movie/movieTagGet?genre=" + response[0].genre + "'><span>#" + response[0].genre + "</span></a></h3>"+
							"<div class='w3ls-news-result'><h4>별점 <span> TOP5 </span></h4></div>";
				} else if(start == 50){
					str += start + "대 이상 원픽장르는 <a href='/movie/movieTagGet?genre=" + response[0].genre + "'><span>#" + response[0].genre + "</span></a></h3>" + 
					"<div class='w3ls-news-result'><h4>별점 <span> TOP5 </span></h4></div>";
				} else {
					str += start + "대 원픽장르는 <a href='/movie/movieTagGet?genre=" + response[0].genre + "'><span>#" + response[0].genre + "</span></a></h3>" + 
					"<div class='w3ls-news-result'><h4>별점 <span> TOP5 </span></h4></div>";
				}
				$(".agile_w3_title" + check ).html(str);
				getMovie(start, end, function(list){
					console.log(list);
					for(var i =0; i < list.length; i++){
						sttrr += "<div class='wthree_agile-requested-movies'><a href='/movie/movieInfo?mno=" + list[i].mno + "'>" + 
					      		"<div class='col-md-2 w3l-movie-gride-agile requested-movies'>" +
					         	"<div class='poster'><img src='../resources/images/movie/poster/" + list[i].fileName + "' style='width: 250px; height: 330px'>" +
					            "</div><div class='mid-1 agileits_w3layouts_mid_1_home'><div class='w3l-movie-text'>" + 
					            "<h6><a href=''>" + list[i].mname + "</a></h6></div>" + 
					            "<div class='mid-2 agile_mid_2_home'><p>" + list[i].genre + "</p><div class='block-stars'><ul class='w3l-ratings'>" +
					            "<p>" + list[i].year + "</p></ul></div><div class='clearfix'></div></div></div></div></div>";		
					}
					$("#pick" + check ).html(sttrr);
				});				
			});
		}
		

});
</script>  
