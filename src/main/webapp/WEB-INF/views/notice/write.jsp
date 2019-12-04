<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#section{
	border: 1px solid Gray;
	padding: 30px;
}
#title{
 border: 2px solid #ccc;
 border-radius: 4px;
 background-color: #f8f8f8;
 padding: 7px 10px;
 font-size: 16px;
 resize: none;
}
textarea {
  width: 100%;
  height: 150px;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 2px solid #ccc;
  border-radius: 4px;
  background-color: #f8f8f8;
  font-size: 16px;
  resize: none;
}

#p_board {
	font-size : 20px;
}
#h3{
	background-color: #4ABFD3;
	height: 60px;
	color: #FFFFFF;
	padding-left: 30px;
}
#h3 h3{
	line-height: 60px;
}
</style>
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
					location.href = "/moviefactory/notice/write"
				}
			});
		});
	});
</script>
</head>
<body>
<div>
	<h2><a href="http://localhost:8080/moviefactory/adminAsk/listuser">공지사항 게시판</a></h2>
</div>
<div id="h3">
	<h3 style="margin-bottom: 0px;">공지사항 작성</h3>
</div>
<div id="section">
	<form id="writeForm">
		<strong>제목 :</strong>
		<input type="text" name="title" id="title" size="80"><br><br>
		<p><strong>내용</strong></p>
		<textarea rows="10" cols="20" id="content" name="content"></textarea>
		<br>
		<br>
		<input type=button class="btn btn-primary" id="write" value="작성완료"> 
		<input type=button class="btn btn-default" value="작성취소" OnClick="javascript:history.back(-1)">
	</form>
</div>	
</body>
</html>