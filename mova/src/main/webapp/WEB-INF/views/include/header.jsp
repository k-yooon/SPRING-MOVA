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
	#menu{margin-left: 180px; width: 800px; display: inline-block;}
	h1{display: inline-block;}
	.menuBtn{display: inline-block; float: right; width: 250px;}
	.menuBtn a{padding-top:15px; padding-bottom:15px; margin-left: 20px;}
	.col-sm-4{width: 200px;}
</style>
<body>
   <!--/main-header-->
   <!--/banner-section-->
   <div id="demo-1" class="banner-inner">
      <div class="banner-inner-dott">
      
         <!--회원메뉴-->
         <div class="header-w3-agileits" id="home">
            <div class="inner-header-agile part2">
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
                        
                  <sec:authorize access = "isAuthenticated()">
                     <c:choose>
                     <c:when test="${pinfo.username == 'admin' }">
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
                           </c:when>
                           
                           <c:otherwise>
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
                           </c:otherwise>
                           
                           </c:choose>
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
               </nav>

            </div>
         </div>
      

</div>
</div>

         <!--//회원메뉴-->
         <!--관리자 메뉴-->
         <%-- <sec:authorize access = "isAuthenticated()">
         <!-- 로그인한 사용자가 작성한 글에만 수정 버튼 표시 -->   
      <sec:authentication property="principal" var="pinfo"/>      
         <!-- 로그인한 사용자가 작성자인지 확인 -->
         <c:if test="${pinfo.username == admin }">
         <div class="header-w3-agileits" id="home">
              <div class="inner-header-agile part2">   
            <nav class="navbar navbar-default">
               <div class="navbar-header">
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                     <span class="sr-only">Toggle navigation</span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                  </button>
                  <h1><a  href=""><span>M</span>O<span>V</span>A</a></h1>
               </div>
               <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                     
                        <ul class="nav navbar-nav">
                           <li><a href="">영화 관리</a></li>
                           <li><a href="">MOVATALK</a></li>
                           <li><a href="">회원 관리</a></li>
                           <li><a href="">신고 관리</a></li>
                           <li><a href="">QnA 관리</a></li>
                           <li><a href="">모바살롱 관리</a></li>
                           <li class="dropdown"></li>
                           <div class="col-md-6 wthree_agile_login">
                         <ul>
                        <li><a href="#" class="login"  data-toggle="modal" data-target="#myModal4">Login</a></li>
                           <li><a href="#" class="login reg"  data-toggle="modal" data-target="#myModal5">Register</a></li>
                         </ul>
                           </div>
                        </ul>
                     
                  
               </div>
            </nav>
   
         </div> 

       </div>
       </c:if>
       </sec:authorize> --%>
      <!--//관리자 메뉴-->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../resources/js/bootstrap.js"></script> 
         <!-- Dropdown-Menu-JavaScript -->
         <script>
            $(document).ready(
                  function() {
                     $(".dropdown").hover(
                           function() {
                              $('.dropdown-menu', this).stop(true,
                                    true).slideDown("fast");
                              $(this).toggleClass('open');
                           },
                           function() {
                              $('.dropdown-menu', this).stop(true,
                                    true).slideUp("fast");
                              $(this).toggleClass('open');
                           });
                     
                     var searchForm = $("#searchForm");
                   $("#searchbutton").on("click", function(e){
                      if(!searchForm.find("option:selected").val()){   //검색 조건을 지정하지 않은 경우
                         alert("검색 종류를 선택하세요");
                         return false;
                      }
                      if(!searchForm.find("input[name='keyword']").val()){   //검색어를 입력하지 않은 경우
                         alert("키워드를 입력하세요");
                         return false;
                      }
                   });
                   
                 });
            
         </script>
         <!-- //Dropdown-Menu-JavaScript -->