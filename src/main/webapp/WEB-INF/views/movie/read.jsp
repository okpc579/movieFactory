<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ page session = "true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
<style>
#list table {
	border: 5px solid #00D8FF;
	width: 298px;
	table-layout: fixed;
}
</style>
<script>
	var movie;
	var m_no;
	var genre="";
	var actor="";
	var cast="";
	var $tr11;
	var $tr10;
	var $body;
	var collections;
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
			$("<td>").css("width","").text("장르 : "+genre).attr("class","m_info").appendTo($tr5);
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
					$("<img>").attr("src","/sajin/default_movie.png").attr("width", "120px").appendTo($td); 
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
				var $td = $("<td>").attr("class","m_info").appendTo($tr10);
				var $i = $("<i>").attr("class","fas fa-star").css("color","red").appendTo($td);
				//$("<td>").text("평점 : "+result).attr("class","m_info").appendTo($td);
				$("<span></span>").text(" 평점 : "  + result).css("color","black").appendTo($td);   // 평점
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
					$("#updateWrite").on("click", function() {
						if(isLogin==true){
							//console.log(mno);
							location.href="/moviefactory/movie/review/update?mno="+m_no;
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
		
		var param = {
				mNo : location.search.split("=")[1]
			};
		m_no=location.search.split("=")[1];
		$.ajax({
			url:"/moviefactory/api/collection/list",
			data:param,
			method: "get",
			success:function(result) {
				console.log("============================");
				console.log(result);
				console.log("============================");
				collections = result.collections;
				printData();
			}, error:function(xhr) {
		}
	});
		
		
	});
	
	

	
	
	
	
	function printData() {
		var $body = $("#list");
		
		$.each(collections, function(i, collection) {
			if(i==3){
				var plus = $("<a>").css("text-align","center").attr("href","/moviefactory/collection/list?mno="+ m_no + "&pageno=1").css("overflow","hidden").appendTo($body);
				$("<img>").attr("src","/sajin/plus.png").appendTo(plus);
				return false;
			}
			
			var $movies = $("#movies");
			var $movie = $("<span>").css("display", "inline-block").css("margin", "2px").appendTo($movies);   
			var $title = $("<div>").css("display", "inline-block").appendTo($movie);
			
			var $span = $("<span>");
			var $div = $("<div>").attr("class", "w3-third").css("display","inline-block").css("padding", "33px").appendTo($body); // .attr("class", "w3-third") 3x3 부트스트랩 클래스 지정
			var $table = $("<table>").css("width","250px").appendTo($div);
			var $tr = $("<tr>").appendTo($table);
			//$("<td colspan=2>").text(collection.writingDate + " 좋아요수 " + collection.collLikeCnt).css("padding", "10px").appendTo($tr); // 작성일
			$("<td>").text(collection.writingDate).css("padding", "10px").appendTo($tr);   
			var $td = $("<td>").appendTo($tr);
			var $i = $("<i>").attr("class","fab fa-gratipay").css("color","red").appendTo($td);	//별모양
			$("<span></span>").text(" " + collection.collLikeCnt).css("color","black").appendTo($td);   // 평점
			
			var $tr = $("<tr>").appendTo($table);
			var $td = $("<td colspan=2>").css("padding-left", "30px").css("padding-right", "30px").css("padding-top", "10px").css("padding-bottom", "10px").css("text-align", "center")
			.css("border-top", "solid 3px #00D8FF").css("border-bottom", "solid 3px #00D8FF").css("height","240px").appendTo($tr);
			$.ajax({
		          url: "/moviefactory/api/collection/collposter?collNo=" + collection.collNo,
		          method: "get",
		          success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
		          	// console.log(result.detail[0]);
		          if(typeof result.detail[0] =="undefined"){
		        	  $td.text("영화를 추가해주세요.");
		          }
		             $.each(result.detail, function(i, detail){
		         	 	$.ajax({
				 	    	url: "http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?key=147d96f90a50a05230287f0f02412bfd&movieCd=" + detail.mno,
				 	    	method: "get",
							success: function(result, status, xhr) { // 요청이 성공했을 때 수행되는 함수 뜻함(포스터,영화이름 가져옴)
				 	        	console.log(result);   // result 값을 출력
				 	        	getPoster2($(result).find('movieNm').text(), $(result).find('prdtYear').text(), $td);
				 	        }, error: function(xhr) {   // 에러발생시 
				 	             console.log(xhr.status);   // 오류번호 발생번호 출력
				 	        }
				 	    });
		             });
		          }, error: function(xhr) {   // 에러발생시 
		              console.log(xhr.status);   // 오류번호 발생번호 출력
		              console.log("오류");
		          }
		    });
			// .css("overflow","hidden").css("text-overflow","ellipsis").css("white-space","nowrap").css("width","50px")
			// text-overflow:ellipsis
			var $tr = $("<tr>").appendTo($table);
			$("<td colspan=2>").text(collection.collName).css("white-space","nowrap").css("overflow","hidden").css("text-overflow","ellipsis").css("padding", "10px").css("height","50px").appendTo($tr); // 콜렉션 이름
			var $tr = $("<tr>").appendTo($table);
			$("<td colspan=2>").text(collection.collIntro).css("white-space","nowrap").css("overflow","hidden").css("text-overflow","ellipsis").css("padding", "10px").css("height","50px").appendTo($tr); // 콜렉션 내용
			var $tr = $("<tr>").css("text-align", "center").appendTo($table);
			var $td2 = $("<td colspan=2>").css("padding", "10px").css("border-top", "solid 3px #00D8FF").appendTo($tr);
			$("<a>").attr("href", "/moviefactory/collection/read?collNo=" + collection.collNo + "&pageno=1").attr("class","btn").css("background-color","#00D8FF").css("color","black").text("상세 보기").appendTo($td2);	// 콜렉션 상세 링크
			// 상세, 열기, 읽기, 보기, 열람,  
		});
		
}
	
	function getPoster2(movieNm, prdtYear, $tr) {   // (영화제목,제작년도)로 포스터 불러오는 기능
			console.log("포스터함수실행");
		   console.log(movieNm);
		   console.log(prdtYear);
		   $.ajax({
		      url:"/moviefactory/api/image?subtitle=" + movieNm + "&pubData=" + prdtYear,
		      method: "get",
		      success:function(result) {
		         console.log(result.image);
		         //posterString = result.image;
		         if(typeof result.image == "undefined"){   // 이미지가 정해지지 않을 경우
		        	 console.log("디폴트이미지");
		         		
		            //var $td = $("<td>").appendTo($tr)   // td에 tr를 넣어라
		            $("<img>").attr("src","/sajin/default_movie.png").attr("height","100px").attr("width", "80px").appendTo($tr); 
		         }else {
		         	//var $td = $("<td>").appendTo($tr)   // 이미지가 들어있는 td를 tr에 넣어라
		         	$("<img>").attr("src",result.image).attr("height","100px").attr("width", "80px").appendTo($tr);   // result.image를 td안에 넣어라
		         	console.log("이미지들가냐");
		         //$("<td>").text(result.image).appendTo($tr);
		         }
		         
		      }, error:function(xhr) {
		         console.log(xhr);
		      }
		   });
		}
	
	
	
	
	
	
	
	
	
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
	}
	.m_info {
		font-size : 13pt;
		text-align : left;
		display: inline-block;
		width: 900px;
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
</style>
</head>
<body>
<div id="fuck">
<form action="/moviefactory/movie/review/write" method="get">
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
				<tr id="head_">
				
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
<div class="w3-row-padding" id="list">
			
</div>
</body>
</html>
