<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
.center {
	text-align : center;
 	font-size : 25pt;
}
</style>
</head>
<script>


function printList(result) {
	var $reports = $("#reports");
	$reports.empty();
	
	$("#writingdate").text(result.writingDate);
	$("#username").text(result.username);
	$("#content").text(result.mrevContent);
	$.each(result.reviewReports, function(i, reviewReport){
		
		var $report = $("<div>").appendTo($reports);
		console.log($report);
		$("<span></span>").text("신고 제목 : " + reviewReport.title).appendTo($report);
		$("<span></span>").text("신고 내용 : " + reviewReport.content).appendTo($report);
		$("<span></span>").text("신고 유저 : " + reviewReport.username).appendTo($report);
		$("<span></span>").text("신고 종류 : " + reviewReport.mrepCate).appendTo($report);
	});

}
$(function() {
	var mRevNo = location.search.split("=");
	console.log(mRevNo[1]);
	$.ajax({					
		url: "/moviefactory/api/read/blind/review?mRevNo=" + mRevNo[1],
		method: "get",
		success: function(result) {
			console.log(result);
			printList(result);
		}
	});
})

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
		<p class="center"><strong>관리자 센터 - 리뷰 신고내역</strong></p>
		<hr>
		<div>
			<span>작성일 : </span><span id="writingdate"></span>
		</div>
		<div>
			<span>아이디 : </span><span id="username"></span>
		</div>
		<div>
			<span>리뷰 내용 : </span><span id="content"></span>
		</div>
	</div>
	<hr>
	<div id="reports">
	</div>
	</div>
</body>
</html>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>