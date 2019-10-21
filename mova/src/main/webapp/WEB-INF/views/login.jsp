<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
    
<%@include file = "include/header.jsp" %>    

 
<style>
.agileits-get-us {width : 50%; height:420px; padding: 20px; padding-left: 20px; margin-left: 380px; margin-bottom: 50px; margin-top: 50px;}
.login-form {}
.forgot {width:550px; margin-top:20px;}
.msg {margin-left: 90px;}
</style>

<div class="agileits-get-us">
	 <div class="login-form">
	 
	 <h3 class="w3l-inner-h-title">LOGIN</h3>
	 <h2 class="msg" value="${error}"></h2>
	 
	 <form method="post" action="/login">
	 
		<input type="text" name="username" placeholder="Id" required="">
		<input type="password" name="password" placeholder="Password" required="">
		<div class="tp">
			<input type="submit" id="login" value="LOGIN NOW">
		</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<div class="forgot">
		<ul>
			<input type = "checkbox" name ="remember-me">자동 로그인
			<li><a href="/idFind">Forgot Id?</a></li>
			<li><a href="/pwFind">Forgot Password?</a></li>
		</ul>
		</div>												
	</form>												
	</div>
</div>

<script>

	
</script>

  