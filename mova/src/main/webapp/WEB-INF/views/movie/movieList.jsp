<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>
<style>
	#regBtn{
		width: 100px; height: 40px; font-size: 12px;
	}
   #regBtn:hover{
      background-color : #FF5A5A;
   }
</style>
<div class="w3_content_agilleinfo_inner">
						<div class="agile_featured_movies">
						<div class="inner-agile-w3l-part-head">
					            <h3 class="w3l-inner-h-title">Movie List</h3>
								<p class="w3ls_head_para">mova movie list page</p>
							</div>
				                   <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
					
	<div id="myTabContent" class="tab-content">
		<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
								<div class="agile-news-table">
									<button id ='regBtn' type="button" class="btn btn-xs pull-right">영화 등록</button>
									
									<table id="table-breakpoint">
										<thead>
										  <tr>
										  	<th>NO</th>
											<th>Movie Name</th>
											<th>Year</th>
											<th>Country</th>
											<th>Genre</th>
										  </tr>
										</thead>
										<tbody>
										  <!-- Model 데이터 출력 -->
										<c:forEach items="${list }" var="movie">
										  <tr>
											 <td>${movie.mno }</td>
											<td class="w3-list-img"><a class="move" href="${movie.mno}"></a>
											<a class="move" href="${movie.mno}">
												<img src="../resources/images/movie/poster/${movie.fileName}" style="width: 120px; height: 150px">
												${movie.mname }
											</a></td>
											<td>${movie.year }</td>
											<td>${movie.nation }</td>
											<td>${movie.genre }</td>
										  </tr>
										 </c:forEach>
										</tbody>
									</table>
									  <!-- 검색창 - 검색 조건 및 키워드 입력 영역 -->
                   <div class='row'>
				   	   <div class="col-lg-12">
				   	   <form id="searchForm" action="/movie/movieList">
				   	   	   <select name="type">
				   	   	   	  <c:set var="type" value="${pageMaker.cri.type }"/>
				   	   	      <!-- 검색 조건이 없을 경우 selected 표시 -->
				   	   	   	  <option value=""
				   	   	   	  	<c:out value="${type == null?'selected':'' }"/>>
				   	   	   	  	검색 조건 지정</option>
				   	   	   	  <!-- ${pageMaker.cri.type}이 value와 일치하면 selected 표시 -->
				   	   	   	  <option value="T"
				   	   	   	  	<c:out value="${type == 'T'?'selected':'' }"/>>영화명</option>
				   	   	   	  <option value="C"
				   	   	   	  	<c:out value="${type == 'C'?'selected':'' }"/>>장르</option>
				   	   	   	  <option value="W"
				   	   	   	  	<c:out value="${type == 'W'?'selected':'' }"/>>감독</option>
				   	   	   	  <option value="B"
				   	   	   	  	<c:out value="${type == 'B'?'selected':'' }"/>>배우</option>
				   	   	  
				   	   	   </select>
				   	   	   <input type="text" name="keyword" value="${pageMaker.cri.keyword }">
				   	   	   <input type="hidden" name="pageNum"
				   	   	   		  value="${pageMaker.cri.pageNum }">
				   	   	   <input type="hidden" name="amount"
				   	   	   		  value="${pageMaker.cri.amount }">
				   	   	   <button class="btn btn-default">Search</button>
				   	   </form>
				   	   </div>                   
                   </div>
                   <!-- END 검색창 - 검색 조건 및 키워드 입력 영역 -->
									
									<!-- 페이징처리 -->
								<div class="pull-right">
								   		<ul class="pagination">
								   		<c:if test="${pageMaker.prev }"><!-- previous 버튼 표시 -->
								   			<li class="paginate_button previous">
								   				<a href="${pageMaker.startPage - 1 }">
								   					Previous</a></li>
								   		</c:if>
								   						   		
								   		<!-- 페이지 번호 표시 -->
								   		<c:forEach begin="${pageMaker.startPage }"
								   				   end="${pageMaker.endPage }" var="num">
								   			<li class="paginate_button
								   			           ${pageMaker.cri.pageNum == num ? 'active': '' }">
								   				<a href="${num}">${num}</a></li>
								   		</c:forEach>
								   		
								   		<c:if test="${pageMaker.next }"><!-- next 버튼 표시 -->
								   			<li class="paginate_button next">
								   				<a href="${pageMaker.endPage + 1 }">Next</a></li>
								   		</c:if>
								   		</ul>
								 </div>
								 
								  <!-- a 태그 대신 pageNum과 amount 파라미터로 전송 -->
								   <form id="actionForm" action="/movie/movieList" method="get">
								   	  <input type="hidden" name="keyword" 
				   	   	    	              value="${pageMaker.cri.keyword }">
								   	   <input type="hidden" name="pageNum"
								   	   	      value="${pageMaker.cri.pageNum }">
								   	   <input type="hidden" name="amount" 
								   	   	      value="${pageMaker.cri.amount }">
								   	   <input type="hidden" name="type" 
								   	   	      value="${pageMaker.cri.type }"> 
								   </form>
								 
								 
								</div>
							</div>
						</div>			
					</div>
				</div>
			</div>


<script>
$(function(){
	//등록버튼처리
	$("#regBtn").on("click", function() {
		self.location ="/movie/movieRegister";
	});
		
	//조회버튼처리
	$(".move").on("click", function(e){
		//a 태그의 기본 동작 막고
		e.preventDefault();	
		
		actionForm.append("<input type='hidden' name='mno' value='"+
						 $(this).attr('href')+"'>'");
		actionForm.attr("action", "/movie/movieGet");
		actionForm.submit();
	});
	

	//페이지 번호를 클릭하면 해당 페이지 목록 표시
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();	//a 태그 기본 동작 막기
		
		//pageNum의 값을 클릭된 a의 href 값으로 변경
		actionForm.find("input[name='pageNum']")
			      .val($(this).attr('href'));
		//폼 전송
		actionForm.submit();
	});
	
	
	//a 태그의 move 클래스 속성을 이용
	$(".move").on("click", function(e){
		//a 태그의 기본 동작 막고
		e.preventDefault();	
		
		actionForm.append("<input type='hidden' name='mno' value='"+
						 $(this).attr('href')+"'>'");
		actionForm.attr("action", "/movie/movieGet");
		actionForm.submit();
	});

	//검색 버튼 이벤트 처리
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 조건을 선택해 주세요.");	//검색 조건 선택 알림
			return false;
		}
			
		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 입력해 주세요.");		//검색어 입력 알림
			return false;
		}
			
		//검색 시 페이지 번호는 1이 되도록 처리
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();	//폼 전송
	});
	
});




</script>