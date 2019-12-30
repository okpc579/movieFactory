<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<script>
var moviereviews;
var totCnt;
var page;
var query;
function printLists() {
	console.log(moviereviews);
	var $body = $("#list");
	$.each(moviereviews.reviews, function(i, moviereview) {
		
		var $tr = $("<tr>").appendTo($body);
		
		$("<td nowrap>").text(moviereview.rating).appendTo($tr);
		//$("<td>").text(moviereview.username).appendTo($tr);
		$td = $("<td nowrap>").appendTo($tr);
		$("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + moviereview.username).text(moviereview.username).appendTo($td);
		
		
		if(moviereview.isSpo==1){
			$("<td nowrap>").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<td nowrap>").attr("id","revContent").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		
		var $td = $("<td nowrap>").appendTo($tr)
		console.log(moviereview);
		
	});
}


$(function() {
	
	var mno1 = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	console.log(location.search.split('=')[0]);
	if(location.search.split('=')[0] == ""){
		location.href="/moviefactory";
	}
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list?mno=" + mno1,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists(result);
			console.log(moviereviews);
		}, error: function(xhr) {
			 location.href="/moviefactory/"
			 console.log(xhr.status);
		}
	});
	
	
	
	
	
	function printPage(result) {
		console.log("--------------1-----------------");
		//$("#pagination>*").remove();
		var pageno = result.pageno;
		var pagesize = 10;
		var totalcount = result.totalcount;
		var pagesPerBlock = 10;
		var cntOfPage = totalcount/pagesize + 1;
		if(totalcount%pagesize==0) cntOfPage--;
		var blockNo = Math.floor((pageno-1)/pagesPerBlock);
		var startPage = blockNo * pagesPerBlock + 1;
		var endPage = startPage + pagesPerBlock - 1;
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		var $pagination = $("#pagination");	
		/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
		console.log("페이징함수 들어옴");
		
		
		
		var pagearr = new Array();
		for(var i=startPage;i<=endPage; i++){
			pagearr[i]=i;
		}
		if(blockNo>0) {
			var $li = $("<li>").attr("class","previous").appendTo($pagination);
			$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);		
		}
		for(var i=startPage; i<=endPage; i++) {
			if(pageno==i) {
				var $li = $("<li>").attr("class","active").appendTo($pagination);
				$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
				} 
			else{
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
		toastr.options = {
			"progressBar" : true
		}
		
		// 전체 글을 페이징하면 주소가 ?pageno=11
		// 특정 사용자가 작성한 글을 페이징하면 ?pageno=11&writer=spring11
		// &를 기준으로 문자열을 자른다
		var params = location.search.split('&');
		
		// pageno=11
		console.log(params[0]);
		// 전체 글 페이징 : undefined, 사용자가 작성한 글 페이징: writer=spring11
		console.log(params[1]);
		console.log(location.search.substr(1));
		$.ajax({
			url: "/moviefactory/api/movie/review/list",
			method: "get",
			data : location.search.substr(1),
			success: function(result) {
				if(params[1]!=undefined){
					printPage(result, params[1].substr(7));
				}
				else
					printPage(result);
			}
		});
	});
});
</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_USER')">
<script>
var moviereviews;
var totCnt;
var page;
var query;
function printLists() {
	var $body = $("#list");
	$.each(moviereviews.reviews, function(i, moviereview) {
		
		var $tr = $("<tr>").appendTo($body);
		var $td;
		$("<td nowrap>").text(moviereview.rating).appendTo($tr);
		//$("<td>").text(moviereview.username).appendTo($tr);
		$td = $("<td>").appendTo($tr);
		$("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + moviereview.username).text(moviereview.username).appendTo($td);
		if(moviereview.isSpo==1){
			$("<td nowrap>").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<td nowrap>").attr("id","revContent").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		var $td = $("<td nowrap>").appendTo($tr)
			
		console.log(moviereview);
	});
}
$(function() {
	
	var mno1 = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	if(location.search.split('=')[0] == ""){
		location.href="/moviefactory";
	}
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list?mno=" + mno1,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists();
			console.log(moviereviews);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	
	
	function printPage(result) {
		console.log("--------------1-----------------");
		//$("#pagination>*").remove();
		var pageno = result.pageno;
		var pagesize = 10;
		var totalcount = result.totalcount;
		var pagesPerBlock = 10;
		var cntOfPage = totalcount/pagesize + 1;
		if(totalcount%pagesize==0) cntOfPage--;
		var blockNo = Math.floor((pageno-1)/pagesPerBlock);
		var startPage = blockNo * pagesPerBlock + 1;
		var endPage = startPage + pagesPerBlock - 1;
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		var $pagination = $("#pagination");	
		/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
		console.log("페이징함수 들어옴");
		
		
		
		var pagearr = new Array();
		for(var i=startPage;i<=endPage; i++){
			pagearr[i]=i;
		}
		if(blockNo>0) {
			var $li = $("<li>").attr("class","previous").appendTo($pagination);
			$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);		
		}
		for(var i=startPage; i<=endPage; i++) {
			if(pageno==i) {
				var $li = $("<li>").attr("class","active").appendTo($pagination);
				$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
				} 
			else{
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
		toastr.options = {
			"progressBar" : true
		}
		
		// 전체 글을 페이징하면 주소가 ?pageno=11
		// 특정 사용자가 작성한 글을 페이징하면 ?pageno=11&writer=spring11
		// &를 기준으로 문자열을 자른다
		var params = location.search.split('&');
		
		// pageno=11
		console.log(params[0]);
		// 전체 글 페이징 : undefined, 사용자가 작성한 글 페이징: writer=spring11
		console.log(params[1]);
		console.log(location.search.substr(1));
		$.ajax({
			url: "/moviefactory/api/movie/review/list",
			method: "get",
			data : location.search.substr(1),
			success: function(result) {
				console.log("-------------------------------");
				console.log(result);
				if(params[1]!=undefined)
					printPage(result);
				else
					printPage(result);
			}
		});
	});
});
</script>
</sec:authorize>
<sec:authorize access="isAnonymous()">
<script>
var moviereviews;
var totCnt;
var page;
var query;
function printLists() {
	var $body = $("#list");
	$.each(moviereviews.reviews, function(i, moviereview) {
		var td;
		var $tr = $("<tr>").appendTo($body);
		$("<td nowrap>").text(moviereview.rating).appendTo($tr);
		//$("<td>").text(moviereview.username).appendTo($tr);
		$td = $("<td nowrap>").appendTo($tr);
		$("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + moviereview.username).text(moviereview.username).appendTo($td);
		if(moviereview.isSpo==1){
			$("<td nowrap>").attr("id","revContent").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<td nowrap>").css("cursor","pointer").on("click",function(){
				location.href="/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo;
			}).text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		var $td = $("<td nowrap>").appendTo($tr)
			
		console.log(moviereviews);
	});
}
$(function() {
	
	var mno1 = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	console.log(location.search.split('=')[0]);
	if(location.search.split('=')[0] == ""){
		location.href="/moviefactory";
	}
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list?mno=" + mno1,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists();
			console.log(moviereviews);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	
	// 2. page.totalcount, page.pageno, page.pagesize를 이용해 페이징 처리를 하는 메소드
	function printPage(page, writer) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));
		
		// 2.1 페이징을 위한 계산
		// 전체 페이지의 개수를 계산
		var cntOfPage = Math.floor(page.totalcount/page.pagesize);
		if(page.totalcount%page.pagesize!=0)
			cntOfPage++;
		
		// 현재 페이지가 몇번째 블록인지 계산 : 페이지가 17개, blockSize가 5일 경우
		//	pageno		blockNo			startPage		endPage		previousPage		nextPage
		//		1			1				1				5			-					6
		//		5			1				1				5			-					6
		//		6			2				6				10			5					11
		//		11			3				11				15			10					16
		//		15			3				11				15			10					16
		//		16			3				16				17			15					-
		var blockSize = 5;
		var blockNo = Math.floor(page.pageno/blockSize) + 1;
		// page.pageno가 blockSize의 배수인 경우 (위에서 pageno가 5, 10, 15) blockNo 감소
		if(page.pageno % blockSize==0)
			blockNo--;
		// 시작과 종료 페이지 계산
		var startPage = (blockNo-1) * blockSize + 1;
		var endPage = startPage + blockSize -1;
		// 마지막 페이지가 페이지의 개수보다 큰 경우 처리
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		// 2.2 페이징 출력
		var writerParam = '';
		if(writer!=undefined)
			writerParam = '&writer=' + writer;
		// 블록 번호가 1보다 큰 경우 앞으로 버튼 출력
		if(blockNo>1) {
			var $li = $("<li>").attr("class", "previous").appendTo($ul);
			$("<a>").attr("href","/moviefactory/movie/review/list?mno=" + (startPage-1) + writerParam).text("앞으로").appendTo($li);
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for(var i=startPage; i<endPage; i++) {
			if(i==page.pageno) {
				var $li = $("<li>").attr("class","active").appendTo($ul);
				$("<a>").attr("href","/moviefactory/movie/review/list?mno=" + mno + writerParam).text(i).appendTo($li);
			}
			else {
				var $li = $("<li>").appendTo($ul);
				$("<a>").attr("href","/moviefactory/movie/review/list?mno=" + mno + writerParam).text(i).appendTo($li);
			}
		}
		
		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if(endPage<cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($ul);
			$("<a>").attr("href", "/moviefactory/movie/review/list?pageno=" + (endPage+1) +  writerParam).text("다음으로").appendTo($li);
		}	
	}
	
	
	
	
	
	
	
	
	
	
	
	function printPage(result) {
		console.log("--------------1-----------------");
		//$("#pagination>*").remove();
		var pageno = result.pageno;
		var pagesize = 10;
		var totalcount = result.totalcount;
		var pagesPerBlock = 10;
		var cntOfPage = totalcount/pagesize + 1;
		if(totalcount%pagesize==0) cntOfPage--;
		var blockNo = Math.floor((pageno-1)/pagesPerBlock);
		var startPage = blockNo * pagesPerBlock + 1;
		var endPage = startPage + pagesPerBlock - 1;
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		var $pagination = $("#pagination");	
		/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
		console.log("페이징함수 들어옴");
		
		
		
		var pagearr = new Array();
		for(var i=startPage;i<=endPage; i++){
			pagearr[i]=i;
		}
		if(blockNo>0) {
			var $li = $("<li>").attr("class","previous").appendTo($pagination);
			$("<a>").attr("href", serverUrl + (startPage-1)).text("<").appendTo($li);		
		}
		for(var i=startPage; i<=endPage; i++) {
			if(pageno==i) {
				var $li = $("<li>").attr("class","active").appendTo($pagination);
				$("<a>").attr("href", serverUrl + i).text(i).appendTo($li);
				} 
			else{
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
		toastr.options = {
			"progressBar" : true
		}
		
		// 전체 글을 페이징하면 주소가 ?pageno=11
		// 특정 사용자가 작성한 글을 페이징하면 ?pageno=11&writer=spring11
		// &를 기준으로 문자열을 자른다
		var params = location.search.split('&');
		
		// pageno=11
		console.log(params[0]);
		// 전체 글 페이징 : undefined, 사용자가 작성한 글 페이징: writer=spring11
		console.log(params[1]);
		console.log(location.search.substr(1));
		$.ajax({
			url: "/moviefactory/api/movie/review/list",
			method: "get",
			data : location.search.substr(1),
			success: function(result) {
				console.log("-------------------------------");
				console.log(result);
				if(params[1]!=undefined)
					printPage(result, params[1].substr(7));
				else
					printPage(result);
			}
		});
	});
});
</script>
</sec:authorize>
<style>
	table {
	 width : 800px;
	 margin : 0 auto;
	 text-align: center;
		border-radius: 2px #BDBDBD solid;
		table-layout: fixed;
	}
	
	th {
	text-align: center;
	border-bottom: 1px #D5D5D5 solid;
	background-color : #5CD1E5;
	color: white;
	}
	
	td {
	border-bottom: 1px #F6F6F6 solid;
	} 
	
	tr {
		text-align:center;
		height: 60px;
	}
	
	#movierevform {
		width : 800px;
		margin : 0 auto;
		
	}
	tr:hover {
		background-color: #FCFCFC;
		font-weight: bold;
	}
	#revContent{
		overflow:hidden;
		width:600px;
	}
</style>
</head>
<body>
	<div id="section">
	
		<form id="movierevform">
		<legend class="text-center" style="font-size:25pt"><strong>리뷰목록</strong></legend>
		<table class="MovieReview">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="80%">
			</colgroup>
			<thead>
				<tr>
					<th>평점</th>
					<th>작성자</th>
					<th colspan="2">내용 </th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>	
		</table>
		</form>
		<div class="row text-center" style="width: 100%; margin:10px;" >
		<div id="pagination" class="pagination"  style="margin:0 auto;">
		</div>
		</div>
	</div>
</body>
</html>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>