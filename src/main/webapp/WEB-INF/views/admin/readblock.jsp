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
<style>
.center {
	text-align : center;
 	font-size : 25pt;
}
</style>
</head>
<script>
function printReviews(result) {
	var $body= $("#list");
	//$body.empty();
	$.each(result, function(idx, movieReview) {
		//console.log(movieReview);
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movieReview.mrevNo).appendTo($tr);
		$("<td>").text(movieReview.mrevContent).appendTo($tr);
		$("<td>").text(movieReview.username).appendTo($tr);
	}); 
/* 	$.each(result.movieReviewComments, function(idx, movieReviewComment) {
		//console.log(movieReviewComment);
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
		var $td = $("<td>").appendTo($tr);
		$("<td>").text(movieReviewComment.content).appendTo($tr);
		$("<td>").text(movieReviewComment.username).appendTo($tr);
	}); */
}
function printCmnt(result) {
	var $body= $("#list");
	//$body.empty();
	$.each(result, function(idx, movieReview) {
		//console.log(movieReview);
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movieReview.mrevCmntNo).appendTo($tr);
		$("<td>").text(movieReview.content).appendTo($tr);
		$("<td>").text(movieReview.username).appendTo($tr);
	}); 
/* 	$.each(result.movieReviewComments, function(idx, movieReviewComment) {
		//console.log(movieReviewComment);
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movieReviewComment.mrevCmntNo).appendTo($tr);
		var $td = $("<td>").appendTo($tr);
		$("<td>").text(movieReviewComment.content).appendTo($tr);
		$("<td>").text(movieReviewComment.username).appendTo($tr);
	}); */
}


$(function() {
	var username = location.search.split("=");
	//console.log(username[1]);
	$.ajax({
		url: "/moviefactory/api/findrevblindbyuser?username=" + username[1],
		method: "get",
		success: function(result) {
			console.log(result);
			printReviews(result);
		}
	});
	$.ajax({	
		url: "/moviefactory/api/findcmntblindbyuser?username=" + username[1],
		method: "get",
		success: function(result) {
			console.log(result);
			printCmnt(result);
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
		<p class="center"><strong>관리자 센터 - 블라인드내역</strong></p>
		<hr>
		<div id="admin_board">
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="60%">
					<col width="30%">
				</colgroup>
				<thead class="board_top">
					<tr>  
						<th id=number>번호</th>
						<th id=content>내용</th>
						<th id=username>아이디</th>
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