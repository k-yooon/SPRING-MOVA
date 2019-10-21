<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<%@ include file="../include/header.jsp" %>
<style>
.input content {
w
}
</style>

	<div class="w3_content_agilleinfo_inner">
					<div class="agile_featured_movies">
							<div class="inner-agile-w3l-part-head">
					            <h3 class="w3l-inner-h-title">문의게시판</h3>
								<p class="w3ls_head_para">MOVA QNA</p>
							</div>
						<div class="w3_mail_grids">
									<input type="hidden" name="qno" value="${qna.qno}" >
									<div class="col-md-6 w3_agile_mail_grid">
									<span class="input input--ichiro">
											<input class="input__field input__field--ichiro" type="text" id="input-25" name="userid" value="${qna.userid}" readonly="readonly" >
											<label class="input__label input__label--ichiro" for="input-25">
												<span class="input__label-content input__label-content--ichiro">USER ID</span>
											</label>
									</span>
									<span class="input input--ichiro">
											<input class="input__field input__field--ichiro" type="text" id="input-26" name="title" value="${qna.title}" readonly="readonly">
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
										<form role='form' method="post" action="/qna/answer">
										<input type="hidden" name="${_csrf.parameterName }"
								  				 value="${_csrf.token }"> 
			 								<input type="hidden" name="qno" value="${qna.qno}" >
			 							</form>		
									</div>
									<div class="col-md-6 w3_agile_mail_grid two">
										<input name="content" name="content" value="${qna.content}" readonly="readonly" >
									</div>
									
					<!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->	
					<sec:authentication property="principal" var="pinfo"/>    
					<!-- 로그인 여부 확인 -->
					<sec:authorize access="isAuthenticated()">
					<!-- 로그인한 사용자가 작성자인지 확인 -->
					<c:if test="${pinfo.username == param.userid }">
<button data-oper='modify' class="btn btn-default" onclick="location.href='/qna/modify?qno=<c:out value="${qna.qno }"/>'">modify</button>
					</c:if>
					</sec:authorize>
					
					
<button data-oper='list' class="btn btn-info" onclick="location.href='/qna/list'">List</button>
									<div class="clearfix"> </div>




<!-- 댓글 목록 -->
 <div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply 
				<sec:authentication property="principal" var="pinfo"/> 
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username == 'admin'}">	<!-- //관리자만 댓글등록버트볼수있음 -->
					<button id='addReplyBtn'
							class='btn btn-primary btn-xs pull-right'>
						New Reply		
					</button>
					</c:if>
				</sec:authorize>
			 </div>
           
            <!-- /.panel-heading -->	
            <div class="panel-body">
				<ul class="chat">
					
					
				</ul>		
            </div>	<!-- /.panel-body -->
            
            <!-- 댓글 목록 페이징 -->
            <div class="panel-footer">
            </div>
            <!-- END 댓글 목록 페이징 -->
        </div>      <!-- /.panel -->
    </div>   		<!-- /.col-lg-6 -->
</div>				<!-- /.row -->
 <!-- END 댓글 목록 -->
 
 
 
 
 
 
 
								<div class="agileits-get-us">
									
								</div>
							</div>
					</div>
	</div>							

	<form id="operForm" action="/qna/modify">
	<input type="hidden" name="${_csrf.parameterName }"
								  				 value="${_csrf.token }"> 
		<input type="hidden" id="qno" name="qno" value="${qna.qno }">
						<!-- 페이지 번호와 페이지 당 표시 개수 파라미터 추가 -->
		<input type="hidden" name="pageNum" value="${cri.pageNum }">
		<input type="hidden" name="amount" value="${cri.amount }">
	</form>

	<!-- 댓글 추가 모달 창 -->
 <!-- Modal -->
 <div class="modal fade" id="myModal" tabindex="-1" 
 	  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
     <div class="modal-dialog">
         <div class="modal-content">
             <div class="modal-header">
                 <button type="button" class="close" 
                 		 data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title" id="myModalLabel">
                 	REPLY MODAL</h4>
             </div><!-- END modal-header -->
             
             <div class="modal-body">
             <input type="hidden" name="${_csrf.parameterName }"
								  				 value="${_csrf.token }"> 
				<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name='content' value='New Reply!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label>
					<input class="form-control" name='userid' value='userid'
						   readonly="readonly">
				</div>
				<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name='regdate' value=''>
				</div>
             </div><!-- END modal-body -->
             
             <div class="modal-footer">
                 <button type="button" class="btn btn-warning"
                 		 id='modalModBtn'>Modify</button>
                 <button type="button" class="btn btn-danger"
                 		 id='modalRemoveBtn'>Remove</button>
                 <button type="button" class="btn btn-primary"
                 		 id='modalRegisterBtn'>Register</button>
                 <button type="button" class="btn btn-default" 
                 	     data-dismiss="modal"
                 	     id="modalCloseBtn">Close</button>
             </div><!-- END modal-footer -->
         </div>       <!-- /.modal-content -->
     </div>     <!-- /.modal-dialog -->
 </div> <!-- /.modal -->
 <!-- END 댓글 추가 모달 창 -->
 
 

 

<%@ include file="../include/footer.jsp" %>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
var qnoValue = "${qna.qno }";	//현재 게시물 번호
var replyUl = $('.chat');


showList(1);

function showList(page){	//댓글 목록 <li> 구성 출력
	//replyService의 getList() - 댓글 목록 가져오기
	replyService.getList(
		{ qno:qnoValue, page:page || 1}, //페이지 번호가 없으면 1로 설정
		function(list){
			var str = "";
			console.log("list : " + list);

			if(list == null || list.length == 0){	//댓글 목록이 없으면 중단
					replyUl.html("");
					return;
			}
			
			//댓글 목록이 있으면   <ul>에 <li>로 댓글 추가
			
			for(var i=0, len=list.length || 0 ; i<len; i++){
				str += "<li class='left clearfix' data-qreno='" + list[i].qreno +"'>" +
					   "	<div><div class='header'>" +
					   " 	        <strong class='primary-font'>" + 
					   			    	list[i].userid + "</strong>" +  
					   " 			<small class='pull-right text-muted'>" +
					   	 	replyService.displayTime(list[i].regdate)+ "</small></div>" + 
					   " 		 <p>" + list[i].content + "</p></div></li>";
			}
			replyUl.html(str);
			
		} 
	);//END getList() 호출
}//END showList()





//모달 창 처리
var modal = $('.modal');
var modalInputReply = modal.find("input[name='content']");
var modalInputReplyer = modal.find("input[name='userid']");
var modalInputReplyDate = modal.find("input[name='regdate']");

var modalModBtn = $('#modalModBtn');
var modalRemoveBtn = $('#modalRemoveBtn');
var modalRegisterBtn = $('#modalRegisterBtn');

var userid = null;		//username 저장 변수

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

//ajax 전송 시 CSRF 토큰 전송 처리
$(document).ajaxSend(function(e, xhr, options){
    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});


$('#addReplyBtn').on('click', function(e){
	modal.find('input').val("");	//입력 양식 초기화
	//폼에 작성자 추가
	modal.find("input[name='userid']").val("admin");	
	
	//댓글 등록과 관계없는 요소들 안보이게 처리
	modalInputReplyDate.closest('div').hide();	
	modal.find("button[id != 'modalCloseBtn']").hide();
	modalInputReplyer.attr('readonly');	
	modalRegisterBtn.show();	//등록버튼은 보이게
	modal.modal('show');		//모달창 보이기
	
});


//댓글 등록 버튼 이벤트 처리
modalRegisterBtn.on('click', function(e){
	replyService.add(	//전송할 데이터들
		{ qno	  : qnoValue, 
		  content   : modalInputReply.val(), 
		  userid : modalInputReplyer.val() },
		function(result){	//댓글 등록에 성공하면
			alert("댓글이 등록되었습니다");
			modal.find('input').val("");	//입력양식 비우고	
			modal.modal('hide');			//모달창 닫고
			
			
			
		
			
			
			showList(1);	//신규 댓글 목록 가져오기
//			showList(-1);	
		}
	);//END add() 호출 
	
	
	var formObj = $("form[role='form']");
	var str = "";
	var answer = "답변완료";
	var qno = $("input[name='qno']").val();
	console.log("AAA" + answer);
	str += "<input type='hidden' name='answer' value='" + answer + "'/>";
	formObj.append(str).submit();
});//END 댓글 등록 버튼 이벤트 처리
                                                                                                                      



//댓글 클릭 이벤트 처리
$('.chat').on('click', 'li', function(e){
	var qreno = $(this).data('qreno');
	
	replyService.get(qreno, function(data){	//댓글 가져오기 성공
			modalInputReply.val(data.content);	//모달 창에 값 출력
			modalInputReplyer.val(data.userid).attr('readonly', 'readonly');	 
			modalInputReplyDate.val(replyService.displayTime(data.regdate)).attr('readonly', 'readonly'); 
			modal.data('qreno', data.qreno);		//댓글 번호 추가
			
			//불필요한 요소들 숨기기
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
		//	modalRemoveBtn.show();
			
			modal.modal('show');				//모달창 보이기
			console.log('get result : ' + data);
		},
		function(err){	alert("error!");	}
	);//END remove() 호출
});//END 댓글 클릭 이벤트 처리



//댓글 수정 버튼 이벤트 처리
modalModBtn.on('click', function(e){

	//로그인 여부 확인
	/* if(!replyer){
		alert("로그인 후 수정 가능합니다.");
		modal.modal('hide');
		return;
	}
	
	//작성자 확인
	var originalReplyer = modalInputReplyer.val();
	if(originalReplyer != replyer){
		alert("자신이 작성한 댓글만 수정 가능합니다.");
		modal.modal('hide');
		return;
	} */
    var content = {qreno:modal.data("qreno"), content: modalInputReply.val()};
	replyService.update(content, function(result) {

		alert("댓글이 수정되었습니다.");
		modal.modal("hide");
		showList(1);

	
	});
});




modalRemoveBtn.on('click', function(e){
	//로그인 여부 확인
	/* if(!replyer){
		alert("로그인 후 삭제 가능합니다.");
		modal.modal('hide');
		return;
	}
	
	//작성자 확인
	var originalReplyer = modalInputReplyer.val();
	if(originalReplyer != replyer){
		alert("자신이 작성한 댓글만 삭제 가능합니다.");
		modal.modal('hide');
		return;
	} */
	var qreno = modal.data("qreno");
	replyService.remove(qreno, function(result) {
		alert(result);
		modal.modal("hide");
		showList(1);
		});//END remove() 호출
});




</script>