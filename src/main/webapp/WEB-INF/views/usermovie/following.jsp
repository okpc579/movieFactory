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
	#following, #follower {
		font-size: 20px;
	}
	table {
	margin-top: 100px;
	}
	.following_table {
	width:500px; 
	height:200px; 
	border:1px solid red; 
	float:left;
	margin-right:15px;
	}
	
	.follower_table {
	width:500px; 
	height:200px; 
	border:1px solid red; 
	float:right;
	}
	
	table, th, td {
    width : 800px;
    margin : 0 auto;
    text-align: center;
    border: 1px black solid;
    border-color: #EAEAEA;  
	}
   
   	th {
   	background-color: #5CD1E5;
   	color: white;
   	font-size: 25px;
	}
</style>
  <script>
  var followers;
  var followings;
  function printfollower() {
	  console.log("printfollower");
	  var $body = $("#follower_list");
	  $.each(followers,function(i, follower){	// 반복문 리뷰를 참조
		  var $tr = $("<tr>").appendTo($body);	//$body안에 tr넣는다
//		  $("<td>").text(follower.followerUsername).appendTo($tr);	// 별점
		  var $td = $("<td>").appendTo($tr);	// 제목
		  $("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + follower.followerUsername).text(follower.followerUsername).appendTo($td);
		  //$("<a>").appendTo($tr);
		  //getMovieDetail(review.mno, review.rating, review.genre, $tr);
		  });	// tr안에 넣는다 리뷰안에 영화번호,별점,장르 
	}
  function printfollowing() {
	  console.log("printfollowing");
	  var $body = $("#following_list");	
	  $.each(followings,function(i, following){	// 반복문 리뷰를 참조
		  var $tr = $("<tr>").appendTo($body);	//$body안에 tr넣는다
		  var $td = $("<td>").appendTo($tr);	// 제목
		  //$("<td>").text(following.followingUsername).appendTo($tr);	// 별점
		  $("<a>").attr("href","/moviefactory/usermovie/userpage?username=" + following.followingUsername).text(following.followingUsername).appendTo($td);
		  //$("<a>").appendTo($tr);
		  //getMovieDetail(review.mno, review.rating, review.genre, $tr);
		  });	// tr안에 넣는다 리뷰안에 영화번호,별점,장르 
	}
  
  
  
  
  
//3. 유저이름으로 영화 불러오기
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
  	          	
  	            $("#user_name").text(result+"님이 팔로잉 / 팔로워");
  	         }
        });
        
        
        
        $.ajax({
			url: "/moviefactory/api/usermovie/follower?username="+location.search.split("=")[1],
			method:"get",
			success:function(result) {
				console.log(result);
				followers = result;
				printfollower();
			}, error : function(xhr) {
				
			}
		});
		$.ajax({
			url: "/moviefactory/api/usermovie/following?username="+location.search.split("=")[1],
			method:"get",
			success:function(result) {
				followings = result;
  	          	printfollowing();
				}, error : function(xhr) {
					}
		});
  });  
	  

  </script>
  </head>
  <body>
  <div id="section">
  	<div id="preference_menu">
  		<strong><legend class="text-center" id="user_name" style="font-size:28pt"></legend></strong>
	  		<div id="following">
	  		<table class="following_table">
	  			<thead>
	  				<tr>
	  					<th>팔로잉 유저</th>
	  				</tr>
	  			</thead>
	  			<tbody id="following_list">
	  			</tbody>
	  		</table>
	  		</div>
	  		<div id="follower">
	  			<table class="follower_table">
	  			<thead>
	  				<tr>
	  					<th>팔로우 유저</th>
	  				</tr>
	  			</thead>
	  			<tbody id="follower_list"">
	  			</tbody>
	  		</table>
	  		</div>
  		</div>
	</div>
</body>
</html>