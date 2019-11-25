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
//서버에서 보내온 데이터를 화면에 출력
$(function(){
	$("#report").on("click",function(){
		var param = $("#writeForm").serialize();
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/report",
			data:param,
			method: "post",
			success: function(result, status, xhr) {
				console.log(result);
				moviereview = result;
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
					<input type="hidden" name="mRevNo" value="2">
					<input type="hidden" name="writingDate" value="2019-11-15">
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
					<td colspan="7" id="report" style="height:50px;"><button >신고하기</button></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>