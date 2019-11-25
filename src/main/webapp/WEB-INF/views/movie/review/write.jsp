<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>

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


$(function() {
	$("#star1").click(function(){
		$("#hidden").val(1);
		$("#rating").text("1점");
	})
	$("#star2").click(function(){
		$("#hidden").val(2);
		$("#rating").text("2점");
	})
	$("#star3").click(function(){
		$("#hidden").val(3);
		$("#rating").text("3점");
	})
	$("#star4").click(function(){
		$("#hidden").val(4);
		$("#rating").text("4점");
	})
	$("#star5").click(function(){
		$("#hidden").val(5);
		$("#rating").text("5점");
	})
	$("#reg").on("click", function() {
		var param = $("#writeForm").serialize();
		console.log(param);
		$.ajax({
			url: "/moviefactory/api/movie/review/write",
			data:param,
			method: "post",
			success: function(result, status, xhr) {
				console.log(result);
				moviereview = result;
			}, error: function(xhr) {
				 console.log(xhr.status);
			}
		});
	});
	$('input[name=isSpo]').click(function(){
		$("#isSpo").val(1);
	});
});

</script>	
<style>
*{
	margin:0;
	padding:0;
}
.starRev{
	display: inline-block;
}
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
#stars{
	width:160px;
	height:40px;
}
.center{
	margin:0 auto;
}
</style>
</head>
<body>
<form id="writeForm" action="">
		<div>
			<table>
				<tr>
				<input id="mRevNo" type="hidden" value="1" name="mRevNo">
				<input id="genre" type="hidden" value="액션" name="genre">
				<input id="writingDate" type="hidden" value="2019-11-15" name="writingDate">
				<input id="writer" type="hidden" value="" name="username">
				<input id="mNo" type="hidden" value="3" name="mNo">
				<input id="hidden" type="hidden" value="" name="rating">
					<td id="title">영화 제목</td>
				</tr>
				<tr>
					<td>리뷰번호 : <span id="revno" name="mRevNo"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span> 작성날짜 : <span id="writDay" name="writingDate"></span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
						별점 : <span id="rating" name="rating"></span></td>
				</tr>
				<tr>
					<td >
						<div id="stars" class="starRev" >
							<div class="center" style="width: 150px; height: 30px; margin: 5px;">
								<div style="overflow:hidden; display: inline-block;">
 									<span style="float:left;" class="starR" id="star1" style="display:inline-block">별1</span>
  									<span style="float:left;" class="starR" id="star2" style="display:inline-block">별2</span>
  									<span style="float:left;" class="starR" id="star3" style="display:inline-block">별3</span>
  									<span style="float:left;" class="starR" id="star4" style="display:inline-block">별4</span>
  									<span style="float:left;" class="starR" id="star5" style="display:inline-block">별5</span>
  								</div>
  							</div>		
						</div>
<script>

	$('.starRev span').hover(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  return false;
	});
	
	$('.starRev span').click(function(){
		  console.log($(this));
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  return false;
	});
	$('.starRev').mouseleave(function(){
		
		if($("#hidden").val()==1){
			console.log("1임");
			$("#star1").parent().children('span').removeClass('on');
			$("#star1").addClass('on').prevAll('span').addClass('on');
		}else if($("#hidden").val()==2){
			console.log("2임");
			$("#star2").parent().children('span').removeClass('on');
			$("#star2").addClass('on').prevAll('span').addClass('on');
		}else if($("#hidden").val()==3){
			console.log("3임");
			$("#star3").parent().children('span').removeClass('on');
			$("#star3").addClass('on').prevAll('span').addClass('on');
		}else if($("#hidden").val()==4){
			console.log("4임");
			$("#star4").parent().children('span').removeClass('on');
			$("#star4").addClass('on').prevAll('span').addClass('on');
		}else if($("#hidden").val()==5){
			console.log("5임");
			$("#star5").parent().children('span').removeClass('on');
			$("#star5").addClass('on').prevAll('span').addClass('on');
		}
		return false;
	});
	
	
	
</script>						
</td>
				</tr>
				<tr>
					<td><textarea id="content" name="mRevContent"placeholder="내용을 입력하세요" style="width: 543px; height: 231px; "></textarea><br><input id="isSpo"type="checkbox" value="" name="isSpo">스포일러</td>
				</tr>
				<tr>
					<td><button type="button" id="reg">작성하기</button></td>
				</tr>
			</table>
		</div>
</form>
</body>
</html>