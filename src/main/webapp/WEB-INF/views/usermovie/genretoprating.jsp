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
</style>
<script>

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
	            $("#user_name").text(result+"님 장르별 상위 영화");
	         }
      });
});

$(function() {
	$.ajax({
		url: "/moviefactory/api/usermovie/genretoprating?username="+location.search.split("=")[1],
		method:"get",
		success:function(result) {
			console.log("성공");
			console.log(result);
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
		<table class="preference_table">
			<colgroup>
  				<col width="36%">
  				<col width="15%">
  				<col width="26%">
  				<col width="10%">
  				<col width="13%">
			</colgroup>
			<thead>
				<tr>
					<th>영화 제목</th>
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
	<div id="paging">
		<ul class="pagination" id="pagination">
			<!-- 
			<li class="previous"><a href="#"><</a></li>
			<li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li class="next"><a href="#">></a></li>
			 -->
		</ul>
	</div>
	</div>
</body>
</html>