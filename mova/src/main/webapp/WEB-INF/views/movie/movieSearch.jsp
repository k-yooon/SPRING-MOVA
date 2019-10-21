<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib prefix="str" uri="http://pentode.tistory.com/jsp/str" %> 
<%@ include file="../include/hheader.jsp" %>
<style>
	ul{
		list-style-type: none;
	}
</style>

			<!--//movies-->
				 <div class="inner-agile-w3l-part-head">
				<h3 class="w3l-inner-h-title">검색 결과</h3>
				<p class="w3ls_head_para"></p>
			</div>
				<!--/requested-movies-->	
			<div class="w3_agile_latest_movies">	
				<div id="owl-demo" class="owl-carousel owl-theme">
				<c:set var="type" value="${param.type}"/>
				<c:choose>
				<c:when test="${type eq 'U'}">
					<c:forEach items="${member}" var="member">	
					<div class="item">
						<div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
							<a href="../member/mypage?userid=${member.userid}&star=5">
							<div id = "userimage">
                      			<ul>
                         			<li> 
                         				<c:choose>
	                         				<c:when test="${empty member.uploadPath || member.uploadPath eq 'undefined'}"> 
	                         					<div><img src="../resources/images/movie/poster/user.jpg" style="width: 180px; height:180px; border-radius: 100px;"></div>
	                         				</c:when>
	                         				<c:otherwise>
	                         					<c:set var="fileCallPath" value='${member.uploadPath}\\${member.uuid}_${member.fileName}'/>
	                         					<div><img src="/poster?fileName=${str:encodeURI(fileCallPath)}" style="width: 180px; height:180px; border-radius: 100px;"></div> 
	                         				</c:otherwise> 
                         				</c:choose>
                         			</li>
                      			</ul>
   							</div>
                        
							<div class="mid-1 agileits_w3layouts_mid_1_home">
								<div class="w3l-movie-text">
									<h6>${member.userid}</h6></a>									
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="movie">	
						<div class="item">
							<div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
								<a href="./movieInfo?mno=${movie.mno}">
								<div class="poster">
										<img src="../resources/images/movie/poster/${movie.fileName}" style="width: 250px; height: 330px">
								</div>
								<div class="mid-1 agileits_w3layouts_mid_1_home">
									<div class="w3l-movie-text">
										<h6>${movie.mname}</h6></a>									
									</div>
									<div class="mid-2 agile_mid_2_home">
										<p>${movie.year}</p>
											<div class="block-stars">
												<ul class="w3l-ratings">
													<div class="star">${movie.genre}</div>
												</ul>
											</div>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>	
				</c:choose>	
					</div>
					</div>	
<link href="../resources/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
<script src="../resources/js/owl.carousel.js"></script>
<script>
$(function(){
	//검색 박스에 검색어 출력
	$("#searchbox").attr('value', "${param.keyword}");
	
	$("#owl-demo").owlCarousel({
		 
			 autoPlay: 3000, //Set AutoPlay to 3 seconds
			  autoPlay : true,
			   navigation :true,

			  items : 5,
			  itemsDesktop : [640,4],
			  itemsDesktopSmall : [414,3]
	});
	
	
});		
</script>
