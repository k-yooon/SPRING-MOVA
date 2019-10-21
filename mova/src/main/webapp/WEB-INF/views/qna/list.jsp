<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ include file="../include/header.jsp" %>


               

<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">문의게시판</h3>
			<p class="w3ls_head_para">문의사항을 등록해주세요</p>
		</div>
	<div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
					
	<div id="myTabContent" class="tab-content">
		<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
			<div class="agile-news-table">
				<button id ='regBtn' type="button" class="btn btn-xs pull-right">문의글 등록</button>
					
					<table id="table-breakpoint">
						<thead>
						 <tr>
						 	<th>NO</th>
							<th>제목</th>
							<th>작성자</th>
                            <th>답변여부</th>
                            <th>작성일</th> 
						 </tr>
						</thead>
						
						<tbody>
					    <c:forEach items="${list}" var="qna">
			              <tr>
			              	<td>${qna.qno}</td>
			                <td><a class='move' href='<c:out value="${qna.qno }"/>'>${qna.title}</a></td>
			                <td>${qna.userid}</td>
			                <td>${qna.answer}</td>
			                <td><fmt:formatDate value="${qna.regdate}" pattern="yyyy-MM-dd"/></td>
			              </tr>
			            </c:forEach>
						</tbody>
					</table>
						<!-- 페이징처리 -->
								<div class="pull-right">
								   		<ul class="pagination">
								   		
								   		<c:if test="${pageMaker.prev }"><!-- previous 버튼 표시 -->
								   			<li class="paginate_button previous">
								   				<a href="${pageMaker.startPage - 1 }">
								   					Previous</a></li>
								   		</c:if>
								   						   		
								   		<!-- 페이지 번호 표시 -->
								   		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
								   			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': '' }">
								   				<a href="${num}">${num}</a></li>
								   		</c:forEach>
								   		
								   		<c:if test="${pageMaker.next }"><!-- next 버튼 표시 -->
								   			<li class="paginate_button next">
								   				<a href="${pageMaker.endPage + 1 }">Next</a>
								   			</li>
								   		</c:if>
								   		</ul>
								 </div>
								 
								 
								 <form id="actionForm" action="/qna/list" method="get">
								   	   <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
								   	   <input type="hidden" name="amount"  value="${pageMaker.cri.amount }">
								</form>
			</div>
        </div>              
   </div>
   </div>
  </div>
 </div>

<script>
var actionForm = $("#actionForm");

$("#regBtn").on("click", function() {
	self.location ="/qna/register";
});

$(".paginate_button a").on("click", function(e){
	e.preventDefault();	//a 태그 기본 동작 막기
	
	//pageNum의 값을 클릭된 a의 href 값으로 변경
	actionForm.find("input[name='pageNum']").val($(this).attr('href'));
	//폼 전송
	actionForm.submit();
});

var user = null;

<sec:authorize access="isAuthenticated()">
	user = '<sec:authentication property="principal.username"/>';
</sec:authorize>
//a 태그의 move 클래스 속성을 이용
$(".move").on("click", function(e){
	//a 태그의 기본 동작 막고
	e.preventDefault();	


	var originuser = "$(qna.userid)";
	
	if(user != originuser) {
		if(user == 'admin'){
			
		} else {
			alert("자신이 작성한 게시물만 조회 가능합니다.");
			return;	
		}
	} 
	
	actionForm.append("<input type='hidden' name='qno' value='"+ $(this).attr('href')+"'>'");
	actionForm.attr("action", "/qna/get");
	actionForm.submit();
});


</script>
