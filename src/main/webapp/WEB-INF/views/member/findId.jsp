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
<title>Insert title here</title>
<script>
$(function(){
	$("#find").on("click",function(){
		$.ajax({
			url:"/moviefactory/api/member/username",
			method:'get',
			data: $("#findIdFrm").serialize(),
			success:function(result) {
				alert("아이디는 "+result+"입니다.");
				location.href="/moviefactory/member/login";
			},error:function(xhr){
				console.log(xhr.responseText);
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
<style>
#find {
	height: 50px;
	/* line-height: 50px; */
	width: 100px;
}
#findIdFrm {
margin: 0 auto;
	width : 500px;
}
</style>
</head>
<body>
<div id="section">
	<div id="id">
		<form id="findIdFrm" action="/moviefactory/member/findId" method="post">
			<legend style="font-size: 25pt"><strong>아이디 찾기</strong></legend>
			<div class="form-group">
				<label for="findId_name">이름</label>
				<input id="name" type="text" name="name" class="form-control" placeholder="이름 입력">
				<span class="helper-text" id="find_name_helpler"></span>
			</div>
			<div class="form-group">
				<label for="findId_email">이메일</label>
				<input id="email" type="text" name="email" class="form-control" placeholder="이메일 입력">
				<span class="helper-text" id="findId_email_helper"></span>
			</div>
			<button class="btn btn-success" id="find" type="button">확인</button><br>
			<a href="login">돌아가기</a>
		</form>
	</div>
	</div>
</body>
</html>