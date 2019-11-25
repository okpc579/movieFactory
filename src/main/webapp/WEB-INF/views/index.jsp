<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> dongmin_1
=======
>>>>>>> soonsim2
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<<<<<<< HEAD


<title>Insert title here</title>
</head>
<body>
<<<<<<< HEAD
	루트 페이지입니다.
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
<!-- <script>
$(function() {
=======
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
/* $(function() {
>>>>>>> soonsim2
	var msg = "${msg}";
	var dest = "${dest}";
	
	// 출력할 메시지와 이동할 경로가 모두 있는 경우 : 메시지 출력하고 3초 후 이동
	if(dest!="" && msg!="") { 
		$("#msg").text(msg);
		$("#alert").show();
		setTimeout(function() {
			location.href = dest;
		}, 3000);
	} else if(dest=="" && msg!="") {
		// 출력할 메시지만 있는 경우 : 메시지 출력 후 3초 후 list로
		$("#msg").text(msg);
		$("#alert").show();
		setTimeout(function() {
					}, 3000);
	} else if(dest=="" && msg=="") {
		
	}
	
<<<<<<< HEAD
})-->

=======
<script>
$(function() { 
	$("#button").on("click", function() {
		
	});
});
</script>
<title>Insert title here</title>
</head>
=======
}) */
</script>
<title>인덱스</title>
>>>>>>> soonsim2
<body>
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
	<br>
	<a href="movie/list">영화 목록 보기</a>
	<form action="movie/list">
		<input type="text" id="query" name="query">
		<button id="button">검색</button>
	</form>
	
>>>>>>> 20191120_ksk
=======
	루트 페이지입니다
<<<<<<< HEAD
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>

>>>>>>> dongmin_1
=======
	<div class="alert alert-success alert-dismissible" id="alert" style="display:none;">
    	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    	<strong>서버 메시지</strong>&nbsp;&nbsp;&nbsp;<span id="msg"></span>
  	</div>
>>>>>>> soonsim2
</body>
</html>