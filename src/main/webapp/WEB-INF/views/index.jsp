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

<title>Insert title here</title>
</head>
<body>
	루트 페이지입니다.
	<h1>메인 페이지입니다.</h1>
	<a href="member/login">로그인 하러가기</a>
<!-- <script>
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
					}, 3000);
	} else if(dest=="" && msg=="") {
		
	}
	
})-->

</body>
</html>