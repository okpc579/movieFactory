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
				url:"/moviefactory/api/adminAsk/write",
				data: param,
				method:"post",
				success:function(result, textStatus, request) {
					location.href = "/moviefactory/adminAsk/listuser"
				}, error:function(xhr) {
					location.href = "/moviefactory/adminAsk/write"
				}
			});
		});
	});
</script>
</head>
<body>
<div>
	<h2><a href="http://localhost:8080/moviefactory/adminAsk/listuser">문의 게시판</a></h2>
</div>
<div id="h3">
	<h3 style="margin-bottom: 0px;">필수 사항작성</h3>
</div>
<div id="section">
	<form id="writeForm">
		<div>
		<p id="p_board"><strong>제목</strong></p>
		<input id="title" type="text" name="title" size="80" placeholder="제목입니다"><br>
		<p>※문의에 관한 제목을 작성해주세요</p>
		</div>
		<div>
		<br><p id="p_board"><strong>내용</strong></p>
		<textarea rows="10" cols="20" id="content" name="content" placeholder="내용입니다"></textarea>
		</div>
		<p>※답변이 완료되면 수정이 불가합니다</p>
		<br>
		<br>
		<input type=button class="btn btn-primary" id="write" value="작성완료"> 
		<input type=button class="btn btn-default" value="작성취소" OnClick="javascript:history.back(-1)">
	</form>
	</div>
</body>
</html>