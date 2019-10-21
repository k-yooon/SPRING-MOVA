<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>

<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">게시물 수정하기</h3>
			<p class="w3ls_head_para">M O D I F Y</p>
		</div>

		<div class="row">
			<div class="col-md-6 w3_agile_mail_grid two">


				<form role="form" action="/recommend/modify" method="post"
					id="modiform">

					<%-- 	<input type="hidden" name="${_csrf.parameterName }"
						  				 value="${_csrf.token }"> --%>

					<input type="hidden" name="reno" value="${recommend.reno }">
					<!-- 페이지 번호와 페이지 당 표시 개수 파라미터 추가 -->

					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<!-- 검색 조건과 키워드 파라미터 추가 -->
					<%-- 	<input type="hidden"  
						   name="type"    value="${cri.type }">
					<input type="hidden"  
						   name="keyword" value="${cri.keyword }"> --%>


					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							id="title" value="${recommend.title}">
					</div>

					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="userid"
							id="userid" readonly="readonly" value="${recommend.userid}">
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" id="content"
							name="content">${recommend.content}</textarea>
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
						
							<!-- 로그인한 사용자가 작성한 글에만 수정|삭제 버튼 표시 -->	
					<sec:authentication property="principal" var="pinfo"/>	   
					<!-- 로그인 여부 확인 -->
					<sec:authorize access="isAuthenticated()">
						<!-- 로그인한 사용자가 작성자인지 확인 -->
						<c:if test="${pinfo.username == recommend.userid}">
					<button type="submit" data-oper='modify' class="btn btn-default">수정하기</button>
					<!-- 수정 페이지 이동 -->
					<button type="button" data-oper='remove' class="btn btn-danger">삭제</button>
					<!-- 삭제 페이지 이동 -->
					</c:if>
					</sec:authorize>		
					<button type="button" data-oper='list' class="btn btn-info">목록</button>
					<!-- 목록 페이지 이동 -->
				</form>
			</div>

		</div>
	</div>
</div>

<!--//content-inner-section-->


<script>
	$(document).ready(
			function() {

				var formObj = $("form");

				$('button').on("click",	function(e) {
							// 기본동작 막기
							e.preventDefault();

							var operation = $(this).data("oper");
							console.log("operation : " + operation);

							if (operation === 'remove') {
								formObj.attr("action", "/recommend/remove");
							} else if (operation === 'list') {

								//페이지 번호와 게시물 개수 복사
								var pageNumTag = $("input[name='pageNum']")
										.clone();
								var amountTag = $("input[name='amount']")
										.clone();

								//검색 조건과 키워드 복사
								var typeTag = $("input[name='type']").clone();
								var keywordTag = $("input[name='keyword']")
										.clone();

								formObj.attr("action", "/recommend/list").attr(
										"method", "get");
								formObj.empty(); //폼 태그 모든 내용을 지움

								//페이지 번호와 게시물 개수만 폼에 추가
								formObj.append(pageNumTag);
								formObj.append(amountTag);

								//검색 조건과 키워드 폼에 추가 
								formObj.append(typeTag);
								formObj.append(keywordTag);
							} else if (operation === 'modify') { //수정 버튼이 눌린 경우	

								var renoTag = $("input[name='reno']").clone();
								//페이지 번호와 게시물 개수 복사
								var pageNumTag = $("input[name='pageNum']")
										.clone();
								var amountTag = $("input[name='amount']")
										.clone();

								//검색 조건과 키워드 복사
								var typeTag = $("input[name='type']").clone();
								var keywordTag = $("input[name='keyword']")
										.clone();

								formObj.attr("action", "/recommend/modify")
										.attr("method", "post");

								//페이지 번호와 게시물 개수만 폼에 추가
								formObj.append(pageNumTag);
								formObj.append(amountTag);

								//검색 조건과 키워드 폼에 추가 
								formObj.append(typeTag);
								formObj.append(keywordTag);
							} else if (operation === 'modify') {
								alert("수정이 완료되었습니다.")

								self.location = "/recommend/list";
								return;
							}
							formObj.submit();

						});
			});
</script>

