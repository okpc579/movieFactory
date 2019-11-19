<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
<<<<<<< HEAD
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
>>>>>>> soonsim
=======
>>>>>>> gwanger
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> gwanger
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<<<<<<< HEAD

<title>Insert title here</title>
</head>
<body>
	루트 페이지입니다
=======
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
>>>>>>> soonsim
=======
<script>
$(function() {
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
			location.href = "/moviefactory/board/list";
		}, 3000);
	} else if(dest=="" && msg=="") {
		location.href = "/moviefactory/board/list";
	}
	
})
</script>
<title>인덱스</title>
</head>
<body>
	루트 페이지입니다
	<div class="alert alert-success alert-dismissible" id="alert" style="display:none;">
    	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    	<strong>서버 메시지</strong>&nbsp;&nbsp;&nbsp;<span id="msg"></span>
  	</div>
>>>>>>> gwanger
</body>
</html>