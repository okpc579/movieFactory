<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function() {
		$("#write").on("click", function() {
			// form을 서버로 전송할 수 있는 urlencoded 형식으로 변환하는 함수가 serialize
			var param = $("#writeForm").serialize();
			$.ajax({
				url:"/moviefactory/api/notice/write",
				data: param,
				method:"post",
				success:function(result, textStatus, request) {
					location.href = "/moviefactory/notice/list"
				}, error:function(xhr) {
					
				}
			});
		});
	});
</script>
</script>
</head>
<body>
	<form id="writeForm">
		제목 : <input type="text" name="title"><br> 내용 :
		<textarea rows="10" cols="20" id="content" name="content"></textarea>
		<br>
		<input type=button id="write" value="작성완료"> 
		<input type=button value="작성취소" OnClick="javascript:history.back(-1)">
	</form>
</body>
</html>