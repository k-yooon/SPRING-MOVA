<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그라이브러리 추가를 해야 함.  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>
<style>
	button {margin-right: 20px;}
</style>
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">신 고 관 리 게 시 판</h3>
			<p class="w3ls_head_para">R E P O R T B O A R D</p>
		</div>
		<div id="myTabContent" class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="home"
				aria-labelledby="home-tab">
				<div class="agile-news-table">
					<div class="w3ls-news-result">
				
						<h4>코멘트 신고 현황</h4>
					</div>
					<table id="table-breakpoint">
						<thead>
							<tr>
								<th>No.</th>
								<th>코멘트 번호</th>
								<th>신고 내용</th>
								<th>신고된 ID</th>
								<th>처리</th>
							</tr>
						</thead>
						<tbody>
						 	<c:forEach items="${list2}" var="reportcomment" varStatus="status">
								<tr>
									<td class="w3-list-info" id="${status.count}"><a>${status.count}</a></td>
									<td class="w3-list-info">${reportcomment.cno}</td>
									<td class="w3-list-img"><a href="../movie/movieInfo?mno=${reportcomment.comm.mno}">${reportcomment.comm.content}</a></td>
									<td class="w3-list-info"><a href="mypage?userid=${reportcomment.comm.userid}&star=5">${reportcomment.comm.userid}</a></td>
									<td>
										<button type="button" class="login reg" data-toggle="modal" data-target="#myModal5" onclick="removeComm(${reportcomment.cno})">코멘트 삭제</button>
										<button type="button" onclick="removeRepo(${reportcomment.rcno})">내버려두기</button>
									</td>
								</tr>
							</c:forEach> 
						</tbody>
					</table>
							<!-- 페이지 번호 출력 -->
					<div class="pull-right">
						<ul class="nav nav-tabs" role="tablist">
							<c:if test="${pageMaker.prev }">
								<!-- previous 버튼 표시 -->
								<li role="presentation"><a
									href="${pageMaker.startPage - 1 }"> Previous</a></li>
							</c:if>

							<!-- 페이지 번호 표시 -->
							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="num">
								<li
									class="paginate_button
				   			           ${pageMaker.cri.pageNum == num ? 'active': '' }">
									<a href="${num }">${num }</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next }">
								<!-- next 버튼 표시 -->
								<li class="paginate_button next"><a
									href="${pageMaker.endPage + 1 }">Next</a></li>
							</c:if>
						</ul>
					</div>
					<!-- END 페이지 번호 출력 -->

					<!-- a 태그 대신 pageNum과 amount 파라미터로 전송 -->
					<form id="actionForm" action="/member/commreportList">
						<input type="hidden" name="pageNum"
							value="${pageMaker.cri.pageNum }"> <input type="hidden"
							name="amount" value="${pageMaker.cri.amount }">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
var csrfHeaderName = "${_csrf.headerName }";
var csrfTokenValue = "${_csrf.token }";

//ajax 전송 시 CSRF 토큰 전송 처리
$(document).ajaxSend(function(e, xhr, options) {
   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
<sec:authorize access="isAuthenticated()"> 
replyer = '<sec:authentication property="principal.username"/>';
</sec:authorize>
	//코멘트 삭제
   function removeComm(cno){
	   var result = confirm("정말로 삭제하시겠습니까?");
	   if (result) {
		   remove(cno, function(result){ //삭제 성공
		         alert("코멘트가 삭제되었습니다");
		         location.reload();
		   }, function(err) {
		      alert("삭제를 실패했습니다. 다시 시도해주세요.");
		      }
		   );
	   }   
	}

	function remove(cno, callback, error) {
	   $.ajax({
	        type : 'DELETE',
	         url : '/member/reportComm' + cno,
	         data : JSON.stringify({ cno : cno }),
	      contentType : "application/json; charset=UTF-8",
	      success : function(deleteresult, status, xhr) {
	         if (callback) {
	            callback(deleteresult);
	         }
	      },
	      error : function(xhr, status, er) {
	         if (error) {
	            error(err);
	         }
	      }
	   });
	}//END remove()
	
	//신고된 코멘트 목록에서 삭제
	function removeRepo(rcno){
	   var result = confirm("신고된 코멘트를 내버려두시겠습니까?");
	   if (result) {
		   console.log("rcno : " + rcno);
		   $.ajax({
		        type : 'DELETE',
		        url : '/member/deleteReport/' + rcno,
		      	contentType : "application/json; charset=UTF-8",
		      	success : function(deleteresult, status, xhr) {
		        	 alert("신고 코멘트가 목록에서 삭제되었습니다");
			         location.reload();
		      },
		      error : function(xhr, status, er) {
		        	 alert("삭제를 실패했습니다. 다시 시도해주세요.");
		      }
		   });
	   }   
	}

</script>
<script>
	$(function() {
		//페이지 번호를 클릭하면 해당 페이지 목록 표시
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault(); //a 태그 기본 동작 막기

			//pageNum의 값을 클릭된 a의 href 값으로 변경
			actionForm.find("input[name='pageNum']").val($(this).attr('href'));
			//폼 전송
			actionForm.submit();
		});
							
	});//end
</script>

