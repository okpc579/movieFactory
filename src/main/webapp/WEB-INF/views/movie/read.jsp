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
	var mno;
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
		/* for(var i=0;i<=9;i++){
			cast = cast +"," + movie.cast[i];
		}
		$("<td>").text(cast).appendTo($tr);
		 */
		//var $td = $("<td>").appendTo($tr)
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
					$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("width", "90px").appendTo($td); 
				}else {
				var $td = $("<td>").appendTo($tr)
				$("<img>").attr("src",result.image).attr("width", "90px").appendTo($td);
				//$("<td>").text(result.image).appendTo($tr);
				}
				
			}, error:function(xhr) {
				console.log(xhr);
			}
		});
	}

	$(function() { 
		mno = location.search.split("=")[1];
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
		console.log(mno);
		//로그인되있을때 해야됨
		if(isLogin ==true){
			$.ajax({
				url:"/moviefactory/api/movie/review/myreview?mno=" + mno,	//디테일 리드
				method: "get",
				success:function(result) {
					console.log(result);
					if(result==""){
						$("<button type='button'>").attr("id","revWrite").css("height","50px").css("width","100px").attr("class","btn btn-default").text("리뷰 작성").appendTo($("#review"));
					}else{
						$("<button type='button'>").attr("id","updateWrite").css("height","50px").css("width","100px").attr("class","btn btn-default").attr("href","/moviefactory/movie/review/update?mrevNo=" + result.mrevNo).text("리뷰수정").appendTo("#review");
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
					$("#updateWrite").on("click", function() {
						if(isLogin==true){
							console.log(mno);
						location.href="/moviefactory/movie/review/update?mno="+mno;
						}
						else{
							location.href="/moviefactory/member/login"
						}
					});
				}, error:function(xhr) {
			}
		});
		}
		
		
		$("#revWrite").on("click", function() {
			if(isLogin==true){
				console.log(movie);
			console.log(mno);
			//location.href="/moviefactory/movie/review/write?mno="+mno;
			}
			else{
				location.href="/moviefactory/member/login"
			}
		});
		
		$("#bttn").on("click", function() {
			location.href="/moviefactory/movie/review/list?mno="+mno;
		});
		
	});
</script>
<style>
	table {
		 text-align: center;
	}
	th {
		text-align : center;
	}
	MovieTable{
		width : 1200px;
	}
	#bttn {
		height: 50px;
   		width: 100px;
	}
/* 	.code, . {
		width : 10%;
	} */
</style>
</head>
<body>
<div id="fuck">
<form action="/moviefactory/movie/review/write" method="get">
		<!-- <table class="table table-hover"> -->
		<table class="MovieTable">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="11%">
				<col width="8%">
				<col width="11%">
				<col width="10%">
				<col width="5%">
				<col width="10%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th class="code">영화코드</th>
					<th class="title">제목</th>
					<th class="made">제작년도</th>
					<th class="open">개봉년도</th>
					<th class="country">제작국가</th>
					<th class="genre">장르</th>
					<th class="director">감독</th>
					<th class="actor">배우</th>
					<th class="grade">관람가</th>
					<th class="poster">포스터</th>
				</tr> 
			</thead>
			<tbody id="read">
			</tbody>
		</table>
		<div id="review">
		<button id="bttn" class="btn btn-primary" type="button">리뷰 목록</button>
		</div>
		<div id="readRev">
		</div>
	
</form>
</div>
</body>
</html>
