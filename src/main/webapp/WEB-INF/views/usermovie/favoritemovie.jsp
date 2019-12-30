<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>좋아하는 영화 목록</title>
<style>
	
	table, th, td {
    width : 1100px;
    margin : 0 auto;
    text-align: center;
    border: 1px black solid;
    border-color: #EAEAEA;  
    font-style:
	}
   
   	th {
   	background-color: #5CD1E5;
   	color: white;
   	font-size: 22px;
	}
</style>
<script>

// 1. jsp에 어떤 목록을 보여줄지 선택과 생성 
var favorites;
var username;



function printReview(reviews) {
	   var $body = $("#list");	
	    $.each(reviews,function(i, review){	// 반복문 리뷰를 참조
	    	
			var $tr = $("<tr>").appendTo($body);	//$body안에 tr넣는다
			getMovieDetail(review.mno, review.rating2, $tr);
		});
}

function getMovieDetail(mno, avgrating, $tr){	// 영화번호, 별점, 장르를 tr에 넣는다
	$.ajax({	
		url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + mno,
		method: "get",
		success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
			console.log(result);	// result 값을 출력
				printmovie(mno, $(result).find('movieNm').text(), avgrating, $(result).find('genreNm').text(), $(result).find('prdtYear').text(),  $tr);
		}, error: function(xhr) {	// 에러발생시 
			 console.log(xhr.status);	// 오류번호 발생번호 출력
		}
	});
}

function printmovie(mno, movieNm, avgrating, genre, prdtyear, $tr){
	var $td = $("<td>").appendTo($tr);	// 제목
	$("<a>").attr("href","/moviefactory/movie/read?mno=" + mno).css("font-size","20px").text(movieNm).appendTo($td);
	$("<td>").css("font-size","25px").text(avgrating).appendTo($tr);	// 별점
	$("<td>").css("font-size","20px").text(genre).appendTo($tr);	// 장르
	$("<td>").css("font-size","20px").text(prdtyear).appendTo($tr);	// 장르
	getPoster2(movieNm, prdtyear, $tr);		// 포스터
	/* $("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("영화정보").appendTo($td); */
}

function getPoster2(movieNm, prdtYear, $tr) {	// (영화제목,제작년도)로 포스터 불러오는 기능
	//console.log(movie);
	console.log(movieNm);
	console.log(prdtYear);
	$.ajax({
		url:"/moviefactory/api/image?subtitle=" + movieNm
				+ "&pubData=" + prdtYear,
		method: "get",
		success:function(result) {
			console.log(result.image);
			//posterString = result.image;
			if(typeof result.image == "undefined"){	// 이미지가 정해지지 않을 경우
				var $td = $("<td>").appendTo($tr)	// td에 tr를 넣어라
				$("<img>").attr("src","/sajin/default_movie.png").attr("height","150px").attr("width", "150px").appendTo($td); 
			}else {
			var $td = $("<td>").appendTo($tr)	// 이미지가 들어있는 td를 tr에 넣어라
			$("<img>").attr("src",result.image).attr("height","150px").attr("width", "150px").appendTo($td);	// result.image를 td안에 넣어라
			//$("<td>").text(result.image).appendTo($tr);
			}
			
		}, error:function(xhr) {
			console.log(xhr);
		}
	});
}

	function printList() {
	// 1. 테이블의 <tbody> 선택		
	var $body = $("#list");
	$.each(favorites, function(i, favorite) {
		console.log("반복문진입");
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(favorite.mno).appendTo($tr);	// 영화코드
		var $td = $("<td>").appendTo($tr)
		//getPoster(movie, $tr);							// 포스터
	});
}
	
// 2. 포스터 가져오기
	function getPoster(movie, $tr) {
		console.log(movie);
		$.ajax({
			url:"/moviefactory/api/image?subtitle=" + movie.movieNm + "&pubData=" + movie.prdtYear,
			method: "get",
			success:function(result) {
				console.log(result.image);
				//posterString = result.image;
				if(typeof result.image == "undefined" || result.image==""){
					var $td = $("<td>").appendTo($tr)
					$("<img>").attr("src","/sajin/default_movie.png")
					.attr("width", "110px").appendTo($td); 
				} else {
				var $td = $("<td>").appendTo($tr)
				$("<img>").attr("src",result.image).appendTo($td);
				//$("<td>").text(result.image).appendTo($tr);
				}
				
				}, error:function(xhr) {
					console.log(xhr);
					}
		});
	};
	
// 3. 유저이름으로 영화 불러오기
$(function() {
   console.log(location.search.split('&'));
   strArray = location.search.split('&');
   console.log(strArray[0].split('=')[1]);
   username=strArray[0].split('=')[1];

      $.ajax({
	         url: "/moviefactory/api/usermovie/findnickname?username=" + username,
	         method: "get",
	         success: function(result) {
	            console.log(result);
	            $("#user_name").text(result+"님이 좋아하는 영화");
	         }
      });
      $.ajax({
	         url: "/moviefactory/api/usermovie/favoritemovie?username=" + username,
	         method: "get",
	         success: function(result) {
	            console.log(result);
	            printReview(result);
	         }
   });
});
</script>
</head>
<body>
<div id="section">
	<div id="favorite_menu">
		<strong><legend class="text-center" id="user_name" style="font-size:28pt"></legend></strong>
		<table class="favorite_table">
  			<colgroup>
  				<col width="36%">
  				<col width="15%">
  				<col width="26%">
  				<col width="10%">
  				<col width="13%">
  			</colgroup>
  			<thead>
  				<tr><!-- /moviefactory/usermovie/favoritemovie?username=xogh8123 -->
  					<th>제목</th>
  					<th>종합 평점</th>
  					<th>장르</th>
  					<th>제작년도</th>
  					<th>포스터</th>
  				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
	</div>
</div>
</body>
</html>