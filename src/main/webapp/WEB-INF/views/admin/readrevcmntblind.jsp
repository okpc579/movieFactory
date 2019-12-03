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
</head>
<script>

function printList(result) {
	var $reports = $("#reports");
	$reports.empty();
	
	$("#writingdate").text(result.writingDate);
	$("#username").text(result.username);
	$("#content").text(result.content);
	$.each(result.commentReports, function(i, commentReport){
		var $report = $("<div>").appendTo($reports);
		$("<span></span>").text("신고 제목 : " + commentReport.title).appendTo($report);
		$("<span></span>").text("신고 내용 : " + commentReport.content).appendTo($report);
		$("<span></span>").text("신고 유저 : " + commentReport.username).appendTo($report);
		$("<span></span>").text("신고 종류 : " + commentReport.mrepCate).appendTo($report);
	});
}

$(function() {
	var mRevCmntNo = location.search.split("=");
	console.log(mRevCmntNo[1]);
	$.ajax({					
		url: "/moviefactory/api/read/blind/comment?mRevCmntNo=" + mRevCmntNo[1],
		method: "get",
			success: function(result) {
			console.log(result);
			printList(result);
		}
	});
})

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
		<h2>고객 센터 - 댓글 신고내역</h2>
		<hr>
		<div>
			<span>작성일 : </span><span id="writingdate"></span>
		</div>
		<div>
			<span>아이디 : </span><span id="username"></span>
		</div>
		<div>
			<span>댓글 내용 : </span><span id="content"></span>
		</div>
	</div>
	<hr>
	<div id="reports">
	</div>
</body>
</html>