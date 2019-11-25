<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script>
$(function() { 
	$("#button").on("click", function() {
		
	});
});
</script>
<title>Insert title here</title>
</head>
<body>
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
	<br>
	<a href="movie/list">영화 목록 보기</a>
	<form action="movie/list">
		<input type="text" id="query" name="query">
		<button id="button">검색</button>
	</form>
	
</body>
</html>