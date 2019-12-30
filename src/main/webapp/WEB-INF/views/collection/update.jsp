<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  	
  	#update, #delete {
  		width: 100px;
  		height: 50px;
  	}
  </style>
  <script>
  var strArray;
  var collection;
  var page;
  var username;

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
		
		var param = {
				collNo : coll_no
		}
		$.ajax({
			url: "/moviefactory/api/collection/checkmycollection",
			method:"get",
			data: param,
			success:function(result) {
				console.log(result);
				if(result=="false"){
					location.href="/moviefactory/collection/read?collNo="+coll_no+"&pageno=1";
				}
				//location.href="/moviefactory/collection/read?collNo="+result+"&pageno=1";
			}, error : function(xhr) {
				location.href="/moviefactory/collection/read?collNo="+coll_no+"&pageno=1";
			}
		});
		
		
		
		$.ajax({
			url: "/moviefactory/api/collection/read/" + coll_no,
			method: "get",
			success: function(result, status, xhr) {
				console.log(result);
				console.log(result.collection);
				collection=result;
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
						location.href="/moviefactory/collection/read?collNo="+result;
					}, error : function(xhr) {
						
					}
				});
				
				opener.document.location.reload();
				
			});
		

		$("#delete").on("click", function() {
			console.log(username);
				$.ajax({
					url: "/moviefactory/api/collection/delete?collNo="+coll_no,
					method:"post",
					data:username,
					success:function(result) {
						console.log(result);
						$.ajax({
							url:"/moviefactory/api/collection/username",
							method:"get",
							success:function(str){
								console.log(str);
								opener.parent.location.href="/moviefactory/collection/list?username=" + str + "&pageno=1";
								window.close();
							}
						
						})
						
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
		<textarea class="form-control" rows="5" id="collIntro" name="collIntro" placeholder="컬렉션을 소개해주세요"></textarea>
	</div>
	<div class="text-center" style="width: 100%">
		<button type="button" class="btn btn-primary" id="update" onclick="window.close()">수정</button>
		<button type="button" class="btn btn-default" id="delete">삭제</button>
	</div>
</form>
</div>
</body>
</html>