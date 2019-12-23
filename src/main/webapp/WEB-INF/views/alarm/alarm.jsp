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
<link rel="stylesheet" 
href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
crossorigin="anonymous">

<title>Insert title here</title>
<style>
	#section {
	border: 3px solid #A6A6A6;
	}
	#my, #you{
		padding:10px;
		width: 100%;
		height:50%;
		display: inline-block;
	}
	#section{
		width:100%;
		height:100%;
		display: inline-block;
	}
	#my {
		background-color: #D4F4FA;	
	}
	#you {
		background-color: #FFD9FA;
	}
	a {
	color: #353535;
	}
	a:hover {
		background-color:#F6F6F6;
		color: #000000;
		font-weight: bold;
	}
	
	
	
</style>
<script>
var mys;
var yous;

function printMy() {
	$.each(mys.comments, function(i, comment) {
		//var $mydiv = $("#my");
		var $mydiv = $("<div>").appendTo($("#my"));
		//$("<div>").text(comment.mrevNo +"이리뷰에" +"누가? " + comment.username + "이 " + comment.writingDate + "에 " + comment.content + "라고 작성했습니다.").appendTo($mydiv);
		
		var locations = "/moviefactory/movie/review/read?mrevNo=" + comment.mrevNo;
		$("<a onclick=\"opener.location.href = \'" + locations +"\'\">").attr("href","#").text(comment.username + "님이 내 리뷰에 댓글을 작성했습니다.").appendTo($mydiv);	
		//comment.username + "님이 내 리뷰에 댓글을 작성했습니다."
	});
	$.each(mys.reviewlikes, function(i, reviewlike) {
		//var $mydiv = $("#my");
		var $mydiv = $("<div>").appendTo($("#my"));
		//$("<div>").text(reviewlike.mrevNo +"이리뷰에" +"누가? " + reviewlike.username + "이 좋아요했습니다").appendTo($mydiv);
		//$("<a onclick='urlLocation('http://www.naver.com')>").attr("href","http://localhost:8081/moviefactory/movie/review/read?mrevNo="+reviewlike.mrevNo).text("good").appendTo($mydiv);
		var locations = "/moviefactory/movie/review/read?mrevNo=" + reviewlike.mrevNo;
		$("<a onclick=\"opener.location.href = \'" + locations +"\'\">").attr("href","#").text(reviewlike.username + "님이 \"" + reviewlike.content + "\"리뷰에 좋아요를 눌렀습니다").appendTo($mydiv);
		//~~님이 "리뷰내용" 리뷰에 좋아요 했습니다
		//reviewlike.username + "님이 \"" + reviewlike.content + "\"리뷰에 좋아요를 눌렀습니다"
	});
	$.each(mys.commentlikes, function(i, commentlike) {
		//var $mydiv = $("#my");
		var $mydiv = $("<div>").appendTo($("#my"));
		//$("<div>").text(commentlike.mrevCmntNo +"이댓글에" +"누가? " + commentlike.username + "이 좋아요했습니다").appendTo($mydiv);
		var locations = "/moviefactory/movie/review/read?mrevNo=" + commentlike.mrevNo;
		$("<a onclick=\"opener.location.href = \'" + locations +"\'\">").attr("href","#").text(commentlike.username + "님이 \"" + commentlike.content + "\"리뷰에 좋아요를 눌렀습니다").appendTo($mydiv);
		//~~님이 "댓글내용" 댓글에 좋아요 했다
		//commentlike.username + "님이 \"" + commentlike.content + "\"댓글에 좋아요를 눌렀습니다" 
	});
}
function printYous() {
	$.each(yous, function(i, you) {
			
		var $youdiv = $("#you");
		//$("<div>").text("리뷰번호 : " + you.mrevNo + "에"+ you.username + " 이인간이 달았습니다").appendTo($youdiv);
		var locations = "/moviefactory/movie/review/read?mrevNo=" + you.mrevNo;
		$.ajax({
	          url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + you.mno,
	          method: "get",
	          success: function(result, status, xhr) {
	             console.log(result);
	             console.log();
	             $(result).find('movieNm').text();
	             $("<a onclick=\"opener.location.href = \'" + locations +"\'\">").attr("href","#").text(you.username + "님이 \"" + $(result).find('movieNm').text() +"\"영화에 리뷰를 작성했습니다." ).appendTo($youdiv);
	             //you.username + "님이 \"" + $(result).find('movieNm').text() +"\"영화에 리뷰를 작성했습니다." 
	          }, error: function(xhr) {
	              console.log(xhr.status);
	          }
	       });
		
		//어떤놈이 이런영화에 리뷰를 달았습니다.	리뷰로감
		
	});
}




$(function() {
	/*
	var param = {
			mNo: mno
		};
	*/
	$.ajax({
		url: "/moviefactory/api/alarm/my",
		method: "get",
		success: function(result, status, xhr) {
			console.log(result);
			console.log("my");
			mys=result;
			printMy();
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	$.ajax({
		url: "/moviefactory/api/alarm/you",
		method: "get",
		success: function(result, status, xhr) {
			console.log(result);
			console.log("you");
			yous=result;
			printYous();
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
});
</script>
<style>
</style>
</head>
<body>
<div id="section">
	
	<div id="my">
		<!-- 마지막 접속 ~ 최근접속 어찌 표현할까!!!!!!!!!!!! -->
		
		<h3><strong>내소식</strong><i class="fas fa-bell fa-fw" style="color:#00D8FF"></i></h3>
		<p><mark  style="background-color: white;" ><strong>: 접속전까지의 소식입니다</strong></mark></p>
	</div>
	<div id="you">
		<h3><strong>팔로잉 소식</strong><i class="fas fa-bell fa-fw" style="color:#00D8FF"></i></h3>
		<p><mark style="background-color: white;"><strong>: 팔로잉 유저의 소식입니다</strong></mark></p>
	</div>
	
</div>
</body>
</html>