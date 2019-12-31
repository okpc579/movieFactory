<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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
					console.log("아 제발좀");
					location.href = "/moviefactory"
				}
			})
		});
		
		$("#sosick").on("click", function() {
			window.open('/moviefactory/alarm', 'window','width=400, height=400, status=no,toolbar=no,scrollbars=no, location=no');	
		});
		$("#myinfo").on("click", function() {
			location.href="/moviefactory/usermovie/userpage?username="+loginId;	
		});
		
		
	});
</script>
<title>무비팩토리 인덱스</title>

<style>
  * {
   margin: 0;
   padding: 0;
}
.jumbotron {
   background-color: #5CD1E5;
   color: #fff;
   padding: 10px 25px;
}

.container-fluid {
   padding: 60px 50px;
   width: 2000px;
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

/* div {
    display: block;
} */

#conooo {
    width: 100%;
}

#title123 {
    width: 33%;
    overflow: hidden;
    float: left;
}

#search {
    width: 33%;
    margin: 0 auto;
    margin-top: 7px;
    display: inline-block;
}


#myNavbar {
    /* width: 33%; */
    /* overflow: hidden; */
    float: right;
    /* margin: 0 auto; */
}

#sosick {
	padding-top: 13px;
	padding-bottom: 13px;
}


.navbar li a, .navbar .navbar-brand {
   color: black;
}

.dropdown-menu>li>a {
  color : #333;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
   color: #000000 !important;
   background-color: #fff !important;
}

.navbar-brand, .join, .login, .dropdown {
   color : white;
  }
</style>

</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top"
		style="background-color: #4ABFD3">
		<div class="container" id="conooo">
			<div class="navbar-header" id="title123">
				<div style="width: 100%; height: 100%;"></div>
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- <a class="navbar-brand" href="#myPage" style="float: right;">무비팩토리</a>  -->
				<a class="navbar-brand" href="/moviefactory/"
					style="padding-left: 381.5px; color:white;">무비팩토리</a>
			</div>
			<!-- 무비팩토리 : 홈화면 -->

			<!-- 검색 -->
			<div class="center text-center" id="search">
				<form class="form-inline" action="/moviefactory/movie/list">
					<!-- <div class="input-group" style="float: left;"> -->
					<div class="input-group" style="padding-right: 80px;">
						<input type="text" class="form-control" size="50"
							placeholder="영화를 검색해주세요" required id="query" name="query">
						<div class="input-group-btn">
							<button class="btn btn-info">검색</button>
						</div>
					</div>
				</form>
			</div>

			<!--  비회원 -->
		<sec:authorize access="isAnonymous()">
            <div class="myNavbar" id="myNavbar">
               <ul class="nav navbar-nav navbar-right" style="padding-right: 80px;">
                  <li><a href="/moviefactory/member/join" style="color: white;">회원가입</a></li>
                  <li><a href="/moviefactory/member/login" style="color: white;">로그인</a></li>
                  <li><a href="/moviefactory/notice/list" style="color: white;">공지사항</a></li>
                  </ul>
            </div>
         </sec:authorize>
			<!--  양식
     <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#about">회원가입</a></li>
        <li><a href="#services">로그인</a></li>
        <li><a href="#portfolio">고객센터</a></li>
      </ul>
    </div>
  -->

			<!--  로그인 회원 -->
			<sec:authorize access="hasRole('ROLE_USER')">

				<div id="myNavbar">
					<ul class="nav navbar-nav navbar-right" style="padding-right:300px ;">
						<li><a href="#" id="sosick"><img src="/sajin/bell.png"></a></li> <!-- 내소식 -->
						<li><a href="#" style="color: white;" id="myinfo">내정보</a></li> <!-- 영화 마이페이지 -->
						<li><a href="/moviefactory/member/logout" style="color: white;" class="logout123">로그아웃</a></li>
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">고객센터 <span class="caret"></span></a>
                    	<ul class="dropdown-menu">
                      		<li><a href="/moviefactory/adminAsk/listuser">문의 게시판</a></li>
                      		<li><a href="/moviefactory/notice/list">공지사항</a></li>
                    	</ul>
                  </li> 
					</ul>
				</div>
			</sec:authorize>


			<!--  관리자 : 2단 레이아웃 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div id="myNavbar">
					<ul class="nav navbar-nav navbar-right"
						style="padding-right:357.65px ;">
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">관리자<span class="caret"></span></a>
	    	                <ul class="dropdown-menu">
    	    	              <li><a href="/moviefactory/admin/blindcmntlist">블라인드댓글</a></li>
                	      	  <li><a href="/moviefactory/admin/blindrevlist">블라인드리뷰</a></li>
                    		  <li><a href="/moviefactory/admin/blocklist">영구정지</a></li>
                    		</ul>
	                    </li> 
						<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: white;">고객센터 <span class="caret"></span></a>
                    		<ul class="dropdown-menu">
	                	      <li><a href="/moviefactory/adminAsk/list">문의 게시판</a></li>
		                      <li><a href="/moviefactory/notice/list">공지사항</a></li>
        		            </ul>
            		    </li> 
						<li><a href="/moviefactory/member/logout" style="color: white;" class="logout123">로그아웃</a></li>

					</ul>
				</div>
			</sec:authorize>

		</div>

	</nav>
</body>
</html>
