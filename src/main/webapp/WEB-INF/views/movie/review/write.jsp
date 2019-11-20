<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<title>Insert title here</title>
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

var moviereview;
function printData() {
	$("#writer").text(moviereview.username);
	$("#revno").text(moviereview.mRevNo);
	$("#writeDay").text(moviereview.writingDate);
	$("#content").text(moviereview.mRevContent);
}
$("#reg").on("click", function() {
		$.ajax({
		url: "/moviefactory/api/movie/review/write",
		method: "post",
		success: function(result,status,xhr) {
			console.log(result);
			moviereview = result
			printData();
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
});
</script>	
<style>
.starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
table{
		border: 1px solid #444444;
		border-collapse: collapse;
		width:700px;
		height:400px;
		text-align: center;
		margin:0;
		padding: 10px;
	}
	td{
		border: 1px solid #444444;
	}
</style>
</head>
<body>
		<div>
			<table>
				<tr>
					<td id="title">영화 제목</td>
				</tr>
				<tr>
					<td>리뷰번호 : <span id="revno"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span> 작성날짜 : <span id="writDay"></span></td>
				</tr>
				<tr>
					<td><div class="starRev">
  <span class="starR on">별1</span>
  <span class="starR">별2</span>
  <span class="starR">별3</span>
  <span class="starR">별4</span>
  <span class="starR">별5</span>
</div>
<script>
	$('.starRev span').click(function(){
  $(this).parent().children('span').removeClass('on');
  $(this).addClass('on').prevAll('span').addClass('on');
  return false;
});

</script>						
</td>					
				</tr>
				<tr>
					<td><textarea id="content" placeholder="내용을 입력하세요" style="width: 543px; height: 231px; "></textarea><br><input type="checkbox" value="spo" name="spo">스포일러</td>
				</tr>
				<tr id="rege">
					<td><button id="reg">작성하기</button></td>
				</tr>
			</table>
		</div>
</body>
</html>