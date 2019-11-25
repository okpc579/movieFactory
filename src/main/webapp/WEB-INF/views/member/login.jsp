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
</head>
<body>
     <!--   <div id="wrap">
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
   </div> -->
   <div class="alert alert-success alert-dismissible" id="msg" style="display:none;">
       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
       <strong>서버 메시지 </strong><span id="alert"></span>
     </div>
   <div id="login">
      <form id="loginFrm" action="/moviefactory/member/login" method="post">
         <div class="form-group">
            <label for="login_username">아이디</label>
            <input id="login_username" type="text" name="username" class="form-control">
            <span class="helper-text" id="login_username_helpler"></span>
         </div>
         <div class="form-group">
            <label for="login_pwd">비밀번호</label>
            <input id="login_pwd" type="password" name="password" class="form-control">
            <span class="helper-text" id="login_pwd_helper"></span>
         </div>
         <button class="btn btn-success" id="login">로그인</button>
      </form>
   </div>
</body>
</html>