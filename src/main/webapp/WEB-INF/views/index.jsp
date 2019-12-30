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
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
</head>
      
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
	// 로그아웃 처리 - 주소는 스프링 시큐리티로 설정. post로 요청해야함
	$(".logout123").on("click", function(e) {	
		e.preventDefault();
		$.ajax({
			url:"/moviefactory/member/logout",
			method:"post",
			success:function() {
				location.href = "/moviefactory"
			}
		})
	});
	
	$("#sosick").on("click", function() {
		window.open('/moviefactory/alarm', 'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');	
	});
});

var movies;
var posterString;
var repGenreNm;
var genreTopMovies;
var starTopMovies;
var preferenceMovies;

function getMovieDetail(mno, rating, $li){   // 영화번호, 별점, 장르를 tr에 넣는다
	   $.ajax({   
	      url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=e2ef68048ccb5620b012c9ec411d0407&movieCd=" + mno,
	      method: "get",
	      success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
	         console.log(result);   // result 값을 출력
	            printmovie(mno, $(result).find('movieNm').text(), rating, $(result).find('prdtYear').text(),  $li);
	      }, error: function(xhr) {   // 에러발생시 
	          console.log(xhr.status);   // 오류번호 발생번호 출력
	      }
	   });
	}

	function printmovie(mno, movieNm, rating, prdtyear, $li){
	   
	   var $div = $("<div>").appendTo($li);
	   var $div2 = $("<div>").css("width", "150px").appendTo($li);
	   //getPoster2(movieNm, prdtyear, $div);
	   //var $a = $("<a>").attr("href","/moviefactory/movie/read?mno=" + mno).text(movieNm).appendTo($div2);
	   var $a = $("<a>").attr("href","/moviefactory/movie/read?mno=" + mno).appendTo($div);
	   getPoster2(movieNm, prdtyear, $a);
	   //$("<td>").text(movieNm).appendTo($tr);   // 제목
	   //$("<div>").text("평점 : "  + rating).appendTo($li);   // 평점
	   $("<div>").text(movieNm).css("overflow","hidden").css("white-space","nowrap").css("text-overflow","ellipsis").css("color","black").css("font-weight","bold").appendTo($div2);   // 제목
	   var $i = $("<i>").attr("class","fas fa-star").css("color","red").appendTo($div2);	//별모양
	   $("<span></span>").text(" 평점 : "  + rating).css("color","black").appendTo($div2);   // 평점

	
	        // 포스터
	   /* $("<a>").attr("href","/moviefactory/movie/read?mno=" + movie.movieCd).text("영화정보").appendTo($td); */
	}

	function getPoster2(movieNm, prdtYear, $li) {   // (영화제목,제작년도)로 포스터 불러오는 기능
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
	         if(typeof result.image == "undefined"){   // 이미지가 정해지지 않을 경우
	            var $div = $("<div>").appendTo($li)   // td에 tr를 넣어라
	            $("<img>").attr("src","/sajin/default_movie.png").attr("height","200px").attr("width", "150px").appendTo($li); 
	         }else {
	        	 var $div = $("<div>").appendTo($li)   // 이미지가 들어있는 td를 tr에 넣어라
	         $("<img>").attr("src",result.image).attr("height","200px").attr("width", "150px").appendTo($li);   // result.image를 td안에 넣어라
	         //$("<td>").text(result.image).appendTo($tr);
	         }
	         
	      }, error:function(xhr) {
	         console.log(xhr);
	      }
	   });
	}
	
   function printstm() {
	var $body = $("#alist");
	$.each(starTopMovies, function(i, starTopMovie) {
		
		var $li = $("<li>").attr("class","lists").appendTo($body);
		//$("<td>").text(starTopMovie.mno).appendTo($tr);
		//$("<td>").text(starTopMovie.rating2).appendTo($tr);
		getMovieDetail(starTopMovie.mno, starTopMovie.rating2, $li);
		});	
	}  
  
  function printu() {
	  var $body = $("#ulist");
		 $.each(preferenceMovies, function(i, preferenceMovie) {
			var $li = $("<li>").attr("class","lists").appendTo($body);
			//$("<td>").text(preferenceMovie.mno).appendTo($tr);
			getMovieDetail(preferenceMovie.mno, preferenceMovie.rating2, $li);
			//$("<td>").text(preferenceMovie.rating2).appendTo($tr);
			});	 
	  
  }
  
  function printgr() {
	  var $body = $("#glist");
		$.each(genreTopMovies, function(i, genreTopMovie) {
			var $li = $("<li>").attr("class","lists").appendTo($body);
			//$("<td>").text(genreTopMovie.mno).appendTo($tr);
			getMovieDetail(genreTopMovie.mno, genreTopMovie.rating2, $li);
			//$("<td>").text(genreTopMovie.rating2).appendTo($tr);
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
	var serverUrl = "/moviefactory/movie/list?repGenreNm="+ repGenreNm.value;
	 console.log("페이징함수 들어옴");	
	
}

$(function() {
	/* var param = {mNo: mno}; */
	$("#myinfo").on("click", function() {
		console.log("입력함");
		location.href="/moviefactory/usermovie/userpage?username="+loginId;	
	});
	 
	$.ajax({
		url: "/moviefactory/api/usermovie/averagerating",
//		data:mno,
		method: "get",
		success: function(result, status, xhr) {
			starTopMovies = result;
			console.log(starTopMovies);
			printstm();
			
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
			printgr();
		}, error: function(xhr) {
			 console.log(xhr.status);
		}
	});
	
	
	$("#repGenreNm").on("change", function(){
		$("#glist>*").remove();
		genre = $("#repGenreNm option:selected").val();
		console.log(genre);
		$.ajax({
			url: "/moviefactory/api/usermovie/genretoprating?genre="+genre,
//			data:mno,
			method: "get",
			success: function(result, status, xhr) {
				genreTopMovies = result;
				console.log(genreTopMovies);
				printgr();
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
				 printu(); 
			}, error : function(xhr) {
					
			}
		});
			
	 $.ajax({
		       url: "/moviefactory/api/usermovie/findnickname?username=" + loginId,
		       method: "get",
		       success: function(result) {
		          console.log(result);
		          $("#usermovie").text(result);
		       }
		    });
		});

	
</script>

<title>무비팩토리</title>
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
	width: 20%;
	display: inline-block;
	height: 1px;
}

#asideright {
	float: right;
	width: 20%;
	
}
section {
   width:60%;   
   float:left;
}
#main123 {
   height : 100%;
   overflow: hidden;
   
}

.lists {
display: inline-block;
margin : 0 auto;
padding : 30px;
}


#ulist, #glist, #alist {
	margin : 0 auto;
}

ul, li { list-style:none; }

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
						<li><a href="#" id="sosick"><img src="/sajin/bell (5).png"></a></li>	<!-- 내소식 : 아직 링크 없음 -->
						<li><a href="#" style="color: white;" id="myinfo">내정보</a></li> <!-- 영화마이페이지 : 태호오빠꺼임 -->
						<li><a href="member/logout" style="color: white;" class="logout123">로그아웃</a></li>
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
						<li><a href="member/logout" style="color: white;" class="logout123">로그아웃</a></li>
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
			<h3 style="font-weight: bold"><i class="fas fa-film" ></i> 장르별 평점 상위 영화</h3>
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
			<div class="GenreTopTable">
				<ul id="glist">
				</ul>
			</div>
			<br>
			<hr>
			<!-- 모든 영화중에 평점이 높은 영화 5개 -->
			<h3 style="font-weight: bold"><i class="fas fa-film" ></i> 평균 평점 상위 영화</h3>
			<div class="StarTopTable" >
				<ul id="alist">
				</ul>
			</div>
			<br>

			<!-- 유저가 좋아하는 장르중에 안본 평점 상위 영화 -->

			<!--  로그인 회원  -->
			<sec:authorize access="hasRole('ROLE_USER')">
				<hr>
				<h3 style="font-weight: bold"><i class="fas fa-hand-holding-heart " style="color:#FFB2D9"></i> <span id="usermovie"></span> 님 이 영화 어때요? :)</h3>
				<div class="UserLikeTable">
					<ul id="ulist">
					</ul>
				</div>
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
</div>

	<!-- 푸터 -->
	<footer>
		<hr>
		<h5>♥8ㅅ8이 만든 무비팩토리♥</h5>
	</footer>
	</div>
</body>
</html>