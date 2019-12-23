<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	var movie;
	var m_no;
	var genre="";
	var actor="";
	var cast="";
	var $tr11;
	var $tr10;
	var $body;

	function printList() {
		$body = $("#read");
		var $head = $("#head_");
		
		var $tr = $("<tr>").appendTo($body);
		var $tr1 = $("<tr>").appendTo($body);
		var $tr2 = $("<tr>").appendTo($body);
		var $tr3 = $("<tr>").appendTo($body);
		var $tr4 = $("<tr>").appendTo($body);
		var $tr5 = $("<tr>").appendTo($body);
		var $tr6 = $("<tr>").appendTo($body);
		var $tr7 = $("<tr>").appendTo($body);
		var $tr8 = $("<tr>").appendTo($body);
		$tr9 = $("<tr>").appendTo($body);
		$tr10 = $("<tr>").appendTo($body);
		$tr11 = $("<tr>").appendTo($body);
		var $tdh = $("<td colspan='2'>").appendTo($tr11);
		
		
		$("<input>").text(movie.movieCd).attr("type","hidden").appendTo($tr9);
		$("<th colspan='2'>").text(movie.movieNm).css("font-size","25pt").attr("class","head_detail").appendTo($head);
		$("<td>").text("제작년도 : "+movie.prdtYear).attr("class","m_info").appendTo($tr2);
		if(movie.openDt==null){
			$("<td>").text("개봉일 : "+"정보가 없습니다.").attr("class","m_info").appendTo($tr3);
		}else{
			$("<td>").text("개봉일 : "+movie.openDt).attr("class","m_info").appendTo($tr3);
		}
		$("<td>").text("제작 국가 : "+movie.nationNm).attr("class","m_info").appendTo($tr4);
		
		//포문
		$.each(movie.genres, function(i, g) {
			if(i==0){
				genre = g;
			}else{      
				genre = genre +", " + g;
			}
		})
		$("<td>").text("장르 : "+genre).attr("class","m_info").appendTo($tr5);
		$("<td>").text("감독 : "+movie.directors).attr("class","m_info").appendTo($tr6);
		$.each(movie.actors,function(i,g){
			//actor = actor +"," + movie.actors[i];
			if(i==0){
				actor = g;
			}else{
				actor = actor + ", " + g;
				if(i==10){
					return false;
				}
			}
		});
		if(movie.actors==null){
			$("<td>").text("배우 : "+"정보가 없습니다.").attr("id","actor").attr("class","m_info").appendTo($tr7);
		}else {
			$("<td>").text("배우 : "+actor).attr("id","actor").attr("class","m_info").appendTo($tr7);		
		}
		if(movie.watchGradeNm==null){
			$("<td>").text("관람가 : "+"정보가 없습니다.").attr("class","m_info").appendTo($tr8);
		}else{
			$("<td>").text("관람가 : "+movie.watchGradeNm).attr("class","m_info").appendTo($tr8);
		}
		getPoster(movie, $tr2);

			$("<img>").attr("src","/sajin/heart2.png").attr("id","like").appendTo($tdh);
			$("<img>").attr("src","/sajin/emptyheart2.png").attr("id","unlike").appendTo($tdh);
			$("#like").hide();
			$("#unlike").hide();
		
	}
	function getPoster(movie, $tr2) {
		console.log(movie);
		$.ajax({
			url:"/moviefactory/api/image?subtitle=" + movie.movieNm + "&pubData=" + movie.prdtYear,
			method: "get",
			success:function(result) {
				console.log(result.image);
				//posterString = result.image;
				if(typeof result.image == "undefined"){
					var $td = $("<td rowspan='9'>").appendTo($tr2)
					$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("width", "120px").appendTo($td); 
				}else {
				var $td = $("<td rowspan='9'>").appendTo($tr2)
				$("<img>").attr("src",result.image).attr("width", "250px").appendTo($td);
				//$("<td>").text(result.image).appendTo($tr);
				}
				
			}, error:function(xhr) {
				console.log(xhr);
			}
		});
	}
	
	function like(){
		m_no = location.search.split("=")[1];
		console.log("TTTTTTTTTTTTTTTTTTTTTTTTT");
		//var $body = $("#read");
		//$tr10 = $("<tr>").appendTo($body);
		$.ajax({
			url:"/moviefactory/api/usermovie/checkfavoritemovie?mNo="+m_no,
			method:"get",
			success:function(result, status, xhr){
				console.log(result);
				if(result=="true"){
					$("#like").show();
				} else if(result=="false"){
					$("#unlike").show();
				}
				$("#like").on("click",function(){
					var param = {
							mNo : m_no
					}
					$.ajax({
						url:"/moviefactory/api/usermovie/deletefavoritemovie",
						method:"post",
						data:param,
						success:function(result){
							console.log(result);
							$("#like").hide();
							$("#unlike").show();
							result="false";
						},error:function(xhr){
							console.log(xhr);
						}
					});
				});
				$("#unlike").on("click",function(){
					var param = {
							mNo : m_no
					}
					console.log(param);
					$.ajax({
						url:"/moviefactory/api/usermovie/addfavoritemovie",
						method:"post",
						data:param,
						success:function(result){
							console.log(result);
							$("#unlike").hide();
							$("#like").show();
							result="true";
						},error:function(xhr){
							console.log(xhr);
						}
					});
				});
			},error:function(xhr){
				console.log(xhr);
			}
		});
	};
	
	function avg(){
		m_no = location.search.split("=")[1];
		$.ajax({
			url:"/moviefactory/api/movie/review/movieavgrating?mNo="+ m_no,
			method:"get",
			success:function(result){
				console.log(result);
				$("<td>").text("평점 : "+result).attr("class","m_info").appendTo($tr10);
			},error:function(xhr){
				console.log(xhr);
				$("<td>").text("평점 : "+"아직 작성된 리뷰가 없습니다.").attr("class","m_info").appendTo($tr10);
			}
		});
	};
	
	$(function() {
		$("#back").on("click",function(){
			history.back(-1);
		});
		m_no = location.search.split("=")[1];
		$.ajax({
			url:"/moviefactory/api/read?mno=" + m_no,	//디테일 리드
			method: "get",
			success:function(result) {
				console.log(result);
				movie = result;
				printList();
				avg();
				if(isLogin==true){
					like();
				}
			}, error:function(xhr) {
				
			}
		});
		console.log(m_no);
		
		//로그인되있을때 해야됨
		
		if(isLogin ==true){
			$.ajax({
				url:"/moviefactory/api/movie/review/myreview?mno=" + m_no,	//디테일 리드
				method: "get",
				success:function(result) {
					console.log(result);
					if(result==""){
						$("<button type='button'>").attr("id","revWrite").attr("class","btn btn-primary").text("리뷰 작성").appendTo($("#review"));
					}else{
						$("<button type='button'>").attr("id","updateWrite").attr("href","/moviefactory/movie/review/read?mrevNo=" + result.mrevNo).attr("class","btn btn-primary").text("리뷰수정").appendTo("#review");
						console.log(result.mrevNo);
					}
					$("#revWrite").on("click", function() {
						if(isLogin==true){
							console.log(m_no);
							location.href="/moviefactory/movie/review/write?mno="+m_no;
						}
						else{
							location.href="/moviefactory/member/login"
						}
					});
				}, error:function(xhr) {
			}
		});
		}
		
		
		$("#revWrite").on("click", function() {
			if(isLogin==true){
				console.log(movie);
			console.log(m_no);
			//location.href="/moviefactory/movie/review/write?mno="+m_no;
			}
			else{
				location.href="/moviefactory/member/login"
			}
		});
		
		$("#bttn").on("click", function() {
			location.href="/moviefactory/movie/review/list?mno="+m_no;
		});
		
	});
</script>
<style>
	table {
		 text-align: center;
	}
	th {
		text-align : center;
	}
	#head_{
		 margin : 10px;
		 border : 1px white;
		 border-radius: 10px;
		 background: #4ABFD3;
		 height : 50px;
	}
	#bttn, #revWrite, #updateWrite {
		height: 50px;
   		width: 100px;
	}
	#bttn {
		float : left;
	}
	#revWrite,#updateWrite {
		margin : 0 auto;
		float : right;
	}
	#review {
		overflow : hidden;
	}
	.head_detail {
		margin : 10px;
		height : 20px;
		color : #fff;
		font-size : 12pt;
		text-align : center;
		/* text-shadow: 2px 2px 2px gray; */
	}
	.m_info {
		font-size : 13pt;
		text-align : left;
	}
	#unlike:hover{
		cursor : pointer;
	}
	#like:hover{
		cursor : pointer;
	}
	#back{
		width : 60px;
		height : 60px;
	}
	#back:hover{
		cursor : pointer;
	}
	/* .MovieTable, #head, .m_info, tr {
		border : 1px solid;
	} */
/* 	.code, . {
		width : 10%;
	} */
</style>
</head>
<body>
<div id="fuck">
<form action="/moviefactory/movie/review/write" method="get">
		<!-- <table class="table table-hover"> -->
		<table class="MovieTable">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="9%">
				<col width="9%">
				<col width="8%">
				<col width="11%">
				<col width="11%">
				<col width="6%">
				<col width="13%">
			</colgroup>
			<thead id="head">
				<!-- <tr id="head_">
					<th class="head_detail">제목</th>
					<th class="head_detail">제작년도</th>
					<th class="head_detail">개봉년도</th>
					<th class="head_detail">제작국가</th>
					<th class="head_detail">장르</th>
					<th class="head_detail">감독</th>
					<th class="head_detail">배우</th>
					<th class="head_detail">관람가</th>
				</tr> -->
				<tr id="head_">
					<!-- <img src="/sajin/ar.svg" id="back"> -->
					<!-- <th colspan="2" class="head_detail">영화정보</th> -->
				</tr>
			</thead>
			<tbody id="read">
			</tbody>
		</table>
		<br><br><br>
		<div id="review">
		<button id="bttn" class="btn btn-primary" type="button">리뷰 목록</button>
		</div>
		<div id="readRev">
		</div>
</form>
</div>
</body>
</html>
