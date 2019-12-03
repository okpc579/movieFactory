<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">

	<sec:authentication property="principal.username" var="member" />
	<script>
		isLogin = true;
		loginId = '${member}';
	</script>
</sec:authorize>
<script>
$(function(){
		
		$("#report").on("click",function(){
			$("#mRevCmntNo").val(location.search.split('=')[1])
			var param = $("#writeForm").serialize();
			console.log($("#title").val());
			console.log(param);
			console.log($("#mRevNo").val());
			$.ajax({
				url: "/moviefactory/api/movie/cmntreport",
				method: "post",
				data: param,
				success : function(result) {
					console.log(result);
					location.href="/moviefactory"
				}, error: function(xhr) {
					console.log(xhr.status);
				}
			});
	})
});
</script>
<style>
	
	table{
		border: 1px solid #444444;
		border-collapse: collapse;
		width:700px;
		height:400px;
		text-align: center;
		margin:0;
		padding: 10px;
	}
	td{
		border: 1px solid #444444;
	}
	#singo{
		text-align: center;
	}
</style>
</head>
<body>
	<form id="writeForm" action="">
		<div>
			<table>
				<tr>
					<td>문의 종류</td>
					<input type="hidden" name="mRevCmntNo" id="mRevCmntNo" value="">
					<td><input type="radio" name="mRepCate" value="욕설">욕설</td>
					<td><input type="radio" name="mRepCate" value="광고">광고</td>
					<td><input type="radio" name="mRepCate" value="불건">불건</td>
					<td><input type="radio" name="mRepCate" value="의도적 스포">의도적 스포</td>
					<td><input type="radio" name="mRepCate" value="도배">도배</td>
					<td><input type="radio" name="mRepCate" value="기타">기타</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="6"><input id="title" type="text" name="title"  placeholder="제목을 입력하세요" style="width: 543px; "></td>
				</tr>
				<tr>
					<td "style="height: 300px; ">내용</td>
					<td style="height: 250px; " colspan="6"><textarea id="content" name="content" placeholder="내용을 입력하세요" style="width: 543px; height: 231px; "></textarea>
				</tr>
				<tr>
					<td colspan="7" id="report" style="height:50px;"><button type="button" >신고하기</button></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>