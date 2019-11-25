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
var collection;


function printData() {
	$("#writer").text(collection.username);
	$("#title").text(collection.collName);
	
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
		location.href="http://localhost:8081/moviefactory/collection/update?collno=" + coll_no;
	});
	
});
</script>
</head>
<body>
<div>
	<button id="update">수정버튼</button>
	<div>
		<span>글쓴놈 : </span><span id="writer"></span>
	</div>
	<div>
		<span>제목 : </span><span id="title"></span>
	</div>
	<div id="movies">
	</div>
</div>
</body>
</html>