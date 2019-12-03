<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>
</head>
<script>
	function printList(page) {
		var $body = $("#list");
		$.each(page.movieReviews, function(idx, movieReview) {
			console.log(movieReview);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(movieReview.mrevNo).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			$("<a>").attr("href","/moviefactory/admin/readrevblind?mrevNo=" + movieReview.mrevNo).text(movieReview.mrevContent).appendTo($td);
			$("<td>").text(movieReview.username).appendTo($tr);
			$td = $("<td>").appendTo($tr);
			$("<button id='unblock" + idx +  "'>").text("블라인드해제").appendTo($td);
			$("<input type='hidden' id='unblocksub" + idx +  "'>").val(movieReview.mrevNo).appendTo($td);
		});
		$("#unblock0").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub0").val(),		
			}
			unblindreview(param);
		});
		$("#unblock1").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub1").val(),		
			}
			unblindreview(param);
		});
		$("#unblock2").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub2").val(),		
			}
			unblindreview(param);
		});
		$("#unblock3").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub3").val(),		
			}
			unblindreview(param);
		});
		$("#unblock4").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub4").val(),		
			}
			unblindreview(param);
		});
		$("#unblock5").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub5").val(),		
			}
			unblindreview(param);
		});
		$("#unblock6").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub6").val(),		
			}
			unblindreview(param);
		});
		$("#unblock7").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub7").val(),		
			}
			unblindreview(param);
		});
		$("#unblock8").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub8").val(),		
			}
			unblindreview(param);
		});
		$("#unblock9").on("click", function() {
			var param ={
					_method:"post",
					mRevNo:$("#unblocksub9").val(),		
			}
			unblindreview(param);
		});
	}
	
	function unblindreview(param){
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/update/blind/review",
			method: "post",
			data: param,
			success: function(result) {
				 location.reload();
			}
		});		
	}
	
	// 2. page.totalcount, page.pageno, page.pagesize를 이용해 페이징 처리를 하는 메소드
	function revBlindPage(page, username) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));
		
		// 2.1 페이징을 위한 계산
		var cntOfPage = Math.floor(page.totalcount/page.pagesize);
		if(page.totalcount%page.pagesize!=0)
			cntOfPage++;
		var blockSize = 5;
		var blockNo = Math.floor(page.pageno/blockSize) + 1;
		if(page.pageno % blockSize==0)
			blockNo--;
		var startPage = (blockNo-1) * blockSize + 1;
		var endPage = startPage + blockSize -1;
		if(endPage>cntOfPage)
			endPage = cntOfPage;
		
		var usernameParam = '';
		if(username!=undefined)
			usernameParam = '&username=' + username;
		if(blockNo>1) {
			var $li = $("<li>").attr("class", "previous").appendTo($ul);
			$("<a>").attr("href","/moviefactory/admin/blindrevlist?pageno=" + (startPage-1) + usernameParam).text("앞으로").appendTo($li);
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for(var i=startPage; i<=endPage; i++) {
			if(i==page.pageno) {
				var $li = $("<li>").attr("class","active").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blindrevlist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
			else {
				var $li = $("<li>").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blindrevlist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
		}
		
		// 블록의 마지막 페이지가 페이지 개수보다 작은 경우 다음으로 버튼 출력
		if(endPage<cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($ul);
			$("<a>").attr("href", "/moviefactory/admin/blindrevlist?pageno=" + (endPage+1) +  usernameParam).text("다음으로").appendTo($li);
		}	
	}
	$(function() {
		toastr.options = {
				"progressBar" : true
		}
		var params = location.search.split('=');
		console.log(params);
		var url = "/moviefactory/api/findrevblind";
		if(params[0]==""){
			url=url+"?pageno="+1;
		}else{
			url=url+"?pageno="+params[1];
		}
		$.ajax({
			url: url,
			method: "get",
			success: function(result) {
				console.log(result);
				printList(result);
				revBlindPage(result);
			}
		});
	});
</script>
<body>
<sec:authorize access="isAnonymous()">
	<script>
		location.href="http://localhost:8081/moviefactory/system/e403";
	</script>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_USER')">
	<script>
		location.href="http://localhost:8081/moviefactory/system/e403";
	</script>
</sec:authorize>
	<div id="admin">
		<h2>고객 센터 - 블라인드 리뷰목록</h2>
		<hr>
		<div id="admin_board">
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="55%">
					<col width="20%">
					<col width="15%">
				</colgroup>
				<thead class="board_top">
					<tr>
						<th>리뷰번호</th>
						<th>리뷰내용</th>
						<th id="username">아이디</th>
						<th>블라인드해제</th>
					</tr>
				</thead>
				<tbody id="list">
					
				</tbody>
			</table>
			
			<div class="row text-center" style="width: 100%">
				<div style="width: 30%; float: none; margin: 0 auto">
					<div id="paging" class="pagination" style="text-align: center;">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>