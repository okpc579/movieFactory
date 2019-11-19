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
<style>
	a {
		color: black;
		text-decoration: none;   
	}
        
</style>
</head>
<body>
	    <div id="wrap">
		<form action="/moviefactory/member/login" method="post" name="loginInfo">
			<fieldset>
				<legend>로그인</legend>
				<label>아이디 </label>
				<input type="text" name="username" placeholder="아이디 입력"><br>
				<label>비밀번호</label>
				<input type="password" name="password" placeholder="비밀번호 입력"><br>
				<button type="button" id="login">로그인</button><br>
				<a class="join" href="http://localhost:8081/moviefactory/member/join">회원가입</a>
                <a class="findId" href="http://localhost:8081/moviefactory/member/findId">아이디</a>/
                <a class="findPwd" href="http://localhost:8081/moviefactory/member/findPwd">비밀번호 찾기</a>
			</fieldset>
		</form>
	</div>
</body>
</html>