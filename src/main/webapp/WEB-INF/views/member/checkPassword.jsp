<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!--  
<sec:authorize access="hasRole('ROLE_USER')">
	<script src="/moviefactory/script/wsocket.js"></script>
</sec:authorize>
 -->
<script>
$(function() {
	$("#check").on("click", function() {
		$.ajax({
			url: "/moviefactory/api/member/checkpassword",
			method: "get",
			data:"password=" + $("#pwd").val(),
			success: function(result) {
				alert("fire");
				location.href = "/moviefactory/member/user";
			}, error: function(result) {
				alert(result);
				location.reload();
			}
		});
	});
	
});
</script>
</head>
<body>
	<p class="flow-text">비밀번호 확인</p>
	<form>
		<div class="form-group">
			<input type="password" id="pwd" class="form-control">
		</div>
		<button type="button" class="btn btn-success" id="check">확인</button>
	</form>
</body>
</html>