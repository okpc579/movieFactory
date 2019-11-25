<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				location.href="/moviefactory/member/id";
			},error:function(xhr){
				alert(xhr.responseText)
			}
		})	
	});
});
</script>
</head>
<body>
	<div>
		<form id="findIdFrm">
			<fieldset>
                <legend>아이디 찾기</legend>
                <label>이름</label>
                <input type="text" name="name" placeholder="이름 입력"><br>
                <label>이메일</label>
                <input type="text" name="email" placeholder="이메일 입력"> <br>
                <button id="find" type="button">확인</button>
                <a href="http://localhost:8081/moviefactory/member/login">돌아가기</a>
			</fieldset>
        </form>
	</div>
</body>
</html>