<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
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
var movies;
var posterString;
var repGenreNm;
var genreTopMovies;
var starTopMovies;
var preferenceMovies;
function printList() {
	var $body = $("#index");
	$.each(movies, function(i, movie) {
		
		var $tr = $("<tr>").appendTo($body);
		$("<td>").text(movie.movieCd).appendTo($tr);
		$("<td>").text(movie.movieNm).appendTo($tr);
		$("<td>").text(movie.prdtYear).appendTo($tr);
		$("<td>").text(movie.repGenreNm).appendTo($tr);
		$("<td>").text(movie.repNationNm).appendTo($tr);
		var $td = $("<td>").appendTo($tr)
		
		getPoster(movie, $tr);
		$("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("링크열기").appendTo($td);
		
	});
}
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
				$("<img>").attr("src","http://localhost:8081/sajin/default_movie.png").attr("width", "110px").appendTo($td); 
			}else {
			var $td = $("<td>").appendTo($tr)
			$("<img>").attr("src",result.image).appendTo($td);
			//$("<td>").text(result.image).appendTo($tr);
			}
			
		}, error:function(xhr) {
			console.log(xhr);
		}
	});
}
function printPaging(result) {
	var pageno = page;
	var pagesize = 5;
	var totalcount = totCnt;
	var pagesPerBlock = 10;
	var cntOfPage = totalcount/pagesize + 1;
	if(totalcount%pagesize==0) cntOfPage--;
	var blockNo = Math.floor((pageno-1)/pagesPerBlock);
	var startPage = blockNo * pagesPerBlock + 1;
	var endPage = startPage + pagesPerBlock - 1;
	if(endPage>cntOfPage)
		endPage = cntOfPage;
	
	var $pagination = $("#pagination");	
	var serverUrl = "http://localhost:8081/moviefactory/movie/list?repGenreNm="+ repGenreNm.value;
	// console.log("페이징함수 들어옴");	
	
}

$(function() {
	/*
	var param = {
			mNo: mno
		};
	*/
	$.ajax({
		url: "/moviefactory/api/usermovie/averagerating",
//		data:mno,
		method: "get",
		success: function(result, status, xhr) {
			starTopMovies = result;
			console.log(starTopMovies);
			//printLists();
			
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	var genre = $("#repGenreNm option:selected").val();
	console.log(genre);
	$.ajax({
		url: "/moviefactory/api/usermovie/genretoprating?genre="+genre,
//		data:mno,
		method: "get",
		success: function(result, status, xhr) {
			genreTopMovies = result;
			console.log(genreTopMovies);
			//printLists();
			
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	$("#repGenreNm").on("change", function(){
		genre = $("#repGenreNm option:selected").val();
		console.log(genre);
		$.ajax({
			url: "/moviefactory/api/usermovie/genretoprating?genre="+genre,
//			data:mno,
			method: "get",
			success: function(result, status, xhr) {
				genreTopMovies = result;
				console.log(genreTopMovies);
				//printLists();
				
			}, error: function(xhr) {
				 console.log(xhr.status);
			}
		});
	});
	
			$.ajax({
				url: "/moviefactory/api/usermovie/preferencemovie?username="+loginId,
				method:"get",
				success:function(result) {
					preferenceMovies=result;
					console.log(preferenceMovies);
				}, error : function(xhr) {
					
				}
			});
			 $.ajax({
		         url: "/moviefactory/api/usermovie/findnickname?username=" + loginId,
		         method: "get",
		         success: function(result) {
		            console.log(result);
		            $("#usermovie").text(result+"님이 리뷰한 영화목록");
		         }
		      });
	
});
</script>

<title>Insert title here</title>
<style>
.material-icons.md-18 {font-size:18px;}
.jumbotron {
	background-color: #5CD1E5;
	margin: 0;
	color: #fff;
	padding: 100px 25px;
}

.container-fluid {
	padding: 60px 50px;
}

.navbar {
	margin-bottom: 0;
	background-color: #4ABFD3;
	z-index: 9999;
	border: 0;
	font-size: 12px !important;
	line-height: 1.42857143 !important;
	letter-spacing: 4px;
	border-radius: 0;
}

.navbar li a, .navbar .navbar-brand {
	color: black;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
	color: #000000 !important;
	background-color: #fff !important;
}


.navbar-default .navbar-toggle {
	border-color: transparent;
	color: #fff !important;
}

h5 {
	text-align: center;
}

hr {
	display: block;
	margin-top: 0.5em;
	margin-bottom: 0.5em;
	margin-left: auto;
	margin-right: auto;
	border-style: inset;
	border-width: 1px;
}

#asideleft {
	float: left;
	width: 400px;
	/* background-color: #F6F6F6; */
	height: 1000px;
}

#asideright {
	float: right;
	width: 400px;
	/* background-color: #F6F6F6; */
	height: 1000px;
}
section {
   width:1100px;   
   float:left;
}
#main123 {
   width:1900px;
   height : 1100px;
   overflow: hidden;
}

</style>
</head>
<body>
<div id="page123">
	<nav class="navbar navbar-default navbar-fixed-top"
		style="height: 50px;">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/moviefactory" style="padding-top: 17px; color: white;">무비팩토리</a>
			</div>
			<!-- 무비팩토리 : 홈화면 -->
			
			<!-- 비로그인 : 회원가입 /  로그인 / 고객센터(공지사항,관리자문의게시판,회원의문의게시판,관리자문의게시판) -->
			<sec:authorize access="isAnonymous()">
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right" >
						<li><a href="member/yesorno" style="color: white;">회원가입</a></li>
						<li><a href="member/login" style="color: white;">로그인</a></li>
						<li><a href="notice/list" style="color: white;">공지사항</a></li>
					</ul>
				</div>
			</sec:authorize>

			<!-- 일반회원 : 들어갈 내용 (내소식, 마이페이지(영화), 로그아웃, 고객센터(2단레이아웃 : 공지사항,관리자문의게시판,회원의문의게시판,관리자문의게시판) -->
			<sec:authorize access="hasRole('ROLE_USER')">
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right" >
						<li><a href="#"><img src="/sajin/bell (5).png"></a></li>	<!-- 내소식 : 아직 링크 없음 -->
						<li><a href="#" style="color: white;">내정보</a></li> <!-- 영화마이페이지 : 태호오빠꺼임 -->
						<li><a href="member/logout" style="color: white;">로그아웃</a></li>
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">고객센터 <span class="caret"></span></a>
                    	<ul class="dropdown-menu">
                      		<li><a href="adminAsk/listuser">문의 게시판</a></li>
                      		<li><a href="notice/list">공지사항</a></li>
                    	</ul>
					</ul>
				</div>
			</sec:authorize>

			<!--  관리자 : 관리자센터(2단 레이아웃 : 블라인드댓글관리, 블라인드 리뷰관리, 영구정지 관리) 고객센터(2단 레이아웃 : 공지사항,관리자문의게시판,회원의문의게시판,관리자문의게시판), 로그아웃  -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right" >
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">관리자<span class="caret"></span></a>
	    	                <ul class="dropdown-menu">
    	    	              <li><a href="admin/blindcmntlist">블라인드댓글</a></li>
                	      	  <li><a href="admin/blindrevlist">블라인드리뷰</a></li>
                    		  <li><a href="admin/blocklist">영구정지</a></li>
                    		</ul>
	                    </li> 
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">고객센터 <span class="caret"></span></a>
                    		<ul class="dropdown-menu">
	                	      <li><a href="adminAsk/list">문의 게시판</a></li>
		                      <li><a href="notice/list">공지사항</a></li>
        		            </ul>
            		    </li> 
						<li><a href="member/logout" style="color: white;">로그아웃</a></li>
					</ul>
				</div>
			</sec:authorize>
		</div>
	</nav>
	<!-- 헤더 : 검색가능 -->
	<div class="jumbotron text-center">
		<h1>Movie Factory</h1>
		<form class="form-inline" action="movie/list">
			<div class="input-group">
				<input type="text" class="form-control" size="50"
					placeholder="영화를 검색해주세요" required id="query" name="query">
				<div class="input-group-btn">
					<button class="btn btn-info" id="button">검색</button>
				</div>
			</div>
		</form>
	</div>
<div id="main123">
	<!-- 사이드 -->
	<div id="asideleft"></div>

	<!-- 내용부분 -->
	<section>
		<br>
		<hr>
		
			<!-- <table class="table table-hover"> -->
			<!-- 장르를 선택하여 평균점수가 높은 영화 5개 -->
			<p>장르별 평점 상위 영화</p>
			<select id="repGenreNm" name="repGenreNm">
				<option value="애니메이션">애니메이션</option>
				<option value="액션">액션</option>
				<option value="사극">사극</option>
				<option value="SF">SF</option>
				<option value="범죄">범죄</option>
				<option value="가족">가족</option>
				<option value="드라마">드라마</option>
				<option value="멜로/로맨스">멜로/로맨스</option>
				<option value="코미디">코미디</option>
				<option value="판타지">판타지</option>
				<option value="공포(호러)">공포(호러)</option>
				<option value="어드벤처">어드벤처</option>
				<option value="성인물(에로)">성인물(에로)</option>
				<option value="미스터리">미스터리</option>
			</select> <br> <br>
			<table class="GenreTopTable">
				<colgroup>
					<col width="20%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<thead>
					<tr>
						<th>제목</th>
						<th>제작년도</th>
						<th>장르</th>
						<th>제작국가</th>
						<th>포스터</th>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
			</table>
			<br>
			<hr>
			<!-- 모든 영화중에 평점이 높은 영화 5개 -->
			<p>평균 평점 상위 영화</p>
			<table class="StarTopTable">
				<colgroup>
					<col width="20%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
					<col width="40%">
				</colgroup>
				<thead>
					<tr>
						<th>제목</th>
						<th>제작년도</th>
						<th>장르</th>
						<th>제작국가</th>
						<th>포스터</th>
					</tr>
				</thead>
				<tbody id="list">
				</tbody>
			</table>
			<br>

			<!-- 유저가 좋아하는 장르중에 안본 평점 상위 영화 -->

			<!-- 비회원, 관리자는 안보임 -->
			<!--
		<hr>
		<p>OO님이 좋아하실 영화</p>
		<table class="UserLikeTable">
			<colgroup>
				<col width="20%">
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="40%">
			</colgroup>
			<thead>
				<tr>
					<th>제목</th>
					<th>제작년도</th>
					<th>장르</th>
					<th>제작국가</th>
					<th>포스터</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
		-->


			<!--  로그인 회원  -->
			<sec:authorize access="hasRole('ROLE_USER')">
				<hr>
				<p id="usermovie"></p>
				<table class="UserLikeTable">
					<colgroup>
						<col width="20%">
						<col width="10%">
						<col width="20%">
						<col width="10%">
						<col width="40%">
					</colgroup>
					<thead>
						<tr>
							<th>제목</th>
							<th>제작년도</th>
							<th>장르</th>
							<th>제작국가</th>
							<th>포스터</th>
						</tr>
					</thead>
					<tbody id="list">
					</tbody>
				</table>
			</sec:authorize>

	

		<div class="alert alert-success alert-dismissible" id="alert"
			style="display: none;">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			<strong>서버 메시지</strong>&nbsp;&nbsp;&nbsp;<span id="msg"></span>
		</div>
	</section>
	
	<!-- 사이드 -->
	<div id="asideright"></div>
	<br>
	<!-- <form action="movie/list">
		<input type="text" id="query" name="query">
		<button id="button">검색</button>
	</form> -->
</div>

	<!-- 푸터 -->
	<footer>
		<hr>
		<h5>♥8ㅅ8이 만든 무비팩토리♥</h5>
	</footer>
	</div>
</body>
</html>