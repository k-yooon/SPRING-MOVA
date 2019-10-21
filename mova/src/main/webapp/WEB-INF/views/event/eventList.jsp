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
			<h3 class="w3l-inner-h-title">EVENT LIST</h3>
			<p class="w3ls_head_para">매달 아낌없이 주는 모바 이벤트</p>
		</div>
	<div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">		
		<div id="myTabContent" class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
				<div class="agile-news-table">
					<sec:authentication property="principal" var="pinfo"/>   
					<table id="table-breakpoint">
						<thead>
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>시작일</th>
								<th>종료일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="event" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td><a class="move" href="${event.eno}">${event.title } 이벤트</a></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${event.startdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${event.enddate }" /></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 페이징처리 -->
					<div class="pull-right">
						<ul class="nav nav-tabs" role="tablist">
							<c:if test="${pageMaker.prev }"><!-- previous 버튼 표시 -->
								 <li class="paginate_button previous">
								 	<a href="${pageMaker.startPage - 1 }">Previous</a>
								 </li>
							</c:if>
							<!-- 페이지 번호 표시 -->
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
								 <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': '' }">
								   	<a href="${num}">${num}</a>
								 </li>
							</c:forEach>
							<c:if test="${pageMaker.next }"><!-- next 버튼 표시 -->
								 <li class="paginate_button next">
								   	<a href="${pageMaker.endPage + 1 }">Next</a>
								 </li>
							</c:if>
						</ul>
					</div>
					<!-- a 태그 대신 pageNum과 amount 파라미터로 전송 -->
					<form id="actionForm" action="/event/eventList" method="get">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<input type="hidden" name="type" value="${pageMaker.cri.type }"> 
					</form>
				</div>
			</div>
			</div>			
		</div>
	</div>
</div>


<script>
$(function(){
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
	
	//조회버튼처리
	$(".move").on("click", function(e){
		//a 태그의 기본 동작 막고
		e.preventDefault();	
		
		actionForm.append("<input type='hidden' name='eno' value='"+
						 $(this).attr('href')+"'>'");
		actionForm.attr("action", "/event/eventGet");
		actionForm.submit();
	});
});






</script>