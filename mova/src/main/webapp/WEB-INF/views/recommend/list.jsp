<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>


	<div class="w3_content_agilleinfo_inner">
		<div class="agile_featured_movies">
			<div class="inner-agile-w3l-part-head">
				<h3 class="w3l-inner-h-title">회원 추천 게시판</h3>
				<p class="w3ls_head_para">R E C O M M E N D B O A R D</p>
			</div>
<button id="regBtn" type="button" class="btn btn-s pull-right">게시물
				작성</button>

			<div id="myTabContent" class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="home"
					aria-labelledby="home-tab">
					<div class="agile-news-table">
						<table id="table-breakpoint">
							<thead>
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="re">
									<tr>
										<td>${re.reno}</td>
										<td><a class="move" href="${re.reno}">${re.title}</a></td>
										<td>${re.userid}</td>
										<td><fmt:formatDate value="${re.regdate}"
												pattern="yyyy-MM-dd" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				<!--//content-inner-section-->
				<!-- 검색창 - 검색 조건 및 키워드 입력 영역 -->
				<div class='row'>
					<div class="col-lg-12">
						<form id="searchForm" action="/recommend/list">
							<select name="type">
								<c:set var="type" value="${pageMaker.cri.type }" />
								<!-- 검색 조건이 없을 경우 selected 표시 -->
								<option value="" <c:out value="${type == null?'selected':'' }"/>>
									검색 조건 지정</option>
								<!-- ${pageMaker.cri.type}이 value와 일치하면 selected 표시 -->
								<option value="T" <c:out value="${type == 'T'?'selected':'' }"/>>제목</option>
								<option value="C" <c:out value="${type == 'C'?'selected':'' }"/>>내용</option>
								<option value="U" <c:out value="${type == 'U'?'selected':'' }"/>>작성자</option>

							</select> <input type="text" name="keyword"
								value="${pageMaker.cri.keyword }"> <input type="hidden"
								name="pageNum" value="${pageMaker.cri.pageNum }"> <input
								type="hidden" name="amount" value="${pageMaker.cri.amount }">
							<button class="btn btn-default">Search</button>
						</form>
					</div>
				</div>
				<!-- END 검색창 - 검색 조건 및 키워드 입력 영역 -->
				<!-- 페이지 번호 출력 -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<!-- previous 버튼 표시 -->
							<li class="paginate_button previous"><a
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
				<form id="actionForm" action="/recommend/list">
					<input type="hidden" name="pageNum"
						value="${pageMaker.cri.pageNum }"> <input type="hidden"
						name="amount" value="${pageMaker.cri.amount }">
					<!-- 검색 키워드와 조건 파라미터 추가 -->
					<input type="hidden" name="keyword"
						value="${pageMaker.cri.keyword }"> <input type="hidden"
						name="type" value="${pageMaker.cri.type }">
				</form>

				<!-- Modal 창 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">확인</h4>
							</div>
							<div class="modal-body">입력되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- END Modal 창 -->
				
				<!-- /.modal -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->
</div>
<!-- /.row -->

			</div>
				</div>

<script type="text/javascript">

	$(document).ready(
			function() {
		//result 속성의 bno값
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);

		//뒤로가기 시에 모달창 재출력 X 처리
		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$('.modal-body').html(parseInt(result) + "번 글이 등록되었습니다.");
			}
			//모달창 보여주기
			$("#myModal").modal("show");
		}

		//Register New Board 버튼을 클릭하면
		//게시물 등록 화면 표시
		$("#regBtn").on("click", function() {
			self.location = "/recommend/register";
		});

		//페이지 번호를 클릭하면 해당 페이지 목록 표시
		var actionForm = $("#actionForm");
		$(".paginate_button a").on("click", function(e) {
			e.preventDefault(); //a 태그 기본 동작 막기

			//pageNum의 값을 클릭된 a의 href 값으로 변경
			actionForm.find("input[name='pageNum']").val($(this).attr('href'));
			//폼 전송
			actionForm.submit();
		});

		//a 태그의 move 클래스 속성을 이용
		$(".move").on(
				"click",
				function(e) {
					//a 태그의 기본 동작 막고
					e.preventDefault();

					actionForm
							.append("<input type='hidden' name='reno' value='"
									+ $(this).attr('href') + "'>'");
					actionForm.attr("action", "/recommend/get");
					actionForm.submit();
				});

		//검색 버튼 이벤트 처리
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색 조건을 선택해 주세요."); //검색 조건 선택 알림
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("검색어를 입력해 주세요."); //검색어 입력 알림
				return false;
			}

			//검색 시 페이지 번호는 1이 되도록 처리
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit(); //폼 전송
		});

	});
</script>


