<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  $(function() {
	  
		  //var param = $("#writeForm").serialize();
		  
			$.ajax({
				url: "/moviefactory/api/usermovie/following?username="+location.search.split("=")[1],
				method:"get",
				success:function(result) {
					console.log("성공");
					console.log(result);
				}, error : function(xhr) {
					
				}
			});
		
	});
  </script>
</head>
<body>
<div id="section">
	팔로잉 페이지입니다.
	</div>
</body>
</html>