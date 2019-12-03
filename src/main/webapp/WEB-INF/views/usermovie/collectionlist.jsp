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
<title>컬렉션 영화 목록</title>
<style>
 #collection_list {
 	width: 1000px; display: inline-block;
 }
</style>
<script>

// 1. jsp에 어떤 목록을 보여줄지 선택과 생성 
var movie;
	function printList() {
	// 1. 테이블의 <tbody> 선택		
	var $body = $("#list");
	$.each(movie, function(i, movie) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movie.movieCd).appendTo($tr);
		$("<td>").text(movie.movieNm).appendTo($tr);
		$("<td>").text(movie.prdt).appendTo($tr);
		var $td = $("<td>").appendTo($tr)
		getPoster(movie, $tr);
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
	$(function() { 
		$.ajax({
			url:"/moviefactory/api/collection/mylist",	//디테일 리드
			method: "get",
			success:function(result) {
				
				console.log(result);
				movie = result;
				printList();
			}, error:function(xhr) {
				
			}
		});
	});
	
// 3. 유저이름으로 영화 불러오기
	var strArray;
	$(function() {
	   console.log(location.search.split('?'));
	   strArray = location.search.split('?');
	   console.log(strArray[1].split('=')[0]);
	   if(strArray[1].split('=')[0]=='mno'){
	      $.ajax({
	         url: "/moviefactory/api/collection/list?mNo=" + strArray[1].split('=')[1],
	         method: "get",
	         success: function(result) {
	            console.log(result);
	         }
	      });   
	   }else if(strArray[1].split('=')[0]=='username'){
	      $.ajax({
	         url: "/moviefactory/api/collection/userlist?username=" + strArray[1].split('=')[1],
	         method: "get",
	         success: function(result) {
	            console.log(result);
	         }
	      });   
	   }
	});
</script>
</head>
<body>
<div id="section">
	<div id="collection_list">
		<h2>000님의 컬렉션 영화목록</h2>
		<hr>
		<table class="collection_table">
			<colgroup>
				<col width="28%">
				<col width="28%">
				<col width="44%">
			</colgroup>
			<thead>
				<tr>
					<th>컬렉션명</th>
					<th>설명</th>
					<th>포스터</th>
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