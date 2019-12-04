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
  <style>
  	#writeForm {
  		margin: 0 auto;
  		width : 500px;
  	}
  </style>
  <script>
  $(function() {
	  $("#write").on("click", function() {
		  var param = $("#writeForm").serialize();
			$.ajax({
				url: "/moviefactory/api/collection/add",
				method:"post",
				data: param,
				success:function(result) {
					console.log("성공");
					console.log(result);
					location.href="http://localhost:8081/moviefactory/collection/read?collNo="+result;
				}, error : function(xhr) {
					
				}
			});
		});
	});
  </script>
</head>
<body>
<div id="section">
<form id="writeForm">
	<div class="form-group">
		<label for="title">제목:</label>
		<input type="text" class="form-control" id="collName" placeholder="제목" name="collName">
    </div>
    <div class="form-group">
		<textarea class="form-control" rows="5" id="collIntro" name="collIntro"></textarea>
	</div>
	<div style="width: 10%; float: none; margin: 0 auto">
		<button type="button" class="btn btn-success" id="write">작성</button>
	</div>
</form>
</div>
</body>
</html>