<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 태그라이브러리 추가를 해야 함.  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>
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
						<h4>명대사 & 명장면 신고 현황</h4>
					</div>
					<table id="table-breakpoint">
						<thead>
							<tr>
								<th>No.</th>
								<th>신고된 번호</th>
								<th>신고 내용</th>
								<th>신고된 ID</th>
								<th>처리현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="reportbestscene"
								varStatus="status">
								<tr>
									<td class="w3-list-info" id="${status.count}"><a>${reportbestscene.rebsno}</a></td>
									<td class="w3-list-info">${reportbestscene.bsno}</td>
									<td class="w3-list-img">${reportbestscene.bestscene.content}</td>
									<td class="w3-list-info">${reportbestscene.bestscene.userId}</td>
									<td><sec:authorize access="isAuthenticated()">
											<button type="button" class="login" data-toggle="modal"
												data-target="#myModal5"
												onclick="removeRepo(${reportbestscene.bsno})">삭제하기</button>
										</sec:authorize></td>
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
					<form id="actionForm" action="/member/reportList">
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

function removeRepo(just){
   remove(just, function(result){ //삭제 성공
      var result = confirm("정말로 삭제하시겠습니까?");
      if (result) {
         alert("신고 게시글이 삭제되었습니다");
         location.reload();
      }
   }, function(err) {
      alert("삭제를 실패했습니다. 다시 시도해주세요.");
      }
   );
}

function remove(bsno, callback, error) {
   $.ajax({
        type : 'DELETE',
         url : '/member/reportRe/' + bsno,
         data : JSON.stringify({ bsno : bsno }),
      contentType : "application/json; charset=UTF-8",
      success : function(deleteresult, status, xhr) {
         if (callback) {
            callback(deleteresult);
         }
      },
      error : function(xhr, status, er) {
         if (error) {
            error(er);
         }
      }
   });
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

