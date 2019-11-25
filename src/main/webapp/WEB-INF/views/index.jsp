<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


<title>Insert title here</title>
</head>
<body>
	루트 페이지입니다.
<h1>메인 페이지입니다.</h1>
<a href="http://localhost:8081/moviefactory/member/login">로그인 하러가기</a>
<body>
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
	<br>
	<a href="movie/list">영화 목록 보기</a>
	<form action="movie/list">
		<input type="text" id="query" name="query">
		<button id="button">검색</button>
	</form>
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>

	<div class="alert alert-success alert-dismissible" id="alert" style="display:none;">
    	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    	<strong>서버 메시지</strong>&nbsp;&nbsp;&nbsp;<span id="msg"></span>
  	</div>
</body>
</html>