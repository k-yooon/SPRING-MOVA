<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/hheader.jsp" %>


			<!--//movies-->
				 <h3 class="agile_w3_title"><span>${param.genre}</span> Top 20 <span>Movies</span> </h3>
				<!--/requested-movies-->
				<c:forEach items="${list}" var="movie">
				     <div class="wthree_agile-requested-movies">
							<div class="col-md-2 w3l-movie-gride-agile requested-movies">
								<a href="./movieInfo?mno=${movie.mno}">
								<div class="poster">
									<img src="../resources/images/movie/poster/${movie.fileName}" style="width: 250px; height: 330px">
								</div>
								<div class="mid-1 agileits_w3layouts_mid_1_home">
									<div class="w3l-movie-text">
											<h6>${movie.mname}</a></h6>							
									</div>
								<div class="mid-2 agile_mid_2_home">
									<p>${movie.year}</p>
										<div class="block-stars">
											<ul class="w3l-ratings">
												<c:set var="star" value="${movie.avgstar}"/>
												
												<c:set var="sosu" value="false"/>
												<c:if test="${star == 1.5 || star == 2.5 || star == 3.5 || star == 4.5}">
													<c:set var="sosu" value="true"/>
												</c:if>
												<c:set var="star" value="${star+((star%1>0.5)?(1-(star%1))%1:-(star%1))}"/>
												<fmt:parseNumber var="star" integerOnly="true" value="${star}"/>
												<c:choose>
													<c:when test="${sosu == true}">
														<c:forEach begin="1" end="${star}" step="1">
															<i class="fa fa-star" aria-hidden="true" style="color: red"></i>
														</c:forEach>
															<i class="fa fa-star-half-o" aria-hidden="true" style="color: red"></i>	
														<c:forEach begin="${star}" end="3" step="1">
															<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>
														</c:forEach>	
													</c:when>
													<c:otherwise>
														<c:forEach var="i" begin="0" end="4" step="1">
															<c:choose>
															<c:when test="${i < star}">
																<i class="fa fa-star" aria-hidden="true" style="color: red"></i>
															</c:when>
															<c:otherwise>
																<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>
															</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<%-- <div class="star">${movie.avgstar}</div> --%>
											</ul>
										</div>
									<div class="clearfix"></div>
								</div>
								</div>							
							</div>				
					</div>
				</c:forEach>
<script>

	function showstar(dbstarr) {  
			//별점 출력
			var innerHtml = "";
			var dbstar = dbstarr;
			var sosu = false;
			console.log(dbstar);
			if(dbstar == 1.5 || dbstar == 2.5 || dbstar == 3.5 || dbstar == 4.5){
				sosu = true;
			} 
			var star = Math.round(dbstar);	
			console.log(star);
			console.log(sosu);
			
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
						console.log(i);
					} else {
						innerHtml  +=  '<i class="fa fa-star-o" aria-hidden="true" style="color: red"></i>';  
					}
				} 
			} 
			$('.star').html(innerHtml);		
	}

</script> 
