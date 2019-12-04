<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="member" />
	<script>
		isLogin = true;
		loginId = '${member}';
	</script>
</sec:authorize>

<script>
var username;
$(function() {
	   console.log(location.search.split('=')[1]);
	   //strArray = location.search.split('?');
	   //console.log(strArray[1].split('=')[0]);
	  	username= location.search.split('=')[1];
	  	$("#titul").text(username+"의 페이지 입니다");
		   /*
		   
	      $.ajax({
	         url: "/moviefactory/api/movie/review/list?mNo=" + strArray[1].split('=')[1],
	         method: "get",
	         success: function(result) {
	            console.log(result);
	         }
	      });*/
	      $.ajax({
    		  url: "/moviefactory/api/usermovie/checkfollowing?username=" + username,
 	         method: "get",
 	         success: function(result) {
 	            console.log(result);
 	            if(result=="true"){
 	            	$("<button id='unfollow' type='button'>언팔로잉</button>").appendTo($("#isfollow"));
 	            	$("#unfollow").on("click",function(){
 	     	    	  $.ajax({
 	     	    		  url: "/moviefactory/api/usermovie/deletefollowing?username=" + username,
 	     	 	         method: "post",
 	     	 	         success: function(result) {
 	     	 	            //console.log(result);
 	     	 	        	location.reload();
 	     	 	         }
 	     	 	      });
 	     	     	 });
 	            	
 	            }else if(result=="false"){
 	            	$("<button id='follow' type='button'>팔로잉</button>").appendTo($("#isfollow"));
 	            	$("#follow").on("click",function(){
 	     	    	  $.ajax({
 	     	    		  url: "/moviefactory/api/usermovie/addfollowing?username=" + username,
 	     	 	         method: "post",
 	     	 	         success: function(result) {
 	     	 	            //console.log(result);
 	     	 	            location.reload();
 	     	 	         }
 	     	 	      });
 	     	     	 });
 	            	
 	            }
 	         }
 	      });
	      $("#review").on("click",function(){
	    	  location.href="/moviefactory/usermovie/review?username="+username;
	      });
	      $("#collection").on("click",function(){
	    	  location.href="/moviefactory/collection/list?username="+username+"&pageno=1";
	      });
	      
	      $("#following").on("click",function(){
  	    	  location.href="/moviefactory/usermovie/following?username="+username+"&pageno=1";
  	     	 });
	      
	      
	      $("#follower").on("click",function(){
  	    	  location.href="/moviefactory/usermovie/follower?username="+username+"&pageno=1";
  	      	});
	      $("#favorite").on("click",function(){
	    	  location.href="/moviefactory/usermovie/favoritemovie?username="+username+"&pageno=1";
	      });
	      $("#preferencemovie").on("click",function(){
	    	  location.href="/moviefactory/usermovie/preferencemovie?username="+username;
	      });
	      
	});
</script>
</head>
<body>
<div id="section">

	<h2 id="titul"></h2>
	<button id="review">리뷰보기</button>
	<button id="collection">콜렉션보기</button>
	<button id="following">팔로잉목록보기</button>
	<button id="follower">팔로워목록보기</button>
	<button id="favorite">좋아하는 영화 목록보기</button>
	<button id="preferencemovie">선호할만한 영화 목록 보기</button>
	<div id="isfollow"></div>
	</div>
</body>
</html>