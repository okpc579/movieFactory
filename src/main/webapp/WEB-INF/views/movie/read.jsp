<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">

	<sec:authentication property="principal.username" var="member" />
	<script>
		isLogin = true;
		loginId = '${member}';
	</script>
</sec:authorize>
<script>
	var movie;
	var mno = ${mno}
	var genre="";
	var actor="";
	var cast="";

	function printList() {
		var $body = $("#read");
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movie.movieCd).appendTo($tr);
		$("<td>").text(movie.movieNm).appendTo($tr);
		$("<td>").text(movie.prdtYear).appendTo($tr);
		$("<td>").text(movie.openDt).appendTo($tr);
		$("<td>").text(movie.nationNm).appendTo($tr);
		
		//포문
		$.each(movie.genres, function(i, g) {
			genre = genre +", " + g;
		})
		$("<td>").text(genre).appendTo($tr);
		$("<td>").text(movie.directors).appendTo($tr);
		/*
		$.each(movie.actors, function(i, a) {
			actor = actor +", " + a;
		})
		*/
		for(var i=0;i<=9;i++){
			actor = actor +"," + movie.actors[i];
		}
		$("<td>").text(actor).appendTo($tr);
		$("<td>").text(movie.watchGradeNm).appendTo($tr);
		/*
		$.each(movie.cast, function(i, c) {
			cast = cast +", " + c;
		})
		*/
		for(var i=0;i<=9;i++){
			cast = cast +"," + movie.cast[i];
		}
		$("<td>").text(cast).appendTo($tr);
		
		var $td = $("<td>").appendTo($tr)
		getPoster(movie, $tr);
	}
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

	$(function() { 
		$.ajax({
			url:"/moviefactory/api/read?mno=" + mno,	//디테일 리드
			method: "get",
			success:function(result) {
				
				console.log(result);
				movie = result;
				printList();
			}, error:function(xhr) {
				
			}
		});
		//로그인되있을때 해야됨
		$.ajax({
			url:"/moviefactory/api/movie/review/myreview?mno=" + mno,	//디테일 리드
			method: "get",
			success:function(result) {
				console.log(result);
				if(result==""){
					$("<button>").attr("id","revWrite").text("리뷰 작성").appendTo($("#review"));
				}else{
					$("<a>").attr("id","updateWrite").attr("href","/moviefactory/movie/review/read?mrevNo=" + result.mrevNo).text("리뷰수정").appendTo("#review");
					console.log(result.mrevNo);
				}
				$("#revWrite").on("click", function() {
					if(isLogin==true){
						console.log(mno);
					location.href="/moviefactory/movie/review/write?mno="+mno;
					}
					else{
						location.href="/moviefactory/member/login"
					}
				});
			}, error:function(xhr) {
				
			}
		});
		
		
		$("#revWrite").on("click", function() {
			if(isLogin==true){
				console.log(movie);
			location.href="/moviefactory/movie/review/write?mno="+movie.movieCd;
			}
			else{
				location.href="/moviefactory/member/login"
			}
		});
		
		$("#bttn").on("click", function() {
			location.href="/moviefactory/movie/review/list?mno="+movie.movieCd;
		});
		
	});
</script>
<style>
	table {
		 text-align: center;
	}
</style>
</head>
<body>
<form action="/moviefactory/movie/review/write" method="get">
<div id="main">
		<!-- <table class="table table-hover"> -->
		<table class="MovieTable">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="5%">
				<col width="5%">
				<col width="5%">
				<col width="5%">
				<col width="10%">
				<col width="5%">
				<col width="5%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>영화코드</th>
					<th>제목</th>
					<th>영문제목</th>
					<th>상영시간</th>
					<th>제작년도</th>
					<th>개봉년도</th>
					<th>제작국가</th>
					<th>장르</th>
					<th>감독</th>
					<th>배우</th>
					<th>관람가</th>
					<th>배역</th>
					<th>포스터</th>
				</tr>
			</thead>
			<tbody id="read">
			</tbody>
		</table>
		<div id="review">
		<button id="bttn" type="button">리뷰 목록</button>
		</div>
		<div id="readRev">
		</div>
	</div>
</form>
</body>
</html>
