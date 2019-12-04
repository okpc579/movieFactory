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
<!-- 
<style>
#main {
	width: 1000px; display: inline-block;
}

#admin_board {
	width: 758px; text-align: center;
}

.board_top {
	text-align: center;
}

#title_center {
	text-align: center;
}

.normal_user {
	font-size: 40px;
}
#paging {
 width: 300px;
 }


.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
	border: 1px solid #ddd;
}

.pagination a.active {
	background-color: #4CAF50;
	color: white;
	border: 1px solid #4CAF50;
}

.pagination a:hover:not (.active ) {
	background-color: #ddd;
}
</style>
 -->
 <style>
 .center {
 	text-align : center;
 	font-size : 25pt;
 }
 </style>
<script>
	function printList(page) {
		var $body = $("#list");
		$.each(page.movieReviewComments, function(idx, movieReviewComment) {
			console.log(movieReviewComment);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			$("<a>").attr("href","/moviefactory/admin/readrevcmntblind?mrevCmntNo=" + movieReviewComment.mrevCmntNo).text(movieReviewComment.content).appendTo($td);
			$("<td>").text(movieReviewComment.username).appendTo($tr);
			$td = $("<td>").appendTo($tr);
			$("<button class='btn btn-default' id='unblock" + idx +  "'>").text("블라인드해제").appendTo($td);
			$("<input type='hidden' id='unblocksub" + idx +  "'>").val(movieReviewComment.mrevCmntNo).appendTo($td);
		});
		
		$("#unblock0").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub0").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock1").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub1").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock2").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub2").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock3").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub3").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock4").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub4").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock5").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub5").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock6").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub6").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock7").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub7").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock8").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub8").val(),		
			}
			unblindcomment(param);
		});
		$("#unblock9").on("click", function() {
			var param ={
					_method:"post",
					mRevCmntNo:$("#unblocksub9").val(),		
			}
			unblindcomment(param);
		});
	}
	
	function unblindcomment(param){
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/update/blind/comment",
			method: "post",
			data: param,
			success: function(result) {
				 location.reload();
			}
		});
	}
	
	
	
	function revCmntBlindPage(page, username) {
		var $ul = $("<ul>").attr("class", "pagination").appendTo($("#paging"));
		
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
			$("<a>").attr("href","/moviefactory/admin/blindcmntlist?pageno=" + (startPage-1) + usernameParam).text("앞으로").appendTo($li);
		}
		// 현재 페이지인 경우 li에 active 클래스를 지정하면서 페이지 번호 출력
		for(var i=startPage; i<=endPage; i++) {
			if(i==page.pageno) {
				var $li = $("<li>").attr("class","active").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blindcmntlist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
			else {
				var $li = $("<li>").appendTo($ul);
				$("<a>").attr("href","/moviefactory/admin/blindcmntlist?pageno=" + i + usernameParam).text(i).appendTo($li);
			}
		}
		
		if(endPage<cntOfPage) {
			var $li = $("<li>").attr("class", "next").appendTo($ul);
			$("<a>").attr("href", "/moviefactory/admin/blindcmntlist?pageno=" + (endPage+1) +  usernameParam).text("다음으로").appendTo($li);
		}	
	}

		$(function() {
			toastr.options = {
					"progressBar" : true
			}
			var params = location.search.split('=');
			console.log(params);
			var url = "/moviefactory/api/findcmntblind";
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
					revCmntBlindPage(result);
				
				}
			});
		});
	
</script>
<body>
<div id="section">
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

		<h2>고객 센터 - 블라인드 댓글</h2>

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
						<th>댓글번호</th>
						<th>댓글내용</th>
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
	</div>
</body>
</html>
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