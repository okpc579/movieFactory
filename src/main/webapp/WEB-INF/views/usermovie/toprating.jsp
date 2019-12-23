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
<title>Insert title here</title>
<style>

   	table, th, td {
    width : 400px;
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
var movies;
var username;	
var moviereviews; 
var strArray;
var reviews;
var posterString;

// 유저의 리뷰 출력 - 제목, 별점 반복문
function printRating() {
	   var $body = $("#list");	
	    $.each(reviews,function(i, review){	// 반복문 리뷰를 참조
	    	
			var $tr = $("<tr>").appendTo($body);	//$body안에 tr넣는다
			//$("<a>").appendTo($tr);
			getMovieDetail(review.mno, review.rating, review.genre, review.prdtyear, review.repNationNm, $tr);
	      	});	// tr안에 넣는다 리뷰안에 영화번호,별점,장르 
		}

function getMovieDetail(mno, rating, genre, prdtyear, repNationNm, $tr){	// 영화번호, 별점, 장르를 tr에 넣는다
	$.ajax({	
		url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + mno,
		method: "get",
		success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
			console.log(result);	// result 값을 출력
				printmovie(mno, $(result).find('movieNm').text(), rating, genre, prdtyear, repNationNm, $(result).find('prdtYear').text(),  $tr);
		}, error: function(xhr) {	// 에러발생시 
			 console.log(xhr.status);	// 오류번호 발생번호 출력
		}
	});
}

function printmovie(mno, movieNm, rating, genre, prdtyear, repNationNm, $tr){
	
	var $td = $("<td>").appendTo($tr);	// 제목
	$("<a>").attr("href","/moviefactory/movie/read?mno=" + mno).text(movieNm).appendTo($td);
	//$("<td>").text(movieNm).appendTo($tr);	// 제목
	$("<td>").text(rating).appendTo($tr);	// 별점
	$("<td>").text(genre).appendTo($tr);	// 장르
	$("<td>").text(prdtyear).appendTo($tr);	// 제작년도
	$("<td>").text(repNationNm).appendTo($tr);	// 제작국가
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
				$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("height","150px").attr("width", "150px").appendTo($td); 
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
		            $("#user_name").text(result+"님의 고평가 영화");
		         }
	      });
	});
	
$(function() {      // 문자열을 나누어는(split) 기능
	   coll_no = location.search.split("&")[0].split("=")[1];
	   console.log(location.search.split("&")[0].split("=")[1]);
	   //console.log(location.search.split("&")[1].split("=")[1]);
	   var pageno;
	   if(typeof location.search.split("&")[1] == "undefined"){
		   pageno=1;
	   }else {
		   pageno=location.search.split("&")[1].split("=")[1];
	   }
	      $.ajax({
	         url: "/moviefactory/api/usermovie/review?username=" + location.search.split("&")[0].split("=")[1] + "&pageno="+pageno,
	         method: "get",
	         success: function(result, status, xhr) {
	            console.log(result);
	            printRating();
	            printPaging(result);
	         	}, error: function(xhr) {   
	         		}
	      		});
			});
	
	
</script>
</head>
<body>
<div id="section">
	<strong><legend class="text-center" id="user_name" style="font-size:28pt"></legend></strong>
			<table class="startop_table">
				<colgroup>
  				<col width="36%">
  				<col width="15%">
  				<col width="26%">
  				<col width="10%">
  				<col width="13%">
				</colgroup>
				<thead>
					<tr>
						<th>제목</th>
						<th>장르</th>
						<th>제작년도</th>
						<th>제작국가</th>
						<th>포스터</th>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
			</table>
</div>
</body>
</html>