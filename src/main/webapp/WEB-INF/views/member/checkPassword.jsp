<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script>
$(function() {
	
	$("#check").on("click", function() {
		pwdcheck();
	});
	
	
	$("#pwd").keydown(function(key) {
		if(key.keyCode==13) {
			key.preventDefault();
			pwdcheck();
		}
	});
	
});
function pwdcheck() {
	$.ajax({
		url: "/moviefactory/api/member/checkpassword",
		method: "get",
		data:"password=" + $("#pwd").val(),
		success: function(result) {
			alert("비밀번호 확인이 되었습니다. 내 정보로 이동합니다.");
			location.href = "/moviefactory/member/userinfo";
		}, error: function(result) {
			alert("비밀번호를 다시 확인해주시기 바랍니다.");
			location.reload();
		}
	});
	
}
</script>
<style>
#check {

	height: 50px;
	line-height: 50px;
	width: 100px;
}

#p1 {
	font-size: 25pt;
	
}
</style>
</head>
<body>
<div id="section">
<div class="form-group">
	<p class="text-center" id="p1">♥ 비밀번호 확인 ♥</p>
	</div>
	<form>
		<div class="form-group">
			<input hidden="hidden" />
			<input type="password" id="pwd" class="form-control">
		</div>
		<button type="button" class="btn btn-success" id="check">확인</button>
	</form>
</div>
</body>

</html>