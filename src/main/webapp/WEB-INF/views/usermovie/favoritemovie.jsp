<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>좋아하는 영화 목록</title>
<style>
 #favorite_list {
 	width: 1000px; display: inline-block;
 }
</style>
<script>

// 1. jsp에 어떤 목록을 보여줄지 선택과 생성 
var favorites;
var username;
	function printList() {
	// 1. 테이블의 <tbody> 선택		
	var $body = $("#list");
	$.each(favorites, function(i, favorite) {
		console.log("반복문진입");
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(favorite.mno).appendTo($tr);	// 영화코드
		var $td = $("<td>").appendTo($tr)
		//getPoster(movie, $tr);							// 포스터
	});
}
	
// 2. 포스터 가져오기
	function getPoster(movie, $tr) {
		console.log(movie);
		$.ajax({
			url:"/moviefactory/api/image?subtitle=" + movie.movieNm + "&pubData=" + movie.prdtYear,
			method: "get",
			success:function(result) {
				console.log(result.image);
				//posterString = result.image;
				if(typeof result.image == "undefined" || result.image==""){
					var $td = $("<td>").appendTo($tr)
					$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png")
					.attr("width", "110px").appendTo($td); 
				} else {
				var $td = $("<td>").appendTo($tr)
				$("<img>").attr("src",result.image).appendTo($td);
				//$("<td>").text(result.image).appendTo($tr);
				}
				
				}, error:function(xhr) {
					console.log(xhr);
					}
		});
	};
	
// 3. 유저이름으로 영화 불러오기
	var strArray;
	$(function() {
	   console.log(location.search.split('&'));
	   strArray = location.search.split('&');
	   console.log(strArray[0].split('=')[1]);
	   username=strArray[0].split('=')[1];
	      $.ajax({
	         url: "/moviefactory/api/usermovie/favoritemovie?username=" + username,
	         method: "get",
	         success: function(result) {
	            console.log(result);
	            favorites = result;
	            printList();
	         }
	      });  
	      $.ajax({
		         url: "/moviefactory/api/usermovie/findnickname?username=" + username,
		         method: "get",
		         success: function(result) {
		            console.log(result);
		            $("#usermovie").text(result+"님이 리뷰한 영화목록");
		         }
		      });
	   
	});
</script>
</head>
<body>
<div id="section">
	<div id="collection_menu">
		<h2 id="usermovie"></h2>
		<hr>
		<table class="favorite_table">
			<colgroup>
				<col width="20%">
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>영화aaaaaaaaaaaaaaaaa코드</th>
					<th>영화 제목</th>
					<th>포스터</th>
					<th>장르</th>
					<th>개봉년도</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
	</div>
	<div id="paging">
		<ul class="pagination" id="pagination">
			<!-- 
			<li class="previous"><a href="#"><</a></li>
			<li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li class="next"><a href="#">></a></li>
			 -->
		</ul>
	</div>
	</div>
</body>
</html>