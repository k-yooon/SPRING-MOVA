<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ include file="../include/header.jsp" %>


			<!--//movies-->
			<div class="inner-agile-w3l-part-head">
				<h3 class="w3l-inner-h-title">My Wish List</h3>
				<p class="w3ls_head_para">보고싶어요</p>
			</div>
				<!--/requested-movies-->
				<c:forEach items="${wish}" var="movie">
				     <div class="wthree_agile-requested-movies">
							<div class="col-md-2 w3l-movie-gride-agile requested-movies">
								<a href="../movie/movieInfo?mno=${movie.mno}">
								<div class="poster">
									<img src="../resources/images/movie/poster/${movie.movie.fileName}" style="width: 250px; height: 330px">
								</div>
								<div class="mid-1 agileits_w3layouts_mid_1_home">
									<div class="w3l-movie-text">
											<h6>${movie.movie.mname}</h6></a>							
									</div>
								<div class="mid-2 agile_mid_2_home">
									<p>${movie.movie.year}</p>
										<div class="block-stars">
											<ul class="w3l-ratings">
												<c:set var="star" value="${movie.movie.avgstar}"/>
												
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

</script> 
