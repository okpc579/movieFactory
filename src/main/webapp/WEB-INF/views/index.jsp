<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
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

	<form action="movie/list">
		<label>영화정보 검색</label>
		<input type="text" id="query" name="query">
		<button id="button">검색</button>
			<sec:authorize access="isAnonymous()">
				<li><a href="/moviefactory/member/findId">아이디 찾기</a></li>
				<li><a href="/moviefactory/member/findPassword">비번 찾기</a></li>
				<li><a href="/moviefactory/member/yesorno">회원가입</a></li>
				<a href="http://localhost:8081/moviefactory/member/login">로그인 하러가기</a>
			</sec:authorize>
			
			<!-- ROLE_USER 권한으로 로그인했을 때 보여줄 메뉴 -->
			<sec:authorize access="hasRole('ROLE_USER')">
	        	<li><a href='/moviefactory/member/userinfo'>내 정보</a></li>
				<sec:authorize access="!hasRole('ROLE_ADMIN')">
          			<li><a id='resign' href='#'>탈퇴</a></li>
          		</sec:authorize>
          	</sec:authorize>
	</form>
	<br>
	<div class="alert alert-success alert-dismissible" id="alert" style="display:none;">
    	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    	<strong>서버 메시지</strong>&nbsp;&nbsp;&nbsp;<span id="msg"></span>
  	</div>
</body>
</html>