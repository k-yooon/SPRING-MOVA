<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../include/header.jsp"%>
<style>

li.list{
	color:#000000;
	font-size:1em;
	font-weight:600;
	text-decoration:none;
	display:block;
	margin:.5em 0 0 0;
	letter-spacing: 1px ;
}

li.h4{
	font-size: 1em;
    margin: 0;
    color: #000000;
    font-weight: 200;
}
</style>

<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">게시물 상세보기</h3>
			<p class="w3ls_head_para">R E C O M M E N D B O A R D</p>
		</div>

		<div class="row">
			<div class="col-md-6 w3_agile_mail_grid two">
				<div class="panel-body">
					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							readonly="readonly" value="${recommend.title}">
					</div>

					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="userid"
							readonly="readonly" value="${recommend.userid}">
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name="content"
							readonly="readonly">${recommend.content}</textarea>
					</div>

					<!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->	
					<sec:authentication property="principal" var="pinfo"/>	   
					<!-- 로그인 여부 확인 -->
					<sec:authorize access="isAuthenticated()">
						<!-- 로그인한 사용자가 작성자인지 확인 -->
						<c:if test="${pinfo.username == recommend.userid  }">
								<button data-oper="modify" class="btn btn-default"
										onclick="location.href='/recommend/modify?reno=<c:out value="${recommend.reno }"/>'">수정하기</button>
								<!-- 수정 페이지 이동 -->
						</c:if>
					</sec:authorize>
					<button data-oper='list' class="btn btn-info"
						onclick="location.href='/recommend/list'">목록</button>
					<!-- 목록 페이지 이동 -->

					<!-- 폼 태그 추가 -->
					<form id="operForm" action="/recommend/modify">
						<input type="hidden" id="reno" name="reno"
							value="${recommend.reno }">
						<!-- 페이지 번호와 페이지 당 표시 개수 파라미터 추가 -->
						<input type="hidden" name="pageNum" value="${cri.pageNum }">
						<input type="hidden" name="amount" value="${cri.amount }">
						<!-- 검색 조건과 키워드 파라미터 추가 -->
						<input type="hidden" name="type" value="${cri.type }"> <input
							type="hidden" name="keyword" value="${cri.keyword }">
					</form>
				</div>
			</div>
		</div>
		<!-- row -->
		<!--//content-inner-section-->

		<div class='row'>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- 댓글 목록 -->
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i>댓글
						<!-- 로그인 여부 확인 - 로그인한 경우에만 댓글 작성 가능 -->
						<sec:authorize access="isAuthenticated()">
						<button id='addReplyBtn' class='btn btn-primary btn-s pull-right'>새로운
							댓글</button>
						</sec:authorize>
					</div>
					<!-- 댓글 목록 페이징 -->
					<div class="panel-body">
						<ul class="chat">
						</ul>
					</div>
					<div class="panel-footer"></div>
					<!-- END 댓글 목록 페이징 -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-6 -->
		</div>
		<!-- /.row -->
		<!-- END 댓글 목록 -->

		<!-- 댓글 추가 모달 창 -->
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">R E P L Y</h4>
					</div>
					<!-- END modal-header -->

					<div class="modal-body">
						<div class="form-group">
							<label>댓글</label> <input class="form-control" name='content'
								value='New content!!'>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name='userid'
								value='userid' readonly="readonly">
						</div>

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id='modalModBtn'>수정</button>
						<button type="button" class="btn btn-danger" id='modalRemoveBtn'>삭제</button>
						<button type="button" class="btn btn-primary"
							id='modalRegisterBtn'>등록</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="modalCloseBtn">취소</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
	</div>
</div>
<script type="text/javascript" src="../resources/js/reply2.js"></script>

<script>
$(document).ready(function() {
	//$(function(){
	console.log(replyService2);
	
	var renoValue = '<c:out value="${recommend.reno }"/>';  //현재 게시물 번호
	var replyUl = $(".chat");
	
	showList(1);
	
	function showList(page){	//댓글 목록 <li> 구성 출력
		//replyService의 getList() - 댓글 목록 가져오기
		replyService2.getList({ reno:renoValue, page:page || 1}, //페이지 번호가 없으면 1로 설정
			function(replyCnt, list){ //댓글 갯수 + 목록
			
			console.log("replyCnt : " + replyCnt);
			console.log("list : " + list);
			
			//page 번호가 -1인 경우
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			//댓글 목록이 없으면 중단
			if(list == null || list.length == 0){
			//	replyUl.html("");
				return;
			}
				//댓글 목록이 있으면   <ul>에 <li>로 댓글 추가
				var str = "";
				for(var i=0, len=list.length || 0 ; i<len; i++){
				
					str += "<li class='list' data-rereno='" + list[i].rereno +"'>" +
								   "	<div><div class='header'>" +
								   " 	        <strong class='primary-font'><h4>[ " + 
					   			    							list[i].userid + " ]</h4></strong>" +  
								   " 			<small class='pull-right text-muted'>" +
					   	/* 				list[i].replyDate + "</small></div>" + */
					 /*  replyService.displayTime(list[i].replyDate) + "</small></div>"+ */
			               		 displayTime(list[i].regdate) + "</small></div>"+
								   " 		 <p>  " + list[i].content + "</p></div><br></li>";
				}
				
				replyUl.html(str);
				showReplyPage(replyCnt); //페이징 함수 호출 				
			}
		);//END function
	}//END showList()
	
	//댓글 목록 페이징
	var pageNum = 1;
	var replyPageFooter = $('.panel-footer');
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){	
			endNum = Math.ceil(replyCnt / 10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		if(prev) {	//previous link
			str += "<li class='page-item'>" + 
				   "    <a class='page-link' href='" + (startNum -1) + "'>"+
				   "         Previous</a></li>";
		}
		
		//페이지 번호 출력 및 링크 처리 
		for(var i=startNum ; i<= endNum ; i++){	
			var active = pageNum == i ? "active" : "";
			str += "<li class='page-item " + active + " '>" +
				   "    <a class='page-link' href='" + i + "'>" +
				   			i + "</a></li>";
		}
		
		if(next){	//next link
			str += "<li class='page-item'>" +
			 	   "    <a class='page-link' href='" + (endNum + 1) + "'>"+
			 	   "         Next</a></li>";
		}
		
		str += "</ul>";
		console.log(str);
		replyPageFooter.html(str);
		
	}//END showReplyPage()
		
	//댓글 페이지 번호 클릭 시 지정된 댓글 목록 가져오기
	replyPageFooter.on('click', 'li a', function(e){
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		pageNum = targetPageNum;
		showList(pageNum);
	});		
		
	//모달 창 처리
	var modal = $(".modal");
	var modalInputContent = modal.find("input[name='content']");
	var modalInputUserid = modal.find("input[name='userid']");
	var modalInputregDate = modal.find("input[name='regdate']");

	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	var userid = null;  //userid 저장변수 
	<sec:authorize access="isAuthenticated()">
	userid = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	//CSRF 처리
	var csrfHeaderName = "${_csrf.headerName }";
	var csrfTokenValue = "${_csrf.token }";
	
	
	$('#addReplyBtn').on('click', function(e){
		
		modal.find("input").val("");	//입력 양식 초기화
		//폼에 작성자 추가
	modal.find("input[name='userid']").val(userid);	
		
		//댓글 등록과 관계없는 요소들 안보이게 처리
		modalInputregDate.closest('div').hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalInputUserid.attr('readonly'); 
		modalRegisterBtn.show();	//등록버튼은 보이게
		modal.modal("show");		//모달창 보이기		
	});		
		
	//ajax 전송 시 CSRF 토큰 전송 처리
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);	
	});
					
					
	//댓글 수정 버튼 이벤트 처리
	modalModBtn.on('click', function(e){
		
		//로그인 여부 확인
		if(!userid){
			alert("로그인 후 수정 가능합니다.");
			modal.modal('hide');
			return;
		}
		
		//작성자 확인
		var originalReplyer = modalInputUserid.val();
		if(originalReplyer != userid){
			alert("자신이 작성한 댓글만 수정 가능합니다.");
			modal.modal('hide');
			return;
		}	

		var content = {rereno:modal.data("rereno"), content: modalInputContent.val()};
		
		replyService2.update(content, function(result){
			console.log('update result : ' + result);
			
			if(result === 'success') { alert("수정이 완료되었습니다"); }
			modal.modal('hide');
			showList(1); },
			function(err){	alert("error!");	}
			);//END remove() 호출
		});

	//댓글 삭제 버튼 이벤트 처리
	modalRemoveBtn.on('click', function(e){
		
		//로그인 여부 확인
		if(!userid){
			alert("로그인 후 삭제 가능합니다.");
			modal.modal('hide');
			return;
		}
		
		//작성자 확인
		var originalReplyer = modalInputUserid.val();
		if(originalReplyer != userid){
			alert("자신이 작성한 댓글만 삭제 가능합니다.");
			modal.modal('hide');
			return;
		}	
		
		replyService2.remove(modal.data('rereno'), originalReplyer, 
				function(result){	//삭제 성공
				if(result === 'success') {
					alert("댓글이 삭제되었습니다");
					modal.modal('hide');
					location.reload();
					}
		
						
		},function(err){alert("error");}
		); //END remove()			
		});
		
				//댓글 클릭 이벤트 처리
				$('.chat').on('click', 'li', function(e){
					var rereno = $(this).data('rereno');

					replyService2.get(rereno, 
							function(date){	//댓글 가져오기 성공
								modalInputContent.val(date.content);	//모달 창에 값 출력
								modalInputUserid.val(date.userid).attr('readonly', 'readonly');
								modalInputregDate.val(displayTime(date.regdate))
								   .attr('readonly', true); 
								modal.data('rereno', date.rereno);		//댓글 번호 추가
								
								//불필요한 요소들 숨기기
								modal.find("button[id != 'modalCloseBtn']").hide();
								modalModBtn.show();
								modalRemoveBtn.show();
								
								modal.modal("show");	//모달창 보이기 
								console.log('get result : ' + date ); 
					},
					function(err) {alert("error!");}
					);//END replyService
				});//END 댓글 클릭 이벤트 처리
		
				//댓글 등록 버튼 이벤트 처리
				modalRegisterBtn.on("click", function(e){
					console.log(renoValue);
					console.log(modalInputContent.val());
				
					//전송할 데이터들			
					var reply = {
							reno	: renoValue,
							userid  : modalInputUserid.val(),
							content : modalInputContent.val()
				 }; 
					replyService2.add( reply,
							function(result){		//댓글 등록에 성공하면
									  alert("댓글 등록을 성공했습니다.");				
									  modal.find("input").val("");	//입력양식 비우고	
									  modal.modal("hide");			//모달창 닫고									  
									  showList(-1);
								}
								);//END add()
				}); //END modalRegisterBtn
});  //END function()
</script>
<script>
function displayTime(timeValue){
	var today = new Date();
	var dateObj = new Date(timeValue);
	var str = "";
	
	//댓글 등록일이 오늘이면  '시:분:초' 표시
	if(today.getDate() === dateObj.getDate()){
		 var hh = dateObj.getHours() ;
		 var mi = dateObj.getMinutes();
		 var ss = dateObj.getSeconds();
		 
		 return [ (hh > 9 ? '' : '0') + hh, ":" ,
			 	  (mi > 9 ? '' : '0') + mi, ":" ,
			 	  (ss > 9 ? '' : '0') + ss ].join('');
	} else { //그렇지 않으면 '연/월/일' 표시
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();
		
		return [ yy, '/', 
				 (mm > 9 ? '' : '0') + mm, '/',
				 (dd > 9 ? '' : '0') + dd].join('');			
	}
}; //END displayTime()	
	
$(function(){
	
	var operForm = $("#operForm");
	
	//수정 버튼 이벤트 처리
	$('button[data-oper="modify"]').on("click", function(e){
		operForm.attr("action", "/recommend/modify")
		        .submit();
	});	

	//목록 버튼 이벤트 처리
	$('button[data-oper="list"]').on("click", function(e){
		operForm.find("#reno").remove();
		operForm.attr("action", "/recommend/list");
		operForm.submit();
	});	
	
});//END $
</script>
