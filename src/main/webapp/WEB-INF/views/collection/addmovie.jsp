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
var movies;
var posterString;
var totCnt;
var page;
var query;
var coll_no;
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
		var $td = $("<td>").appendTo($tr);
		
		getPoster(movie, $tr);
		//$("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("링크열기").appendTo($td);
		$('<button id=button' + i +'> type="button"').text("링크열기").appendTo($td);
		//$('<input id=no' + i +'> type="hidden"').val(movie.movieCd).appendTo($td);
		$("#cdval"+i).val(movie.movieCd);
		console.log($("#cdval" + i).val());
	});
	
	
	$("#button0").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval0").val(),
				collNo:coll_no,
		};
		console.log(mNo);
		console.log(coll_no);
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button1").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval1").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button2").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval2").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button3").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval3").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button4").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval4").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button5").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval5").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button6").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval6").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button7").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval7").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button8").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval8").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	$("#button9").on("click", function() {
		console.log("클릭완료");
		var param = {
				mNo: $("#cdval9").val(),
				collNo:coll_no,
		};
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: param,
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
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
	$("#pagination>*").remove();
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
	console.log("페이징함수 들어옴");
	
	
	
	var pagearr = new Array();
	for(var i=startPage;i<=endPage; i++){
		pagearr[i]=i;
	}
	
	
	
	
	
	
	if(blockNo>0) {
		var $li = $("<li>").attr("class","previous").appendTo($pagination);
		//$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);
		$('<a id="prevbutton">').attr("href", "#").text("<").appendTo($li);
		$("#prevbutton").on("click", function() {
			searchPage(startPage-1);
		});
		
		
		
	}
	for(var i=startPage; i<=endPage; i++) {
		if(pageno==i) {
			var $li = $("<li>").attr("class","active").appendTo($pagination);
			//$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
			$('<a id="page' + (i-startPage) + '">').attr("href", "#").text(i).appendTo($li);
			$('#page'+i).on("click", function() {
				searchPage(pagearr[i]);
			});
		} else {
			var $li = $("<li>").appendTo($pagination);
			//$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
			$('<a id="page' + (i-startPage) + '">').attr("href", "#").text(i).appendTo($li);
			$('#page'+i).on("click", function() {
				searchPage(pagearr[i]);
			});
		}
	}
	if(endPage<cntOfPage) {
		var $li = $("<li>").attr("class","next").appendTo($pagination);
		//$("<a>").attr("href", serverUrl + (endPage+1)).text(">").appendTo($li);
		$('<a id="nextbutton">').attr("href", "#").text(">").appendTo($li);
		$("#nextbutton").on("click", function() {
			searchPage(endPage+1);
		});
	}
	$("#page0").on("click", function() {
		searchPage(pagearr[1]);
	});
	$("#page1").on("click", function() {
		searchPage(pagearr[2]);
	});
	$("#page2").on("click", function() {
		searchPage(pagearr[3]);
	});
	$("#page3").on("click", function() {
		searchPage(pagearr[4]);
	});
	$("#page4").on("click", function() {
		searchPage(pagearr[5]);
	});
	$("#page5").on("click", function() {
		searchPage(pagearr[6]);
	});
	$("#page6").on("click", function() {
		searchPage(pagearr[7]);
	});
	$("#page7").on("click", function() {
		searchPage(pagearr[8]);
	});
	$("#page8").on("click", function() {
		searchPage(pagearr[9]);
	});
	$("#page9").on("click", function() {
		searchPage(pagearr[10]);
	});
	
	
	
}






function search(){
	var tmpStringArray = location.search.split('=');
	query = location.search.substr(location.search.indexOf("=") + 1);
	page = tmpStringArray[2];
	var strArray = query.split('&');
	query = $("#search").val();
	
	var locationURL= "/moviefactory/api/list?query="+query;
	if(typeof page == "undefined"){
		page=1;
	}
	locationURL = locationURL +"&page="+page;
	$.ajax({
		url:locationURL,
		method: "get",
		success:function(result) {
			$("#list>*").remove();
			console.log(result);
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
}



function searchPage(pageno){
	var tmpStringArray = location.search.split('=');
	query = location.search.substr(location.search.indexOf("=") + 1);
	page = tmpStringArray[2];
	var strArray = query.split('&');
	query = $("#search").val();
	
	var locationURL= "/moviefactory/api/list?query="+query;
	if(typeof page == "undefined"){
		page=1;
	}
	page=pageno;
	console.log(page);
	locationURL = locationURL +"&page="+page;
	$.ajax({
		url:locationURL,
		method: "get",
		success:function(result) {
			$("#list>*").remove();
			console.log(result);
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
}












$(function() {
	coll_no = location.search.substr(location.search.indexOf("=") + 1);
	console.log(coll_no);
	history.replaceState({}, null, location.pathname);
	$("#button").on("click", function() {
		$.ajax({
			url: "/moviefactory/api/collection/addmovie",
			method: "post",
			data: $("#addmovieForm").serialize(),
			success: function(result) {
				opener.location.reload();		
			}, error: function(xhr) {
				
			}
		});	
	});
	
	$("#searchbutton").on("click", function() {
		search();
	});
	
	
	
	
	
});
</script>
</head>
<body>
<<<<<<< HEAD
=======
	addmsovie
	<form id="addmovieForm">
		<input type="text" id="search" name="search">
		<button type="button" id="searchbutton">검색</button>
		<br> 
		<input type="text" id="mNo" name="mNo">
		<input type="text" id="collNo" name="collNo">
	<button type="button" id="button">버튼</button>
	</form>
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
	<input id="cdval0" type="hidden">
	<input id="cdval1" type="hidden">
	<input id="cdval2" type="hidden">
	<input id="cdval3" type="hidden">
	<input id="cdval4" type="hidden">
	<input id="cdval5" type="hidden">
	<input id="cdval6" type="hidden">
	<input id="cdval7" type="hidden">
	<input id="cdval8" type="hidden">
	<input id="cdval9" type="hidden">
	
	
>>>>>>> 20191126_남동윤
	
</body>
</html>