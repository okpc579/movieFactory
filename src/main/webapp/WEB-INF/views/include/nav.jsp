<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비팩토리 인덱스</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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

.bg-grey {
	background-color: #f6f6f6;
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
	color: #fff !important;
}

.navbar-nav li a:hover, .navbar-nav li.active a {
	color: #000000 !important;
	background-color: #fff !important;
}

.navbar-default .navbar-toggle {
	border-color: transparent;
	color: #fff !important;
}

/* div {
                display: inline-block;
            } */
#title {
	/* width: 20%; */
	width: 33%;
	overflow: hidden;
	/* display: inline-block; */
	float: left;
	margin: 0 auto;
}

#conooo {
	width: 100%;
	/* display: inline-block; */
}

#search {
	/* width: 40%; */
	width: 33%;
	margin: 0 auto;
	/* margin-left: auto; */
	/* margin-right: auto; */
	margin-top: 7px;
	/* overflow: hidden; */
	/* margin-bottom: 0 auto; */
	/* float: left; */
	/* margin-left: 0 auto; */
	display: inline-block;
}

#myNavbar {
	/* width: 19%; */
	width: 33%;
	overflow: hidden;
	float: right;
	margin: 0 auto;
	/* margin-left: auto; */
	/* display: inline-block; */
}

.navbar-brand {
	
}

.nav navbar-nav navbar-right {
	display: inline-block;
}

/* 2단 메뉴 */

.myNavbar{
border:none;
border:0px;
margin:0px;
padding:0px;
}

.myNavbar ul{
/* height:100px; */
list-style:none;
margin:0;
padding:0;
}

.myNavbar li{
float:left;
padding:0px;
}

.myNavbar li a{
display:block;
/* line-height:100px; */
margin:0px;
/* padding:0px 25px; */
text-align:center;
text-decoration:none;
}

.myNavbar li a:hover, .myNavbar ul li:hover a{
text-decoration:none;
}

.myNavbar li ul{
display:none;	/* 평상시에 안보이게 하는거 */
height:auto;
/* padding:0px; */	/* 추가해봄 */
/* margin:0px; */		/* 추가해봄 */
border:0px;
position:absolute;
width:200px;
z-index:200;
/*top:1em;
/*left:0;*/
}

.myNavbar li:hover ul{
display:block;	/* 마우스 올리면 나타나게하는거 */
}

.myNavbar li li {
display:block;
float:none;
margin:0px;
padding:0px;
/* width:200px; */
}

.myNavbar li:hover li a{
background:none;
}

.myNavbar li ul a{
display:block;
height:80px;
margin:0px;
padding:0px 10px 0px 15px;
text-align:left;
}

.myNavbar li ul a:hover, .myNavbar li ul li:hover a{
border:0px;
text-decoration:none;
}

.myNavbar p{
clear:left;
}

</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top"
		style="background-color: #4ABFD3">
		<div class="container" id="conooo">
			<div class="navbar-header" id="title">
				<div style="width: 100%; height: 100%;"></div>
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- <a class="navbar-brand" href="#myPage" style="float: right;">무비팩토리</a>  -->
				<a class="navbar-brand" href="http://localhost:8081/moviefactory/"
					style="padding-left: 381.5px;">무비팩토리</a>
			</div>
			<!-- 무비팩토리 : 홈화면 -->

			<!-- 검색 -->
			<div class="center text-center" id="search">
				<form class="form-inline" action="">
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
					<ul class="nav navbar-nav navbar-right"
						style="padding-right: 366.5px;">
						<li><a
							href="http://localhost:8081/moviefactory/member/yesorno">회원가입</a></li>
						<li><a href="http://localhost:8081/moviefactory/member/login">로그인</a></li>
						<li><a href="#" id="center">고객센터</a></li>
						<!-- 2단레이아웃 -->
						<ul>
						<li><a href="#">섭메뉴1</a></li>
						<li><a href="#">섭메뉴2</a></li>
						<li><a href="#">섭메뉴3</a></li>
						</ul>
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
					<ul class="nav navbar-nav navbar-right"
						style="padding-right: 366.5px;">
						<li><a href="#"><img src="/sajin/bell (5).png"></a></li>
						<!-- 내소식 -->
						<li><a href="#"></a>마이페이지</li>
						<!-- 영화 마이페이지 -->
						<li><a
							href="http://localhost:8081/moviefactory/member/logout">로그아웃</a></li>
						<li><a href="#portfolio">고객센터</a></li>
					</ul>
				</div>
			</sec:authorize>


			<!--  관리자 : 2단 레이아웃 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<div id="myNavbar">
					<ul class="nav navbar-nav navbar-right"
						style="padding-right: 366.5px;">
						<li>관리자센터</li>
						<!-- 2단 레이아웃 -->
						<li>고객센터</li>
						<!-- 2단 레이아웃 -->
						<li><a
							href="http://localhost:8081/moviefactory/member/logout">로그아웃</a></li>

					</ul>
				</div>
			</sec:authorize>

		</div>
	</nav>
</body>
</html>
