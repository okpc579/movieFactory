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
<title>리뷰한 영화 목록</title>
<style>
 #collection_list {
 	width: 1000px; display: inline-block;
 }
</style>
<script>	

// 1. jsp에 어떤 목록을 보여줄지 선택과 생성 
var reviews;
var username;
function printList() {
	// 테이블의 <tbody>를 선택한다
	var $body = $("#list");
	$.each(reviews, function(i, review) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(review.mrevContent).appendTo($tr);
		$("<td>").text(review.rating).appendTo($tr);
		//$("<td>").text(review.movieNm).appendTo($tr);
		// 별점, 포스터
		var $td = $("<td>").appendTo($tr)
		
		//getPoster(review, $tr);
		
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
				if(typeof result.image == "undefined"){
					var $td = $("<td>").appendTo($tr)
					$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("width", "110px").appendTo($td); 
				}else {
				var $td = $("<td>").appendTo($tr)
				$("<img>").attr("src",result.image).appendTo($td);
				//$("<td>").text(result.image).appendTo($tr);
				}
				
			}, error:function(xhr) {
				console.log(xhr);
			}
		});
	}
// 3. 유저이름으로 영화 불러오기
	var strArray;
	$(function() {
		   console.log(location.search.split('=')[1]);
		   //strArray = location.search.split('?');
		   //console.log(strArray[1].split('=')[0]);
		  	username= location.search.split('=')[1];
			   
		      $.ajax({
		         url: "/moviefactory/api/usermovie/findnickname?username=" + username,
		         method: "get",
		         success: function(result) {
		            console.log(result);
		            $("#usermovie").text(result+"님이 리뷰한 영화목록");
		         }
		      });
		      $.ajax({
			         url: "/moviefactory/api/usermovie/review?username=" + username,
			         method: "get",
			         success: function(result) {
			            console.log(result);
			            reviews=result;
			            printList();
			         }
			  });
		      
		      /*
		      $("#review").on("click",function(){
		    	  location.href="/moviefactory/usermovie/review?username="+username;
		      });
		      */
		});
	
</script>
</head>
<body>
<div id="section">
	<div id="review_list">
		<h2 id="usermovie"></h2>
		<hr>
		<table class="review_table">
				<colgroup>
				<col width="30%">
				<col width="20%">
				<col width="50%">
			</colgroup>
			<thead>
				<tr>
					<th>제목</th>
					<th>별점</th>
					<th>포스터</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
	</div>
</div>	
</body>
</html>