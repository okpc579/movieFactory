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
  <style>
  	#writeForm {
  		margin: 0 auto;
  		width : 500px;
  	}
  </style>
  <script>
  var collection;


  function printData() {
  	$("#collName").val(collection.collName);
  	$("#collIntro").val(collection.collIntro);
  	$("#collNo").val(collection.collNo);
  	
  	var $movies = $("#movies");
  	$movies.empty();
  	
  	$.each(collection.detail, function(i, detail){
  		var $movie = $("<div>").appendTo($movies);
  		$("<span></span>").text(detail.mno).appendTo($movie);
  	});
  }
  
  
  $(function() {
	  	var coll_no = location.search.substr(location.search.indexOf("=") + 1);
		console.log(coll_no);
		$.ajax({
			url: "/moviefactory/api/collection/read/" + coll_no,
			method: "get",
			success: function(result, status, xhr) {
				console.log(result);
				console.log(result.collection);
				collection=result.collection;
				printData();
			}, error: function(xhr) {
				
			}
		});	
		
		
		
		$("#update").on("click", function() {
			  var param = $("#writeForm").serialize();
				$.ajax({
					url: "/moviefactory/api/collection/update",
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
		

		$("#delete").on("click", function() {
				$.ajax({
					url: "/moviefactory/api/collection/delete?collNo="+coll_no,
					method:"post",
					success:function(result) {
						console.log("성공");
						console.log(result);
						location.href="http://localhost:8081/moviefactory/collection/list";
					}, error : function(xhr) {
						
					}
				});
			});
		
		
  });
  </script>
<title>Insert title here</title>

</head>
<body>
<div id="section">
<form id="writeForm">
	<div class="form-group">
		<input type="hidden" id="collNo" name="collNo">
		<label for="title">제목:</label>
		<input type="text" class="form-control" id="collName" placeholder="제목" name="collName">
    </div>
    <div class="form-group">
		<textarea class="form-control" rows="5" id="collIntro" name="collIntro"></textarea>
	</div>
	<div style="width: 22.7%; float: none; margin: 0 auto">
		<button type="button" class="btn btn-success" id="update">수정</button>
		<button type="button" class="btn btn-success" id="delete">삭제</button>
	</div>
</form>
</div>
</body>
</html>