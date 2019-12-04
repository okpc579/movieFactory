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
	var $body = $("#list");
	$.each(moviereviews, function(i, moviereview) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(moviereview.mrevNo).appendTo($tr);
		$("<td>").text(moviereview.username).appendTo($tr);
		if(moviereview.isSpo==1){
			$("<a>").text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<a>").text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		
		var $td = $("<td>").appendTo($tr)
		$("<button id='button" + i +  "'>").attr("href","/moviefactory/movie/review/delete?mrevNo=" + moviereview.mrevNo).text("삭제").appendTo($td);
		console.log(moviereview.mrevNo);
	});
}
$(function() {
	
	//var mno = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list/" + mno,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists();
			console.log(moviereviews);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	function printList(page) {
		// 테이블의 <tbody>를 선택한다
		var $body = $("#list");
		$.each(page.moviereviews, function(idx, moviereview) {
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(board.bno).appendTo($tr)
			var $td = $("<td>").appendTo($tr)
			$("<a>").attr("href","/aboard2s/board/read?bno=" + board.bno).text(board.title).appendTo($td);
			// 작성자를 우클릭하면 가입날짜보기, 메모보내기 Modal 대화 상자를 띄우기 위해 각종 속성들을 지정
			$("<td>").text(board.writer).attr("data-writer", board.writer).attr("data-toggle", "modal").attr("data-target","#writerModal").attr("class","writer").appendTo($tr);
			$("<td>").text(board.writeday).appendTo($tr)
			$("<td>").text(board.readCnt).appendTo($tr)
		});
	}
	
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
		http://localhost:8081/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "http://localhost:8081/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
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
				printList(result);
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
<sec:authorize access="hasRole('ROLE_USER')">
<script>
var moviereviews;
var totCnt;
var page;
var query;
function printLists() {
	var $body = $("#list");
	$.each(moviereviews, function(i, moviereview) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(moviereview.mrevNo).appendTo($tr);
		$("<td>").text(moviereview.username).appendTo($tr);
		if(moviereview.isSpo==1){
			$("<a>").text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<a>").text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		var $td = $("<td>").appendTo($tr)
			
		console.log(moviereviews);
	});
}
$(function() {
	
	//var mno = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list/" + mno,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists();
			console.log(moviereviews);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	function printList(page) {
		// 테이블의 <tbody>를 선택한다
		var $body = $("#list");
		$.each(page.moviereviews, function(idx, moviereview) {
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(board.bno).appendTo($tr)
			var $td = $("<td>").appendTo($tr)
			$("<a>").attr("href","/aboard2s/board/read?bno=" + board.bno).text(board.title).appendTo($td);
			// 작성자를 우클릭하면 가입날짜보기, 메모보내기 Modal 대화 상자를 띄우기 위해 각종 속성들을 지정
			$("<td>").text(board.writer).attr("data-writer", board.writer).attr("data-toggle", "modal").attr("data-target","#writerModal").attr("class","writer").appendTo($tr);
			$("<td>").text(board.writeday).appendTo($tr)
			$("<td>").text(board.readCnt).appendTo($tr)
		});
	}
	
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
		http://localhost:8081/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "http://localhost:8081/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
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
				printList(result);
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
<sec:authorize access="isAnonymous()">
<script>
var moviereviews;
var totCnt;
var page;
var query;
function printLists() {
	var $body = $("#list");
	$.each(moviereviews, function(i, moviereview) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(moviereview.mrevNo).appendTo($tr);
		$("<td>").text(moviereview.username).appendTo($tr);
		if(moviereview.isSpo==1){
			$("<a>").text("스포일러가 포함된 리뷰입니다").css("font-weight","bold").css("color","red").attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}else{
			$("<a>").text(moviereview.mrevContent).attr("href","/moviefactory/movie/review/read?mrevNo=" + moviereview.mrevNo).appendTo($tr);
		}
		var $td = $("<td>").appendTo($tr)
			
		console.log(moviereviews);
	});
}
$(function() {
	
	//var mno = location.search.substr(5);
	var mno = location.search.split("&")[0].split("=")[1];
	
	console.log(mno);
	var param = {
			mNo: mno
		};
	console.log(mno);
	console.log("---------------2----------");
	$.ajax({
		url: "/moviefactory/api/movie/review/list/" + mno,
		method: "get",
		success: function(result, status, xhr) {
			moviereviews = result;
			printLists();
			console.log(moviereviews);
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	function printList(page) {
		// 테이블의 <tbody>를 선택한다
		var $body = $("#list");
		$.each(page.moviereviews, function(idx, moviereview) {
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(board.bno).appendTo($tr)
			var $td = $("<td>").appendTo($tr)
			$("<a>").attr("href","/aboard2s/board/read?bno=" + board.bno).text(board.title).appendTo($td);
			// 작성자를 우클릭하면 가입날짜보기, 메모보내기 Modal 대화 상자를 띄우기 위해 각종 속성들을 지정
			$("<td>").text(board.writer).attr("data-writer", board.writer).attr("data-toggle", "modal").attr("data-target","#writerModal").attr("class","writer").appendTo($tr);
			$("<td>").text(board.writeday).appendTo($tr)
			$("<td>").text(board.readCnt).appendTo($tr)
		});
	}
	
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
		http://localhost:8081/moviefactory/movie/review/list?mno=20197803
		var serverUrl = "http://localhost:8081/moviefactory/movie/review/list?mno=" + mno+ "&pageno=";
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
				printList(result);
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
		border: 1px black solid;
	}

	th {
	
		
		
	}
	
	/* th {
		background-color: ;
	} */
	#movierevform {
		width : 800px;
		margin : 0 auto;
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
					<th>리뷰번호</th>
					<th>작성자</th>
					<th colspan="2">내용</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>	
		</table>
	</div>
	<div id="pagination" style="text-align: center;">
	</div>
	</form>
</body>
</html>