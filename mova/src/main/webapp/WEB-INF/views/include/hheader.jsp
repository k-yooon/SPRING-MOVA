<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!--
author: W3layouts
author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
<title>MOVA</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
   content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
   
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
      function hideURLbar(){ window.scrollTo(0,1); } 

</script>
<!-- //for-mobile-apps -->
<link href="../resources/css/bootstrap.css" rel="stylesheet"
   type="text/css" media="all" />
<!-- pop-up -->
<link href="../resources/css/popuo-box.css" rel="stylesheet"
   type="text/css" media="all" />
<!-- //pop-up -->
<link href="../resources/css/easy-responsive-tabs.css" rel='stylesheet'
   type='text/css' />
<link rel="stylesheet" type="text/css"
   href="../resources/css/zoomslider.css" />
<link rel="stylesheet" type="text/css"
   href="../resources/css/table-style.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/style.css" />
<link href="../resources/css/font-awesome.css" rel="stylesheet">
<script type="text/javascript"
   src="../resources/js/modernizr-2.6.2.min.js"></script>
<!-- list-css -->
<link rel="stylesheet" href="../resources/css/list.css" type="text/css"
   media="all" />
<!-- //list-css -->
<link rel="stylesheet" type="text/css" href="../resources/css/style.css" />
<link href="../resources/css/font-awesome.css" rel="stylesheet">
<script type="text/javascript"
   src="../resources/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700'
   rel='stylesheet' type='text/css'>
<link
   href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900"
   rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700'
   rel='stylesheet' type='text/css'>
<!--//web-fonts-->
</head>
<style>
	#menu{margin-left: 280px; width: 800px; display: inline-block;}
	h1{display: inline-block;}
	.menuBtn{display: inline-block; float: right; width: 250px;}
	.menuBtn a{padding-top:15px; padding-bottom:15px; margin-left: 20px;}
</style>
<body>
   <!--/main-header-->
   <!--/banner-section-->
   <div id="demo-1" data-zs-src='["../resources/images/2.jpg", "../resources/images/1.jpg", "../resources/images/3.jpg","../resources/images/4.jpg"]' data-zs-overlay="dots" class="banner-inner">
      <div class="demo-inner-content">
         <!--회원메뉴-->
         <div class="header-w3-agileits" id="home">
            <div class="inner-header-agile">	
               <nav class="navbar navbar-default">
                  <div class="navbar-header">
                     <button type="button" class="navbar-toggle"
                        data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span> <span
                           class="icon-bar"></span> <span class="icon-bar"></span> <span
                           class="icon-bar"></span>
                     </button>
                     <h1>
                        <a href="../"><span>M</span>O<span>V</span>A</a>
                     </h1>
                  </div>
                  <!-- navbar-header -->
                  <div class="collapse navbar-collapse"
                     id="bs-example-navbar-collapse-1">
                     <ul class="nav navbar-nav" id="menu">
                     <sec:authentication property="principal" var="pinfo"/>  
                     <sec:authorize access = "hasRole('ROLE_MEMBER')">
                        <li><a href="">모바톡</a></li>
                        <li><a href="../movie/movieRecommend?userid=<sec:authentication property='principal.username'/>">모바픽</a></li>
                        <li><a href="../recommend/list">모바살롱</a></li>
                        <li><a href="../qna/list">QnA</a></li>
                        <li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">이벤트 <b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="../event/ingEvent">이벤트 참여</a></li>
												<li><a href="../event/eventList">당첨자 조회</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
						</li>
                       </sec:authorize>  
                       
                       <sec:authorize access = "hasRole('ROLE_ADMIN')">
                        <li><a href="../movie/movieList">영화 관리</a></li>
                     	<li><a href="">모바톡 관리</a></li>
                     	<li><a href="../member/memberManage">회원 관리</a></li>
                        <li><a href="../member/commreportList">신고 코멘트</a></li>
                        <li><a href="../qna/list">QnA 관리</a></li>
                     	<li><a href="../recommend/list">모바살롱 관리</a></li>
                     	<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">이벤트 관리<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="../event/ingEvent">현재 이벤트 관리</a></li>
												<li><a href="../event/eventList">당첨자 게시판 관리</a></li>
												<li><a href="../event/eventPick">당첨자 추첨</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
						</li>
                       </sec:authorize>      
                       </ul> 
                       	<div class="menuBtn">
                         <sec:authorize access = "isAnonymous()">
                         	<!-- <div class="menuBtn">  -->
                        	<a href="/login" class="login" data-toggle="modal" data-target="#myModal4">Login</a>
                        	<a href="/join" class="login reg" data-toggle="modal" data-target="#myModal5">Register</a>
                            <!-- </div>  -->
                            </sec:authorize> 
                            
                            <sec:authorize access = "isAuthenticated()">
                              <c:choose>
	                     		  <c:when test="${pinfo.username == 'admin' }">
	                     		  	<a href="/logout" class="login" data-toggle="modal" data-target="#myModal4">Logout</a>
	                     		  </c:when>	
	                     		  <c:otherwise>
	                             	<a href="../member/mypage?userid=<sec:authentication property="principal.username"/>&star=5" class="login" data-toggle="modal" data-target="#myModal4">MY PAGE</a>
	                             	<a href="/logout" class="login" data-toggle="modal" data-target="#myModal4">Logout</a>
	                           	  </c:otherwise>
                           	 </c:choose>
                           </sec:authorize>    
                     	</div>

                  </div>
                  <div class="clearfix"> </div>	
               </nav>

            </div>
         </div>
       
<div class="footer-contact">
   <form id="searchForm" action="/movie/movieSearch" method="get">
      <select name="type" id="selector1" class="form-control1">
      	 <option value="" <c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>--</option>
         <option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':''}"/>>제목</option>
         <option value="A" <c:out value="${pageMaker.cri.type eq 'A'? 'selected':''}"/>>배우</option>
         <option value="D" <c:out value="${pageMaker.cri.type eq 'D'? 'selected':''}"/>>감독</option>
         <option value="U" <c:out value="${pageMaker.cri.type eq 'U'? 'selected':''}"/>>사용자</option>
      </select> 
      <input type="search" name="keyword" placeholder="검색어를 입력해주세요" required=" " id="searchbox" value=""> 
      <input type="submit" value="Search" id="searchbutton">
   </form>
</div>
                      
<ul class="w3-tag2">
   <li><a href="../movie/movieTagGet?genre=별점">#별점순</a></li>
   <li><a href="../movie/movieTagGet?genre=공포">#공포</a></li>
   <li><a href="../movie/movieTagGet?genre=스릴러">#스릴러</a></li>
   <li><a href="../movie/movieTagGet?genre=드라마">#드라마</a></li>
   <li><a href="../movie/movieTagGet?genre=코미디">#코미디</a></li>
   <li><a href="../movie/movieTagGet?genre=멜로">#멜로</a></li>
</ul>
<ul class="w3-tag2">
   <li><a href="../movie/movieTagGet?genre=액션">#액션</a></li>
   <li><a href="../movie/movieTagGet?genre=SF">#SF</a></li>
   <li><a href="../movie/movieTagGet?genre=애니메이션">#애니메이션</a></li>
   <li><a href="../movie/movieTagGet?genre=다큐멘터리">#다큐멘터리</a></li>
   <li><a href="../movie/movieTagGet?genre=사극">#사극</a></li>
</ul>

</div>
</div>

<script src="../resources/js/bootstrap.js"></script>

<script src="../resources/js/jquery-1.11.1.min.js"></script>
  	<!-- Dropdown-Menu-JavaScript -->
			<script>
				$(document).ready(function(){
					$(".dropdown").hover(            
						function() {
							$('.dropdown-menu', this).stop( true, true ).slideDown("fast");
							$(this).toggleClass('open');        
						},
						function() {
							$('.dropdown-menu', this).stop( true, true ).slideUp("fast");
							$(this).toggleClass('open');       
						}
					);
				});
			</script>
		<!-- //Dropdown-Menu-JavaScript -->


<script type="text/javascript" src="../resources/js/jquery.zoomslider.min.js"></script>
		<!-- search-jQuery -->
				<script src="../resources/js/main.js"></script>
			<script src="../resources/js/simplePlayer.js"></script>
			<script>
				$("document").ready(function() {
					$("#video").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video1").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video2").simplePlayer();
				});
			</script>
				<script>
				$("document").ready(function() {
					$("#video3").simplePlayer();
				});
			</script>

			<!-- pop-up-box -->  
		<script src="../resources/js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!--//pop-up-box -->

			<div id="small-dialog1" class="mfp-hide">
			<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<div id="small-dialog2" class="mfp-hide">
		<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<script>
		$(document).ready(function() {
		$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
			type: 'inline',
			fixedContentPos: false,
			fixedBgPos: true,
			overflowY: 'auto',
			closeBtnInside: true,
			preloader: false,
			midClick: true,
			removalDelay: 300,
			mainClass: 'my-mfp-zoom-in'
		});
																		
		});
	</script>
<script src="../resources/js/easy-responsive-tabs.js"></script>
<script>
$(document).ready(function () {
$('#horizontalTab').easyResponsiveTabs({
type: 'default', //Types: default, vertical, accordion           
width: 'auto', //auto or any width like 600px
fit: true,   // 100% fit in a container
closed: 'accordion', // Start closed if in accordion view
activate: function(event) { // Callback function if tab is switched
var $tab = $(this);
var $info = $('#tabInfo');
var $name = $('span', $info);
$name.text($tab.text());
$info.show();
}
});
$('#verticalTab').easyResponsiveTabs({
type: 'vertical',
width: 'auto',
fit: true
});
});
</script>
<link href="../resources/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
<script src="../resources/js/owl.carousel.js"></script>
<script>
	$(document).ready(function() { 
		$("#owl-demo").owlCarousel({
	 
		 autoPlay: 3000, //Set AutoPlay to 3 seconds
		  autoPlay : true,
		   navigation :true,

		  items : 5,
		  itemsDesktop : [640,4],
		  itemsDesktopSmall : [414,3]
	 
		});
	 
	}); 
</script> 

<!--/script-->
<script type="text/javascript" src="../resources/js/move-top.js"></script>
<script type="text/javascript" src="../resources/js/easing.js"></script>

<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},900);
				});
			});
</script>
 <script type="text/javascript">
						$(document).ready(function() {
							/*
							var defaults = {
					  			containerID: 'toTop', // fading element id
								containerHoverID: 'toTopHover', // fading element hover id
								scrollSpeed: 1200,
								easingType: 'linear' 
					 		};
							*/
							
							$().UItoTop({ easingType: 'easeOutQuart' });
							
						});
					</script>
<!--end-smooth-scrolling-->