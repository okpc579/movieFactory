<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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
$(function(){
		 
		$("#report").on("click",function(){
			$("#mRevNo").val(location.search.split('=')[1])
			var param = $("#writeForm").serialize();
			console.log($("#title").val());
			console.log(param);
			console.log($("#mRevNo").val());
			$.ajax({
				if(location.search.split('=')[0] == ""){
					location.href="/moviefactory";
				}
				url: "/moviefactory/api/movie/report",
				method: "post",
				data: param,
				success : function(result) {
					console.log(result);
					alert("신고 완료");
				}, error: function(xhr) {
					console.log(xhr.status);
					alert("이미 신고한 리뷰 입니다.");
				}
			});
	})
});
</script>
<style>
	
	table {
	 width : 800px;
	 margin : 0 auto;
	 text-align: center;
		border-radius: 2px #BDBDBD solid;
	}
	
	th {
	text-align: center;
	background-color : #5CD1E5;
	color: white;
	}
	
	tr {
		text-align:center;
		height: 60px;
	}
	
	#writeForm {
		margin : 0 auto;
		
	}
	#singo555 {
		height : 50px;
	 width : 100px;
	 
	}
</style>
</head>
<body>
<div id="section">
	<form id="writeForm" action="">
	<legend class="text-center" style="font-size:25pt"><strong>신고</strong></legend>
		<div>
			<table>
				<tr>
					<th>문의종류</th>
					<input type="hidden" name="mRevNo" id="mRevNo" value="">
					<th><input type="radio" class="radio-inline" name="mRepCate" value="욕설"> 욕설</th>
					<th><input type="radio" class="radio-inline" name="mRepCate" value="광고"> 광고</th>
					<th><input type="radio" class="radio-inline" name="mRepCate" value="불건"> 불건</th>
					<th><input type="radio" class="radio-inline" name="mRepCate" value="의도적 스포"> 의도적 스포</th>
					<th><input type="radio" class="radio-inline" name="mRepCate" value="도배"> 도배</th>
					<th><input type="radio" class="radio-inline" name="mRepCate" value="기타"> 기타</th>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="6"><input id="title" type="text" name="title"  placeholder="제목을 입력하세요"  class="form-control"></td>
				</tr>
				<tr style="text-align: center">
					<th style="height: 300px; ">내용</th>
					<td style="height: 250px;" colspan="6" ><textarea id="content" name="content" placeholder="내용을 입력하세요" style="height: 250px; "  class="form-control" ></textarea>
				</tr>
				<tr>
					<td colspan="7" id="report" style="height:60px;"><button type="button" id="singo555" class="btn btn-danger">신고</button></td>
				</tr>
			</table>
		</div>
	</form>
	</div>
</body>
</html>