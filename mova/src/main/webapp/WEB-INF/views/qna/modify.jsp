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
								<p class="w3ls_head_para">MOVA QNA MODIFY</p>
							</div>
						<div class="w3_mail_grids">
							<form action="/qna/modify" method="post">
							<input type="hidden" name="pageNum" value="${cri.pageNum }">
							<input type="hidden" name="amount" value="${cri.amount }">		
									<div class="col-md-6 w3_agile_mail_grid">
									<input type="hidden" name="qno" value="${qna.qno}" >
									<span class="input input--ichiro">
											<input class="input__field input__field--ichiro" type="text" id="input-25" name="userid" value="${qna.userid}" readonly="readonly" >
											<label class="input__label input__label--ichiro" for="input-25">
												<span class="input__label-content input__label-content--ichiro">USER ID</span>
											</label>
									</span>
									<span class="input input--ichiro">
											<input class="input__field input__field--ichiro" type="text" id="input-26" name="title" value="${qna.title}">
											<label class="input__label input__label--ichiro" for="input-26">
												<span class="input__label-content input__label-content--ichiro">TITLE</span>
											</label>
									</span>
									
									<span class="input input--ichiro">
											<input class="input__field input__field--ichiro" type="text" id="input-27" name="regdate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${qna.regdate }" />' readonly="readonly">
											<label class="input__label input__label--ichiro" for="input-27">
												<span class="input__label-content input__label-content--ichiro">REG DATE</span>
											</label>
									</span>
								
									
										
									</div>
									<div class="col-md-6 w3_agile_mail_grid two">
										<input name="content" name="content" value="${qna.content}">

									</div>
						<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>	<!-- 수정 처리 -->
						<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>	
						<button data-oper='list' class="btn btn-info">List</button>	<!-- 목록 페이지 이동 -->		
									<div class="clearfix"> </div>
					</form>
								
								<div class="agileits-get-us">
									<ul>
										<li><i class="fa fa-map-marker" aria-hidden="true"></i>United States,Utah 10009, USA</li>
										<li><i class="fa fa-phone" aria-hidden="true"></i>  +033 111 222 4567</li>
										<li><i class="fa fa-envelope" aria-hidden="true"></i><a href="mailto:info@example.com"> mail@example.com</a></li>
									</ul>
								</div>
							</div>
					</div>
	</div>							

	


<%@ include file="../include/footer.jsp" %>
<script>
var formObj = $("form");	
$('button').on("click", function(e){
	e.preventDefault();

	var operation = $(this).data("oper");

	console.log(operation);

	if(operation === 'remove') {
		formObj.attr("action", "/qna/remove");
	}else if(operation === 'list') {
		formObj.attr("action", "/qna/list").attr("method", "get");
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		
		formObj.empty();
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		return;
	}
	formObj.submit();
});




</script>