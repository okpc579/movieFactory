<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
var collection;
var coll_no;


function printData() {
	$("#writer").text(collection.username);
	$("#title").text(collection.collName);
	
	var $movies = $("#movies");
	$movies.empty();
	
	$.each(collection.detail, function(i, detail){
		var $movie = $("<div>").appendTo($movies);
		$("<span></span>").text(detail.mno).appendTo($movie);
		$("<input type='hidden' id='hiddenval" + i +"'>").val(detail.mno).appendTo($movie);
		$("<button type='button' id='delete" + i +"'>").val(detail.mno).text('x').appendTo($movie);
	});
	
	$("#delete0").on("click", function() {
		deletemovie($("#delete0").val());
	});
}

function deletemovie(mno){
	console.log(mno);
	var param = {
			mNo:mno,
			collNo:coll_no,
	}
	$.ajax({
		url: "/moviefactory/api/collection/deletemovie",
		method: "post",
		data: param,
		success: function(result, status, xhr) {
			location.reload();
		}, error: function(xhr) {
			
		}
	});
}
$(function() {
	coll_no = location.search.substr(location.search.indexOf("=") + 1);
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
	
<<<<<<< HEAD
=======
	
	
	
	
	
	
>>>>>>> 20191126_남동윤
	$("#update").on("click", function() {
		location.href="http://localhost:8081/moviefactory/collection/update?collno=" + coll_no;
	});
	
	$("#popup").on("click", function() {
		window.open('/moviefactory/collection/addmovie?coll_no='+coll_no,'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');	
	});
	
});
</script>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
	$(function() {
		$.ajax({
			url: "/moviefactory/api/collection/checklike?collNo=" + coll_no,
			method: "get",
			success: function(result, status, xhr) {
				console.log(result);
				if(result=="true"){
					$("<button type='button' id='cancellike'>").text('좋아요취소').appendTo($("#doyoulike"));
					$("#cancellike").on("click", function() {
						var param = {
								collNo:coll_no,
						}
						$.ajax({
							url: "/moviefactory/api/collection/cancellike",
							method: "post",
							data: param,
							success: function(result, status, xhr) {
								location.reload();
							}, error: function(xhr) {
								
							}
						});
					});
					
				}else if(result=="false"){
					$("<button type='button' id='like'>").text('좋아요').appendTo($("#doyoulike"));
					$("#like").on("click", function() {
						var param = {
								collNo:coll_no,
						}
						$.ajax({
							url: "/moviefactory/api/collection/like",
							method: "post",
							data: param,
							success: function(result, status, xhr) {
								location.reload();
							}, error: function(xhr) {
								
							}
						});
					});
				}
			}, error: function(xhr) {
				
			}
		});
		
		
	});
	</script>
</sec:authorize>
</head>
<body>
<div>
	<button id="update">수정버튼</button>
	<div id="doyoulike"></div>
	<div>
		<span>글쓴놈 : </span><span id="writer"></span>
	</div>
	<div>
		<span>제목 : </span><span id="title"></span>
	</div>
	<div id="movies">
	</div>
	<button type="button" id="popup">팝업버튼</button>
	<span id="testspan">111</span>
</div>
</body>
</html>