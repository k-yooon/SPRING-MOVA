<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
    
<%@include file = "include/header.jsp" %>  

<div class="agileits-get-us">
    <div class="login-form">
 
    <form action="/logout" method="post">
      
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
               
   </form>                                    
   </div>
 </div>
 
 <script>
 $(document).ready(function(){
	$("form").submit();
 });
 </script>  

