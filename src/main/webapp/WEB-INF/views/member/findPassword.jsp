<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script>
$(function() {
	$("#find").on("click",function(){
		var param = $("#findPwdFrm").serialize();
		console.log(param);
		var username= $("#username").val();
		console.log(username);
		$.ajax({
			url:"/moviefactory/api/member/password",
			method:'post',
			data:param,
			success:function(result) {
				console.log(result);
				alert("임시비번발급됨");
				location.href="/moviefactory/member/login";
			}, error:function(xhr){
				console.log(xhr);
				alert(xhr.responseText);
			}
		})
	});
});
</script>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
		location.href="http://localhost:8081/moviefactory/system/e403";
	</script>
</sec:authorize>
<title>Insert title here</title>
<style>
#find {
	height: 50px;
	/* line-height: 50px; */
	width: 100px;
}
#findPwdFrm {
margin: 0 auto;
	width : 500px;
}
</style>
</head>
<body>
<div id="section">
	<div id="password">
		<form id="findPwdFrm" action="/moviefactory/member/findPassword" method="post">
			<legend style="font-size: 25pt"><strong>비밀번호 찾기</strong></legend>
			<div class="form-group">
				<label for="findPwd_id">아이디</label>
				<input id="username" type="text" name="username" class="form-control" placeholder="아이디 입력">
				<span class="helper-text" id="findPwd_id_helper"></span>
			</div>
			<div class="form-group">
				<label for="findPwd_email">이메일</label>
				<input id="email" type="text" name="email" class="form-control" placeholder="이메일 입력">
				<span class="helper-text" id="findPwd_email_helper"></span>
			</div>
			<div class="form-group">
				<label for="findPwd_name">이름</label>
				<input id="name" type="text" name="name" class="form-control" placeholder="이름 입력">
				<span class="helper-text" id="findPwd_name_helper"></span>
			</div>
			<button type="button" class="btn btn-success" id="find">확인</button><br>
			<a href="login">돌아가기</a>
		</form>
	</div>	
	</div>
</body>
</html>