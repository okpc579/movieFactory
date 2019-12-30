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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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

#moviereview {
	border: 3px solid #4ABFD3;
	padding: 5px;
	font-size: 20px;
	background-color: #4ABFD3;
	color: white;
}
span, div {
	word-break:break-all;
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
		$.each(result.reviewReports, function(i, reviewReport) {
			var $report = $("<div>").css("margin-top", "5px").css("color",
			"black").css("padding", "5px").css("background-color",
			"skyblue").appendTo($reports);
			$("<strong><div>").text("신고").appendTo($report);	
			$("<br>").appendTo($report);
			$("<span></span>").text("신고 제목 : " + reviewReport.title).appendTo(
					$report);
			$("<br>").appendTo($report);
			$("<span></span>").text("신고 내용 : " + reviewReport.content)
					.appendTo($report);
			$("<br>").appendTo($report);
			$("<span></span>").text("신고 유저 : " + reviewReport.username)
					.appendTo($report);
			$("<br>").appendTo($report);
			$("<span></span>").text("신고 종류 : " + reviewReport.mrepCate)
					.appendTo($report);
		});

	}
	
	$(function() {
		var mRevNo = location.search.split("=");
		console.log(mRevNo[1]);
		$.ajax({
			url : "/moviefactory/api/blind/readreview?mRevNo=" + mRevNo[1],
			method : "get",
			success : function(result) {
				console.log(result);
				printList(result);
			}, error: function(result){
				location.href="/moviefactory/admin/blindrevlist"
			}
		
		
		});
	})
</script>

<body>
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
			<strong>
			<a href="/moviefactory/admin/blindrevlist">
			관리자 센터 - 리뷰 신고내역
			</a>
			</strong>
		</h2>
		<hr>
		<br>
		<div id="moviereview">
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
		<div id="reports"></div>
</body>
</html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>