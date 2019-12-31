<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
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
   #titletop {
   	width: 1100px;
   }
   
   #title {
   	width: 900px;
   	float: left; 
   }
   
   #isfollow {
    width: 200px;
    float: right;
   }
   
   #follow, #unfollow {
   height: 50px;
   width: 100px;
   }
</style>
<script>
	var isLogin = false;
	var loginId = undefined;
</script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="member" />
	<script>
		isLogin = true;
		loginId = '${member}';
	</script>
</sec:authorize>

<script>
var username;
var reviews;
function printRating() {
	   var $body = $("#list");	
	    $.each(reviews,function(i, review){	// 반복문 리뷰를 참조
	    	
			var $tr = $("<tr>").appendTo($body);	//$body안에 tr넣는다
			//$("<a>").appendTo($tr);
			getMovieDetail(review.mno, review.rating, review.rating2, review.genre, $tr);
	      	});	// tr안에 넣는다 리뷰안에 영화번호,별점,장르 
		}
function getMovieDetail(mno, rating, avg, genre, $tr){	// 영화번호, 별점, 장르를 tr에 넣는다
	$.ajax({	
		url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=e2ef68048ccb5620b012c9ec411d0407&movieCd=" + mno,
		method: "get",
		success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
			console.log(result);	// result 값을 출력
				printmovie(mno, $(result).find('movieNm').text(), rating, avg, genre, $(result).find('prdtYear').text(),$tr);
		}, error: function(xhr) {	// 에러발생시 
			 console.log(xhr.status);	// 오류번호 발생번호 출력
		}
	});
}

function printmovie(mno, movieNm, rating, avg, genre, prdtyear, $tr){
	
	var $td = $("<td>").appendTo($tr);	// 제목
	$("<a>").attr("href","/moviefactory/movie/read?mno=" + mno).css("font-size","20px").text(movieNm).appendTo($td);
	//$("<td>").text(movieNm).appendTo($tr);	// 제목
	$("<td>").css("font-size","20px").text(rating).appendTo($tr);	// 내가매긴평점
	$("<td>").css("font-size","20px").text(avg).appendTo($tr);	// 평균평점
	$("<td>").css("font-size","20px").text(genre).appendTo($tr);	// 장르
	$("<td>").css("font-size","20px").text(prdtyear).appendTo($tr);	// 제작년도
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







$(function() {
	   console.log(location.search.split('=')[1]);
	   //strArray = location.search.split('?');
	   //console.log(strArray[1].split('=')[0]);
	  	username= location.search.split('=')[1];
	     $.ajax({
	         url: "/moviefactory/api/usermovie/findnickname?username=" + username,
	         method: "get",
	         success: function(result) {
	            console.log(result);
	            $("#title").text(result+"님의 페이지");
	         }
	      });
	     $.ajax({
	         url: "/moviefactory/api/usermovie/usertoprating?username="+ username,
	         method: "get",
	         success: function(result) {
	            //console.log(result);
	            //$("#titul").text(result+"님의 페이지");
	            reviews=result;
	        	 printRating();
	         }
	      });
	     
	     
		   /*
		   
	      $.ajax({
	         url: "/moviefactory/api/movie/review/list?mNo=" + strArray[1].split('=')[1],
	         method: "get",
	         success: function(result) {
	            console.log(result);
	         }
	      });*/
	      $.ajax({
		         url: "/moviefactory/api/usermovie/checkmyname?username="+ username,
		         method: "get",
		         success: function(result) {
		         	if(result=="false"){
		         		$.ajax({
		          		  url: "/moviefactory/api/usermovie/checkfollowing?username=" + username,
		       	         method: "get",
		       	         success: function(result) {
		       	            console.log(result);
		       	            if(result=="true"){
		       	            	$("<button id='unfollow' class='btn btn-default' type='button'>언팔로우</button>").appendTo($("#isfollow"));
		       	            	$("#unfollow").on("click",function(){
		       	     	    	  $.ajax({
		       	     	    		  url: "/moviefactory/api/usermovie/deletefollowing?username=" + username,
		       	     	 	         method: "post",
		       	     	 	         success: function(result) {
		       	     	 	            //console.log(result);
		       	     	 	        	location.reload();
		       	     	 	         }
		       	     	 	      });
		       	     	     	 });
		       	            	
		       	            }else if(result=="false"){
		       	            	$("<button id='follow' class='btn btn-primary' type='button'>팔로우</button>").appendTo($("#isfollow"));
		       	            	$("#follow").on("click",function(){
		       	     	    	  $.ajax({
		       	     	    		  url: "/moviefactory/api/usermovie/addfollowing?username=" + username,
		       	     	 	         method: "post",
		       	     	 	         success: function(result) {
		       	     	 	            //console.log(result);
		       	     	 	            location.reload();
		       	     	 	         }
		       	     	 	      });
		       	     	     	 });
		       	            	
		       	            }
		       	         }
		       	      });
		         	}   
		         
		         }
		 });
	      
	      
	      
	      
	      
	      $("#review").on("click",function(){
	    	  location.href="/moviefactory/usermovie/review?username="+username;
	      });
	      $("#collection").on("click",function(){
	    	  location.href="/moviefactory/collection/list?username="+username+"&pageno=1";
	      });
	      $("#following").on("click",function(){
  	    	  location.href="/moviefactory/usermovie/following?username="+username+"&pageno=1";
  	     	 });     
	      $("#favorite").on("click",function(){
	    	  location.href="/moviefactory/usermovie/favoritemovie?username="+username+"&pageno=1";
	      });
	      
	});
</script>
</head>
<body>
<div id="section">
	<div id="titletop">
		<strong><legend class="text-center" id="title" style="font-size:28pt"></legend></strong>
		<strong><legend class="text-center" id="isfollow" style="font-size:28pt"></legend></strong>
		
	</div>
	<div class="btn-group btn-group-lg">
		<button id="review" class="btn btn-primary">리뷰보기</button>
		<button id="collection" class="btn btn-primary">콜렉션</button>
		<button id="following" class="btn btn-primary">팔로잉목록</button>
		<button id="favorite" class="btn btn-primary">좋아하는 영화 목록</button>
<!-- 		<button id="preferencemovie" class="btn btn-primary">선호할만한 영화 목록</button> -->
		
	</div>
</div>
	<table class="MovieTable">
			<colgroup>
				<col width="30%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="13%">
			</colgroup>
			<thead>
				<tr><!-- /moviefactory/usermovie/userpage?username=dlwndud8120 ㄴ-->
					<th>영화제목</th>
					<th>나의평점</th>
					<th>종합평점</th>
					<th>장르</th>
					<th>제작년도</th>
					<th>포스터</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
</body>
</html>