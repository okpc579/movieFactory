<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#paging { text-align: center; }
</style>
<script>
var movies;
var posterString;
var totCnt;
var page;
var query;
function printList() {
	// 테이블의 <tbody>를 선택한다
	var $body = $("#list");
	$.each(movies, function(i, movie) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movie.movieCd).appendTo($tr);
		$("<td>").text(movie.movieNm).appendTo($tr);
		$("<td>").text(movie.prdtYear).appendTo($tr);
		$("<td>").text(movie.repGenreNm).appendTo($tr);
		$("<td>").text(movie.repNationNm).appendTo($tr);
		var $td = $("<td>").appendTo($tr)
		
		getPoster(movie, $tr);
		$("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("링크열기").appendTo($td);
		
	});
}
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


function printPaging(result) {
	var pageno = page;
	var pagesize = 10;
	var totalcount = totCnt;
	var pagesPerBlock = 10;
	var cntOfPage = totalcount/pagesize + 1;
	if(totalcount%pagesize==0) cntOfPage--;
	var blockNo = Math.floor((pageno-1)/pagesPerBlock);
	var startPage = blockNo * pagesPerBlock + 1;
	var endPage = startPage + pagesPerBlock - 1;
	if(endPage>cntOfPage)
		endPage = cntOfPage;
	
	var $pagination = $("#pagination");	
	var serverUrl = "http://localhost:8081/moviefactory/movie/list?query="+ query+"&pageno="
	if(blockNo>0) {
		var $li = $("<li>").attr("class","previous").appendTo($pagination);
		$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);
	}
	for(var i=startPage; i<=endPage; i++) {
		if(pageno==i) {
			var $li = $("<li>").attr("class","active").appendTo($pagination);
			$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
		} else {
			var $li = $("<li>").appendTo($pagination);
			$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
		}
	}
	if(endPage<cntOfPage) {
		var $li = $("<li>").attr("class","next").appendTo($pagination);
		$("<a>").attr("href", serverUrl + (endPage+1)).text(">").appendTo($li);
	}
	
	
}


$(function() {
	console.log(location.search.split('='));
	var tmpStringArray = location.search.split('=');
	query = location.search.substr(location.search.indexOf("=") + 1);
	
	page = tmpStringArray[2];
	var strArray = query.split('&');
	query = strArray[0];
	console.log(query);
	console.log(page);
	
	$.ajax({
		url:"/moviefactory/api/list?query="+query+"&page="+page,
		method: "get",
		success:function(result) {
			totCnt = result[0].totCnt;
			result.shift();
			console.log(totCnt);
			console.log(result);
			movies = result;
			printList();
			printPaging();
			
		}, error:function(xhr) {
			
		}
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
	<div id="main">
		<!-- <table class="table table-hover"> -->
		<table class="MovieTable">
			<colgroup>
				<col width="20%">
				<col width="20%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th>영화코드</th>
					<th>제목</th>
					<th>제작년도</th>
					<th>장르</th>
					<th>제작국가</th>
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
</body>
</html>