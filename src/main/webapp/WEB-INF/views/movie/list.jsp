<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#paging { text-align: center; }
	.what {
		width : 550px;
		height : 220px;
	}
	#title{
		width : 400px;
		height : 220px;
	}
	#poster{
		width : 150px;
		height : 220px;
		text-align: center;
	}
	
</style>
<script>
var movies;
var posterString;
var totCnt;
var page;
var query;
var $a1
var $body;
function printList() {
	// 테이블의 <tbody>를 선택한다
	$body = $("#list_");
	
	$.each(movies, function(i,movie){
		$div = $("<div>").attr("class","what").css('display',"inline-block").appendTo($body);
		var $div2 = $("<div>").attr("id","poster").css('display',"inline-block").appendTo($div);
		$a1 = $("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).appendTo($div2);
		getPoster(movie, $a1);
		var $div3 = $("<div>").attr("id","title").css('display',"inline-block").appendTo($div);
		$a = $("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).appendTo($div3);
		
		//$li = $("<li>").attr("").appendTo($body);
		//$br = $("<br>").appendTo();
		
		$("<li>").text(movie.movieNm).css("width","380px").css("font-size",'17pt').css("white-space","nowrap").css("word-break","break-all").css("text-overflow", "ellipsis").css("overflow", "hidden").appendTo($a);
		$("<li>").text(movie.prdtYear).css("font-size",'13pt').appendTo($div3);
		$("<li>").text(movie.repGenreNm).css("font-size",'13pt').appendTo($div3);
		$("<li>").text(movie.repNationNm).css("font-size",'13pt').appendTo($div3);
		$("<li>").text(movie.directors).css("font-size",'13pt').appendTo($div3);
	});
	/* $.each(movies, function(i, movie) {
	if(i%2==0){
		var $tr = $("<tr>").appendTo($body);
		var $tr2 = $("<tr>").appendTo($body);
		var $tr3 = $("<tr>").appendTo($body);
		var $tr4 = $("<tr>").appendTo($body);
		var $tr5 = $("<tr>").appendTo($body);
	}
		
		var $tr = $("<tr>").appendTo($body);
		$tr1 = $("<tr>").appendTo($body);
		var $tr2 = $("<tr>").appendTo($body);
		var $tr3 = $("<tr>").appendTo($body);
		var $tr4 = $("<tr>").appendTo($body);
		var $tr5 = $("<tr>").appendTo($body);
		var $tr6 = $("<tr>").appendTo($body);
		$("<td>").text(movie.movieCd).css('display',"none").appendTo($tr);
		getPoster(movie, $tr1);
		$("<td>").text(movie.movieNm).appendTo($tr2);
		$("<td>").text(movie.prdtYear).appendTo($tr3);
		$("<td>").text(movie.repGenreNm).appendTo($tr4);
		$("<td>").text(movie.repNationNm).appendTo($tr5);
		$("<td>").text(movie.directors).appendTo($tr6);
		
				
		
		var $tr = $("<tr>").appendTo($body);
		var $td = $("<td>").appendTo($tr)
		
		$("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("링크열기").appendTo($td);
		
	}); */ 
}
function getPoster(movie, $a1) {
	console.log(movie);
	$.ajax({
		url:"/moviefactory/api/image?subtitle=" + movie.movieNm + "&pubData=" + movie.prdtYear,
		method: "get",
		success:function(result) {
			console.log(result);
			console.log(result.image);
			//posterString = result.image;
			if(typeof result.image == "undefined" || result.image==""){
				//var $td = $("<td rowspan='6'>").appendTo($a)
				$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("width", "140px").appendTo($a1); 
			}else {
			//var $td = $("<td rowspan='6'>").appendTo($a)
			$("<img>").attr("src",result.image).attr("width", "140px").appendTo($a1);
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
	var serverUrl = "http://localhost:8081/moviefactory/movie/list?query="+ query+"&pageno=";
	// console.log("페이징함수 들어옴");
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
	
	var locationURL= "/moviefactory/api/list?query="+query;
	if(typeof page == "undefined"){
		page=1;
	}
	locationURL = locationURL +"&page="+page;
	$.ajax({
		url:locationURL,
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
	
</style>
</head>
<body>
	<div id="section">
		<!-- <table class="table table-hover"> -->
		<span id="list_">
		
		</span>
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