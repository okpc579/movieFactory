<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
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
<style>
.center {
	text-align: center;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}

#listbar {
	background-color: #4ABFD3;
	color: white;
}

tr th {
	text-align: center;
	height: 37px;
}

td {
	text-align: center;
	height: 37px;
}

table {
	table-layout: fixed;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.totaltable {
	margin: 0;
	width: 1100px;
}
</style>
</head>
<script>
	function printRev(result) {
		var $body = $("#revlist");
		//$body.empty();
		$.each(result, function(idx, movieReview) {
			//console.log(movieReview);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(movieReview.mrevNo).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			
			$("<a>").attr( 
					"href",
					"/moviefactory/admin/readrevblind?mrevNo="
							+ movieReview.mrevNo)
							.text(movieReview.mrevContent).appendTo($td);
			$("<td>").text(movieReview.username).appendTo($tr);
		});
	}
	 
	function printCmnt(cmnt) {
		var $body = $("#cmntlist");
		$.each(cmnt, function(idx, movieReviewComment) {
			//console.log(movieReview);
			var $tr = $("<tr>").appendTo($body);
			$("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
			//$("<td>").text(movieReviewComment.content).appendTo($tr);
			var $td = $("<td>").appendTo($tr);
			
			$("<a>").attr("href","/moviefactory/admin/readrevcmntblind?mrevCmntNo="
							+ movieReviewComment.mrevCmntNo)
							.text(movieReviewComment.content).css("overflow","hidden").css("white-space","nowrap").appendTo($td);
			$("<td>").text(movieReviewComment.username).appendTo($tr);
		});

	}
	
	/* 	$.each(result.movieReviewComments, function(idx, movieReviewComment) {
	 //console.log(movieReviewComment);
	 var $tr = $("<tr>").appendTo($body);
	 $("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
	 var $td = $("<td>").appendTo($tr);
	 $("<td>").text(movieReviewComment.content).appendTo($tr);
	 $("<td>").text(movieReviewComment.username).appendTo($tr);
	 }); */
	var isreviews = true;
	var iscomments = true;
	function checkfill(){
		if(isreviews == false && iscomments == false){
			location.href="/moviefactory/admin/blocklist"
		}
	}
	$(function() {
		var username = location.search.split("=");
		//console.log(username[1]);
		$.ajax({
			url : "/moviefactory/api/blind/findreviewbyuser?username="
					+ username[1],
			method : "get",
			success : function(result) {
				console.log(result);
				printRev(result);
				
				if(result.length==0) {
					//location.href="/moviefactory/admin/blocklist"
					isreviews = false;
				}
				checkfill();
			} , error: function(result){
				location.href="/moviefactory/admin/blocklist"
			}
		});
		$.ajax({
			url : "/moviefactory/api/blind/findcommentbyuser?username="
					+ username[1],
			method : "get",
			success : function(cmnt) {
				console.log(cmnt);
				printCmnt(cmnt);
				
				if(cmnt.length==0) {
					//location.href="/moviefactory/admin/blocklist"
					iscomments = false;
				}
				checkfill();
				
			} , error: function(result){
				location.href="/moviefactory/admin/blocklist"
			}
		});
	});
</script>

<body>
	<div id="section">
		<sec:authorize access="isAnonymous()">
			<script>
				location.href = "/moviefactory/system/e403";
			</script>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_USER')">
			<script>
				location.href = "/moviefactory/system/e403";
			</script>
		</sec:authorize>

		<h2 class="center">
			<strong> <a
				href="/moviefactory/admin/blocklist"> 관리자
					센터 - 블라인드 목록</a>
			</strong>
		</h2>

		<br>
		<hr>
		<div id="admin">
			<table class="totaltable">

				<%-- <colgroup>
					<col width="10%">
					<col width="70%">
					<col width="20%">
				</colgroup> --%>
				<thead class="board_top">
					<tr id="listbar">
						<th id=number>리뷰번호</th>
						<th id=content>내용</th>
						<th id=username>아이디</th>
					</tr>
				</thead>


				<tbody id="revlist">

				</tbody>

				<colgroup>
					<col width="10%">
					<col width="70%">
					<col width="20%">
				</colgroup>
				<thead class="board_top">
					<tr id="listbar">
						<th id=number>댓글번호</th>
						<th id=content>내용</th>
						<th id=username>아이디</th>
					</tr>
				</thead>


				<tbody id="cmntlist">

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
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