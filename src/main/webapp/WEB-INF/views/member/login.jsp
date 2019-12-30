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
<script type="text/javascript">
var isCaptcha;
var imageDiv;
var msg;
function login(){
	var formData = $("#loginFrm").serialize();
	console.log(formData);
		if(isCaptcha=="true"){ // isCaptcha가 true면 로그인에 실패한경우임
			console.log(isCaptcha);
			$.ajax({
				url : "/moviefactory/api/captcha/image",
				data : formData,
				dataType:"json",
				success : function(data) {
					console.log(data.result);
					// 캡차 해서 결과가 false이면 로그인 불가
					if (data.result==false){ 
						console.log(data.result);
						//btn.disabeld = true;
						console.log("fuckU");
						$.ajax({
							url : "/moviefactory/api/captcha/key",
							dataType:"json",
							success : function(data) {
								console.log(data.key);	// 캡차키값 출력
								key = data.key;
								$("#key").val(data.key);
								$("#div01").html("<img src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key="+key+"'>");
							}, error: function(result){
								console.log(result);
							}
						});
					}else if(data.result==true){
						$("#loginFrm").submit();
					}
				},error : function(result) {
					console.log(result);
					console.log("실패입니더");
				}
			});		
		} else{
			$("#loginFrm").submit();
		}
}


$(function() {
	isCaptcha ="${isCaptcha}";
	imageDiv = $("#image_captcha");
	msg="${msg}";
	if(msg!="") {
		$("#alert").text(msg);
		$("#msg").show();
	}
	console.log(msg);
	if(isCaptcha==""){ // isCaptcha가 ""이면 캡차 화면 안 띄움
		console.log(isCaptcha);	
		imageDiv.css("display","none");
	} else if(isCaptcha=="true"){ // isCaptcha가 true면 로그인에 실패한경우임
		console.log(isCaptcha);
		imageDiv.css("display","block");
	}
});

$(function() {
var key;
var value;
	$("#login_username").keydown(function(key) {
		if(key.keyCode==13) {
			key.preventDefault();
			login();
		}
	});
	$("#login_pwd").keydown(function(key) {
		if(key.keyCode==13) {
			key.preventDefault();
			login();
		}
	});


	$.ajax({
		url : "/moviefactory/api/captcha/key",
		dataType:"json",
		success : function(data) {
			console.log(data.key);	// 캡차키값 출력
			key = data.key;
			$("#key").val(data.key);
			$("#div01").html("<img src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key="+key+"'>");
		}, error: function(result){
			console.log(result);
		}
	});
	
	
	$("#login").on("click",function(){
		login();
	});
 	$("#f5").on("click", function(){
		$.ajax({
			url : "/moviefactory/api/captcha/key",
			dataType:"json",
			success : function(data) {
				console.log(data.key);	// 캡차키값 출력
				key = data.key;
				$("#key").val(data.key);
				$("#div01").html("<img src='https://openapi.naver.com/v1/captcha/ncaptcha.bin?key="+key+"'>");
			}, error: function(result){
				console.log(result);
			}
		});
	})
});
</script>
<style>
#login {
	height: 50px;
	width: 100px;
}
#loginFrm, #msg  {
margin: 0 auto;
	width : 500px;
}

</style>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
		location.href="/moviefactory/system/e403";
	</script>
</sec:authorize>
<title>Insert title here</title>
</head>
<body>
<div id="section">
	<div class="alert alert-success alert-dismissible" id="msg" style="display:none;">
    	<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    	<strong>메시지 </strong><span id="alert"></span>
  	</div>
	<div id="wrap">
		<form id="loginFrm" action="/moviefactory/member/login" method="post">
			<legend style="font-size: 25pt"><strong>로그인</strong></legend>
			<div class="form-group">
				<label for="login_username">아이디</label>
				<input id="login_username" type="text" name="username" class="form-control" placeholder="아이디 입력">
				<span class="helper-text" id="login_username_helpler"></span>
			</div>
			<div class="form-group">
				<label for="login_pwd">비밀번호</label>
				<input id="login_pwd" type="password" name="password" class="form-control" placeholder="비밀번호 입력">
				<span class="helper-text" id="login_pwd_helper"></span>
			</div>
			<div class="captcha_box" id="image_captcha" >
				<p class="captcha_txt" id="captcha_info">아래 이미지를 보이는 대로 입력해주세요.</p>
				<div id="div01">
				</div>
				<input type="hidden" id="key" name="key">
				<input type="text" id="value" name="value">
				<span class="helper-text" id="login_captcha_helper"></span>
				<button id="f5" type="button">새로고침</button>
			</div>
			<br>
			<button class="btn btn-success" id="login" type="button">로그인</button><br>
			<a class="joinsoon" href="/moviefactory/member/join">회원가입</a>
			<a class="findId" href="/moviefactory/member/findId">아이디</a>/
            <a class="findPwd" href="/moviefactory/member/findPassword">비밀번호 찾기</a>
		</form>
	</div>
	</div>
</body>
</html>